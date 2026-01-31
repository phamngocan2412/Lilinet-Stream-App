# Backend: Supabase Database Schema

## 1. Tổng Quan

Supabase được sử dụng cho:
- **Authentication** - Quản lý users
- **Database** - PostgreSQL cho comments, favorites, history
- **Real-time** - Live updates (planned)
- **Storage** - Avatar uploads (future)

## 2. Database Schema

### 2.1 ERD Diagram

```
┌─────────────────┐       ┌─────────────────┐
│   auth.users    │       │    profiles     │
│─────────────────│       │─────────────────│
│ id (PK)         │◄──────│ id (PK, FK)     │
│ email           │       │ user_name       │
│ created_at      │       │ avatar_url      │
└─────────────────┘       │ created_at      │
        │                 └─────────────────┘
        │
        │           ┌─────────────────┐
        │           │    comments     │
        │           │─────────────────│
        ├──────────►│ id (PK)         │
        │           │ user_id (FK)    │
        │           │ video_id        │
        │           │ content         │
        │           │ parent_id (FK)  │◄──┐
        │           │ likes           │   │
        │           │ created_at      │   │
        │           └─────────────────┘   │
        │                   │             │
        │                   └─────────────┘
        │
        │           ┌─────────────────┐
        │           │ comment_likes   │
        ├──────────►│─────────────────│
        │           │ comment_id (FK) │
        │           │ user_id (FK)    │
        │           │ created_at      │
        │           └─────────────────┘
        │
        │           ┌─────────────────┐
        │           │   favorites     │
        ├──────────►│─────────────────│
        │           │ id (PK)         │
        │           │ user_id (FK)    │
        │           │ movie_id        │
        │           │ movie_data      │
        │           │ added_at        │
        │           └─────────────────┘
        │
        │           ┌─────────────────┐
        │           │ watch_history   │
        └──────────►│─────────────────│
                    │ id (PK)         │
                    │ user_id (FK)    │
                    │ video_id        │
                    │ position_secs   │
                    │ duration_secs   │
                    │ last_watched    │
                    └─────────────────┘
```

## 3. Table Definitions

### 3.1 profiles
```sql
CREATE TABLE profiles (
  id UUID REFERENCES auth.users(id) ON DELETE CASCADE PRIMARY KEY,
  user_name TEXT,
  avatar_url TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE
);

-- Trigger to auto-create profile on signup
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id, user_name, avatar_url)
  VALUES (
    NEW.id,
    COALESCE(NEW.raw_user_meta_data->>'user_name', 'User'),
    NEW.raw_user_meta_data->>'avatar_url'
  );
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();
```

### 3.2 comments
```sql
CREATE TABLE comments (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  video_id TEXT NOT NULL,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  content TEXT NOT NULL,
  parent_id UUID REFERENCES comments(id) ON DELETE CASCADE,
  likes INTEGER DEFAULT 0,
  dislikes INTEGER DEFAULT 0,
  replies_count INTEGER DEFAULT 0,
  media_type TEXT, -- 'movie', 'tv', 'anime'
  is_edited BOOLEAN DEFAULT false,
  is_deleted BOOLEAN DEFAULT false,
  is_pinned BOOLEAN DEFAULT false,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE
);

-- Indexes
CREATE INDEX idx_comments_video_id ON comments(video_id);
CREATE INDEX idx_comments_user_id ON comments(user_id);
CREATE INDEX idx_comments_parent_id ON comments(parent_id);
CREATE INDEX idx_comments_created_at ON comments(created_at DESC);
```

### 3.3 comment_likes
```sql
CREATE TABLE comment_likes (
  comment_id UUID REFERENCES comments(id) ON DELETE CASCADE,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  PRIMARY KEY (comment_id, user_id)
);

-- Function to update likes count
CREATE OR REPLACE FUNCTION update_comment_likes_count()
RETURNS TRIGGER AS $$
BEGIN
  IF TG_OP = 'INSERT' THEN
    UPDATE comments SET likes = likes + 1 WHERE id = NEW.comment_id;
  ELSIF TG_OP = 'DELETE' THEN
    UPDATE comments SET likes = likes - 1 WHERE id = OLD.comment_id;
  END IF;
  RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER on_comment_like_change
  AFTER INSERT OR DELETE ON comment_likes
  FOR EACH ROW EXECUTE FUNCTION update_comment_likes_count();
```

### 3.4 favorites
```sql
CREATE TABLE favorites (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  movie_id TEXT NOT NULL,
  movie_data JSONB NOT NULL, -- Cached movie info
  added_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(user_id, movie_id)
);

CREATE INDEX idx_favorites_user_id ON favorites(user_id);
CREATE INDEX idx_favorites_added_at ON favorites(added_at DESC);
```

