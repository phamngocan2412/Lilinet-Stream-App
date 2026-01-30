-- Supabase Database Schema for Comments System - COMPLETE VERSION
-- Run this in Supabase SQL Editor

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ============================================================================
-- TABLES
-- ============================================================================

-- Comments table
CREATE TABLE IF NOT EXISTS public.comments (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    video_id TEXT NOT NULL,
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    content TEXT NOT NULL,
    parent_id UUID REFERENCES public.comments(id) ON DELETE CASCADE,
    media_type TEXT DEFAULT 'TV Series',
    likes INTEGER DEFAULT 0,
    dislikes INTEGER DEFAULT 0,
    replies_count INTEGER DEFAULT 0,
    is_edited BOOLEAN DEFAULT false,
    is_pinned BOOLEAN DEFAULT false,
    is_deleted BOOLEAN DEFAULT false,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Comment likes table
CREATE TABLE IF NOT EXISTS public.comment_likes (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    comment_id UUID NOT NULL REFERENCES public.comments(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(comment_id, user_id)
);

-- Comment dislikes table
CREATE TABLE IF NOT EXISTS public.comment_dislikes (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    comment_id UUID NOT NULL REFERENCES public.comments(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(comment_id, user_id)
);

-- Profiles table
CREATE TABLE IF NOT EXISTS public.profiles (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    user_name TEXT NOT NULL,
    avatar_url TEXT,
    bio TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Notifications table for reply mentions
CREATE TABLE IF NOT EXISTS public.notifications (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    type TEXT NOT NULL, -- 'reply', 'like', 'mention'
    comment_id UUID REFERENCES public.comments(id) ON DELETE CASCADE,
    from_user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    content TEXT,
    is_read BOOLEAN DEFAULT false,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Rate limiting table to prevent spam
CREATE TABLE IF NOT EXISTS public.comment_rate_limits (
    user_id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    comment_count INTEGER DEFAULT 0,
    reset_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ============================================================================
-- FUNCTIONS
-- ============================================================================

-- Function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Function to update likes count
CREATE OR REPLACE FUNCTION update_likes_count()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        UPDATE public.comments 
        SET likes = likes + 1 
        WHERE id = NEW.comment_id;
    ELSIF TG_OP = 'DELETE' THEN
        UPDATE public.comments 
        SET likes = GREATEST(likes - 1, 0)
        WHERE id = OLD.comment_id;
    END IF;
    RETURN COALESCE(NEW, OLD);
END;
$$ LANGUAGE plpgsql;

-- Function to update dislikes count
CREATE OR REPLACE FUNCTION update_dislikes_count()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        UPDATE public.comments 
        SET dislikes = dislikes + 1 
        WHERE id = NEW.comment_id;
    ELSIF TG_OP = 'DELETE' THEN
        UPDATE public.comments 
        SET dislikes = GREATEST(dislikes - 1, 0)
        WHERE id = OLD.comment_id;
    END IF;
    RETURN COALESCE(NEW, OLD);
END;
$$ LANGUAGE plpgsql;

-- Function to update replies count
CREATE OR REPLACE FUNCTION update_replies_count()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' AND NEW.parent_id IS NOT NULL THEN
        UPDATE public.comments 
        SET replies_count = replies_count + 1 
        WHERE id = NEW.parent_id;
        
        -- Create notification for reply
        INSERT INTO public.notifications (user_id, type, comment_id, from_user_id, content)
        SELECT 
            c.user_id,
            'reply',
            NEW.id,
            NEW.user_id,
            substring(NEW.content from 1 for 100)
        FROM public.comments c
        WHERE c.id = NEW.parent_id
        AND c.user_id != NEW.user_id;
    ELSIF TG_OP = 'DELETE' AND OLD.parent_id IS NOT NULL THEN
        UPDATE public.comments 
        SET replies_count = GREATEST(replies_count - 1, 0)
        WHERE id = OLD.parent_id;
    END IF;
    RETURN COALESCE(NEW, OLD);
END;
$$ LANGUAGE plpgsql;

-- Function to handle new user signup
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO public.profiles (id, user_name, avatar_url)
    VALUES (
        NEW.id,
        COALESCE(
            NEW.raw_user_meta_data->>'user_name',
            NEW.raw_user_meta_data->>'full_name',
            NEW.email,
            'User_' || substr(NEW.id::text, 1, 8)
        ),
        COALESCE(
            NEW.raw_user_meta_data->>'avatar_url',
            'https://ui-avatars.com/api/?name=' || 
            COALESCE(
                NEW.raw_user_meta_data->>'user_name',
                NEW.raw_user_meta_data->>'full_name',
                'User'
            ) || 
            '&background=random'
        )
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Function to mark comment as edited
CREATE OR REPLACE FUNCTION mark_comment_as_edited()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.content IS DISTINCT FROM NEW.content THEN
        NEW.is_edited = true;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Function to check rate limit before inserting comment
CREATE OR REPLACE FUNCTION check_comment_rate_limit()
RETURNS TRIGGER AS $$
DECLARE
    current_count INTEGER;
    last_reset TIMESTAMP WITH TIME ZONE;
BEGIN
    -- Get or create rate limit record
    SELECT comment_count, reset_at INTO current_count, last_reset
    FROM public.comment_rate_limits
    WHERE user_id = NEW.user_id;
    
    -- If no record exists, create one
    IF current_count IS NULL THEN
        INSERT INTO public.comment_rate_limits (user_id, comment_count, reset_at)
        VALUES (NEW.user_id, 1, NOW());
        RETURN NEW;
    END IF;
    
    -- Reset count if 1 hour has passed
    IF last_reset < NOW() - INTERVAL '1 hour' THEN
        UPDATE public.comment_rate_limits
        SET comment_count = 1, reset_at = NOW()
        WHERE user_id = NEW.user_id;
        RETURN NEW;
    END IF;
    
    -- Check limit (30 comments per hour)
    IF current_count >= 30 THEN
        RAISE EXCEPTION 'Rate limit exceeded: Maximum 30 comments per hour';
    END IF;
    
    -- Increment count
    UPDATE public.comment_rate_limits
    SET comment_count = comment_count + 1
    WHERE user_id = NEW.user_id;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Function to cleanup old deleted comments
CREATE OR REPLACE FUNCTION cleanup_old_deleted_comments()
RETURNS void AS $$
BEGIN
    DELETE FROM public.comments
    WHERE is_deleted = true 
    AND updated_at < NOW() - INTERVAL '30 days';
END;
$$ LANGUAGE plpgsql;

-- ============================================================================
-- TRIGGERS
-- ============================================================================

-- Trigger for comments updated_at
DROP TRIGGER IF EXISTS update_comments_updated_at ON public.comments;
CREATE TRIGGER update_comments_updated_at
    BEFORE UPDATE ON public.comments
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- Trigger for profiles updated_at
DROP TRIGGER IF EXISTS update_profiles_updated_at ON public.profiles;
CREATE TRIGGER update_profiles_updated_at
    BEFORE UPDATE ON public.profiles
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- Trigger for marking comment as edited
DROP TRIGGER IF EXISTS mark_comment_edited ON public.comments;
CREATE TRIGGER mark_comment_edited
    BEFORE UPDATE ON public.comments
    FOR EACH ROW
    EXECUTE FUNCTION mark_comment_as_edited();

-- Trigger for likes count
DROP TRIGGER IF EXISTS likes_count_trigger ON public.comment_likes;
CREATE TRIGGER likes_count_trigger
    AFTER INSERT OR DELETE ON public.comment_likes
    FOR EACH ROW
    EXECUTE FUNCTION update_likes_count();

-- Trigger for dislikes count
DROP TRIGGER IF EXISTS dislikes_count_trigger ON public.comment_dislikes;
CREATE TRIGGER dislikes_count_trigger
    AFTER INSERT OR DELETE ON public.comment_dislikes
    FOR EACH ROW
    EXECUTE FUNCTION update_dislikes_count();

-- Trigger for replies count and notifications
DROP TRIGGER IF EXISTS replies_count_trigger ON public.comments;
CREATE TRIGGER replies_count_trigger
    AFTER INSERT OR DELETE ON public.comments
    FOR EACH ROW
    EXECUTE FUNCTION update_replies_count();

-- Trigger for rate limiting
DROP TRIGGER IF EXISTS check_rate_limit ON public.comments;
CREATE TRIGGER check_rate_limit
    BEFORE INSERT ON public.comments
    FOR EACH ROW
    EXECUTE FUNCTION check_comment_rate_limit();

-- Trigger for new user signup
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
    AFTER INSERT ON auth.users
    FOR EACH ROW
    EXECUTE FUNCTION public.handle_new_user();

-- ============================================================================
-- ROW LEVEL SECURITY (RLS) POLICIES (UPDATED)
-- ============================================================================

-- Enable RLS on all tables
ALTER TABLE public.comments ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.comment_likes ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.comment_dislikes ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.notifications ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.comment_rate_limits ENABLE ROW LEVEL SECURITY;

-- 1. Comments policies
DROP POLICY IF EXISTS "comments_select_policy" ON public.comments;
CREATE POLICY "comments_select_policy" ON public.comments FOR SELECT USING (true);

DROP POLICY IF EXISTS "comments_insert_policy" ON public.comments;
CREATE POLICY "comments_insert_policy" ON public.comments FOR INSERT WITH CHECK (auth.role() = 'authenticated' AND auth.uid() = user_id);

DROP POLICY IF EXISTS "comments_update_policy" ON public.comments;
CREATE POLICY "comments_update_policy" ON public.comments FOR UPDATE USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);

DROP POLICY IF EXISTS "comments_delete_policy" ON public.comments;
CREATE POLICY "comments_delete_policy" ON public.comments FOR DELETE USING (auth.uid() = user_id);

-- 2. Comment likes policies
DROP POLICY IF EXISTS "comment_likes_select_policy" ON public.comment_likes;
CREATE POLICY "comment_likes_select_policy" ON public.comment_likes FOR SELECT USING (true);

DROP POLICY IF EXISTS "comment_likes_insert_policy" ON public.comment_likes;
CREATE POLICY "comment_likes_insert_policy" ON public.comment_likes FOR INSERT WITH CHECK (auth.role() = 'authenticated' AND auth.uid() = user_id);

DROP POLICY IF EXISTS "comment_likes_delete_policy" ON public.comment_likes;
CREATE POLICY "comment_likes_delete_policy" ON public.comment_likes FOR DELETE USING (auth.uid() = user_id);

-- 3. Comment dislikes policies
DROP POLICY IF EXISTS "comment_dislikes_select_policy" ON public.comment_dislikes;
CREATE POLICY "comment_dislikes_select_policy" ON public.comment_dislikes FOR SELECT USING (true);

DROP POLICY IF EXISTS "comment_dislikes_insert_policy" ON public.comment_dislikes;
CREATE POLICY "comment_dislikes_insert_policy" ON public.comment_dislikes FOR INSERT WITH CHECK (auth.role() = 'authenticated' AND auth.uid() = user_id);

DROP POLICY IF EXISTS "comment_dislikes_delete_policy" ON public.comment_dislikes;
CREATE POLICY "comment_dislikes_delete_policy" ON public.comment_dislikes FOR DELETE USING (auth.uid() = user_id);

-- 4. Profiles policies
DROP POLICY IF EXISTS "profiles_select_policy" ON public.profiles;
CREATE POLICY "profiles_select_policy" ON public.profiles FOR SELECT USING (true);

DROP POLICY IF EXISTS "profiles_insert_policy" ON public.profiles;
CREATE POLICY "profiles_insert_policy" ON public.profiles FOR INSERT WITH CHECK (auth.role() = 'authenticated' AND auth.uid() = id);

DROP POLICY IF EXISTS "profiles_update_policy" ON public.profiles;
CREATE POLICY "profiles_update_policy" ON public.profiles FOR UPDATE USING (auth.uid() = id) WITH CHECK (auth.uid() = id);

-- 5. Notifications policies
DROP POLICY IF EXISTS "notifications_select_policy" ON public.notifications;
CREATE POLICY "notifications_select_policy" ON public.notifications FOR SELECT USING (auth.uid() = user_id);

DROP POLICY IF EXISTS "notifications_insert_policy" ON public.notifications;
CREATE POLICY "notifications_insert_policy" ON public.notifications FOR INSERT WITH CHECK (auth.role() = 'authenticated');

DROP POLICY IF EXISTS "notifications_update_policy" ON public.notifications;
CREATE POLICY "notifications_update_policy" ON public.notifications FOR UPDATE USING (auth.uid() = user_id);

-- 6. Rate limits policies
DROP POLICY IF EXISTS "rate_limits_select_policy" ON public.comment_rate_limits;
CREATE POLICY "rate_limits_select_policy" ON public.comment_rate_limits FOR SELECT USING (auth.uid() = user_id);
-- ============================================================================
-- INDEXES
-- ============================================================================

-- Indexes for comments table
CREATE INDEX IF NOT EXISTS idx_comments_video_id ON public.comments(video_id);
CREATE INDEX IF NOT EXISTS idx_comments_parent_id ON public.comments(parent_id);
CREATE INDEX IF NOT EXISTS idx_comments_user_id ON public.comments(user_id);
CREATE INDEX IF NOT EXISTS idx_comments_created_at ON public.comments(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_comments_is_deleted ON public.comments(is_deleted);
CREATE INDEX IF NOT EXISTS idx_comments_video_parent ON public.comments(video_id, parent_id);

-- Indexes for comment_likes table
CREATE INDEX IF NOT EXISTS idx_comment_likes_comment_id ON public.comment_likes(comment_id);
CREATE INDEX IF NOT EXISTS idx_comment_likes_user_id ON public.comment_likes(user_id);

-- Indexes for comment_dislikes table
CREATE INDEX IF NOT EXISTS idx_comment_dislikes_comment_id ON public.comment_dislikes(comment_id);
CREATE INDEX IF NOT EXISTS idx_comment_dislikes_user_id ON public.comment_dislikes(user_id);

-- Indexes for profiles table
CREATE INDEX IF NOT EXISTS idx_profiles_user_name ON public.profiles(user_name);

-- Indexes for notifications table
CREATE INDEX IF NOT EXISTS idx_notifications_user_id ON public.notifications(user_id);
CREATE INDEX IF NOT EXISTS idx_notifications_is_read ON public.notifications(is_read);
CREATE INDEX IF NOT EXISTS idx_notifications_created_at ON public.notifications(created_at DESC);

-- ============================================================================
-- SCHEDULED CLEANUP (RUN ONCE TO SETUP)
-- ============================================================================

-- To run cleanup daily, execute this in Supabase:
-- SELECT cron.schedule('cleanup-deleted-comments', '0 0 * * *', 'SELECT cleanup_old_deleted_comments()');

-- ============================================================================
-- HELPFUL QUERIES (COMMENTED OUT - FOR REFERENCE)
-- ============================================================================

-- Get all comments for a video with user info (top-level only)
-- SELECT 
--     c.*,
--     p.user_name,
--     p.avatar_url,
--     EXISTS(SELECT 1 FROM comment_likes WHERE comment_id = c.id AND user_id = auth.uid()) as user_liked,
--     EXISTS(SELECT 1 FROM comment_dislikes WHERE comment_id = c.id AND user_id = auth.uid()) as user_disliked
-- FROM comments c
-- JOIN profiles p ON c.user_id = p.id
-- WHERE c.video_id = 'YOUR_VIDEO_ID' 
--   AND c.parent_id IS NULL 
--   AND c.is_deleted = false
-- ORDER BY c.is_pinned DESC, c.created_at DESC;

-- Get unread notification count
-- SELECT COUNT(*) 
-- FROM notifications 
-- WHERE user_id = auth.uid() 
--   AND is_read = false;