### 3.5 watch_history
```sql
CREATE TABLE watch_history (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  video_id TEXT NOT NULL,
  movie_id TEXT NOT NULL,
  episode_id TEXT,
  position_seconds INTEGER DEFAULT 0,
  duration_seconds INTEGER,
  last_watched TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  movie_data JSONB, -- Cached movie info
  UNIQUE(user_id, video_id)
);

CREATE INDEX idx_watch_history_user_id ON watch_history(user_id);
CREATE INDEX idx_watch_history_last_watched ON watch_history(last_watched DESC);
```

## 4. Row Level Security (RLS)

### 4.1 profiles
```sql
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;

-- Anyone can read profiles
CREATE POLICY "Profiles are viewable by everyone"
  ON profiles FOR SELECT
  USING (true);

-- Users can update own profile
CREATE POLICY "Users can update own profile"
  ON profiles FOR UPDATE
  USING (auth.uid() = id);
```

### 4.2 comments
```sql
ALTER TABLE comments ENABLE ROW LEVEL SECURITY;

-- Anyone can read non-deleted comments
CREATE POLICY "Comments are viewable by everyone"
  ON comments FOR SELECT
  USING (is_deleted = false);

-- Authenticated users can insert
CREATE POLICY "Authenticated users can insert comments"
  ON comments FOR INSERT
  WITH CHECK (auth.uid() = user_id);

-- Users can update own comments
CREATE POLICY "Users can update own comments"
  ON comments FOR UPDATE
  USING (auth.uid() = user_id);

-- Users can soft-delete own comments
CREATE POLICY "Users can delete own comments"
  ON comments FOR DELETE
  USING (auth.uid() = user_id);
```

### 4.3 comment_likes
```sql
ALTER TABLE comment_likes ENABLE ROW LEVEL SECURITY;

-- Anyone can read likes
CREATE POLICY "Likes are viewable by everyone"
  ON comment_likes FOR SELECT
  USING (true);

-- Authenticated users can like
CREATE POLICY "Authenticated users can like"
  ON comment_likes FOR INSERT
  WITH CHECK (auth.uid() = user_id);

-- Users can unlike
CREATE POLICY "Users can unlike"
  ON comment_likes FOR DELETE
  USING (auth.uid() = user_id);
```

### 4.4 favorites & watch_history
```sql
-- Favorites
ALTER TABLE favorites ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can manage own favorites"
  ON favorites FOR ALL
  USING (auth.uid() = user_id);

-- Watch History
ALTER TABLE watch_history ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can manage own history"
  ON watch_history FOR ALL
  USING (auth.uid() = user_id);
```

## 5. Functions & Triggers

### 5.1 Update replies_count
```sql
CREATE OR REPLACE FUNCTION update_replies_count()
RETURNS TRIGGER AS $$
BEGIN
  IF TG_OP = 'INSERT' AND NEW.parent_id IS NOT NULL THEN
    UPDATE comments SET replies_count = replies_count + 1 
    WHERE id = NEW.parent_id;
  ELSIF TG_OP = 'DELETE' AND OLD.parent_id IS NOT NULL THEN
    UPDATE comments SET replies_count = replies_count - 1 
    WHERE id = OLD.parent_id;
  END IF;
  RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER on_reply_change
  AFTER INSERT OR DELETE ON comments
  FOR EACH ROW EXECUTE FUNCTION update_replies_count();
```

### 5.2 Get Trending Comments
```sql
CREATE OR REPLACE FUNCTION get_trending_comments(limit_count INTEGER DEFAULT 5)
RETURNS SETOF comments AS $$
BEGIN
  RETURN QUERY
  SELECT * FROM comments
  WHERE parent_id IS NULL
    AND is_deleted = false
    AND created_at > NOW() - INTERVAL '7 days'
  ORDER BY likes DESC, created_at DESC
  LIMIT limit_count;
END;
$$ LANGUAGE plpgsql;
```

## 6. Real-time Subscriptions (Planned)

```sql
-- Enable realtime for comments
ALTER PUBLICATION supabase_realtime ADD TABLE comments;
ALTER PUBLICATION supabase_realtime ADD TABLE comment_likes;
```

**Flutter implementation:**
```dart
supabase
  .channel('comments:video_id=eq.$videoId')
  .on(
    RealtimeListenTypes.postgresChanges,
    ChannelFilter(
      event: '*',
      schema: 'public',
      table: 'comments',
      filter: 'video_id=eq.$videoId',
    ),
    (payload, [ref]) {
      // Handle new/updated comment
    },
  )
  .subscribe();
```

## 7. Migration Script

```sql
-- Run this in Supabase SQL Editor to set up all tables

-- 1. Create tables (run in order)
-- profiles -> comments -> comment_likes -> favorites -> watch_history

-- 2. Enable RLS on all tables

-- 3. Create policies

-- 4. Create triggers
```

## 8. Backup & Maintenance

### Backup
```bash
# Using Supabase CLI
supabase db dump -f backup.sql
```

### Restore
```bash
supabase db reset
psql -f backup.sql
```

---

*Document Version: 1.0*
*Last Updated: January 2026*
