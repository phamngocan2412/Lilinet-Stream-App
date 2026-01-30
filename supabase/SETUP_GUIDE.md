# Database Setup Guide

## Bước 1: Tạo Database trong Supabase

1. Đăng nhập vào [Supabase Dashboard](https://app.supabase.io)
2. Chọn project của bạn
3. Vào **SQL Editor** (trong menu bên trái)
4. Copy và paste toàn bộ nội dung file `supabase/migrations/001_create_comments_schema.sql`
5. Click **Run** để tạo tất cả bảng

## Bước 2: Kiểm tra bảng đã tạo

Chạy query sau trong SQL Editor để kiểm tra:

```sql
-- Kiểm tra bảng comments
SELECT * FROM information_schema.tables 
WHERE table_schema = 'public' 
AND table_name IN ('comments', 'comment_likes', 'comment_dislikes', 'profiles', 'notifications');
```

## Bước 3: Test thêm comment

```sql
-- Test insert (thay 'your-user-uuid' bằng UUID user thật)
INSERT INTO public.comments (video_id, user_id, content, media_type)
VALUES ('test-video-123', 'your-user-uuid', 'Test comment', 'TV Series')
RETURNING *;
```

## Các cột quan trọng trong bảng `comments`:

| Cột | Mô tả |
|-----|-------|
| `video_id` | ID của phim/video |
| `media_type` | 'Movie' hoặc 'TV Series' - dùng cho navigation |
| `user_id` | UUID của user từ auth.users |
| `content` | Nội dung comment |
| `parent_id` | ID comment cha (cho reply) |
| `likes` | Số lượt like |
| `replies_count` | Số reply |
| `is_pinned` | Có ghim không |
| `is_edited` | Đã chỉnh sửa chưa |
| `is_deleted` | Đã xóa (soft delete) |

## Lỗi thường gặp:

### 1. "Could not find the table 'public.comments'"
→ Chưa chạy SQL script. Làm lại Bước 1.

### 2. "Could not find a relationship between 'comments' and 'profiles'"
→ Bảng profiles chưa có user. Đăng nhập lại app để auto-create profile.

### 3. "new row violates row-level security policy"
→ RLS policies đang chặn. Kiểm tra policies trong SQL Editor.

### 4. Comment không hiển thị sau khi gửi
→ Kiểm tra:
- Có lỗi trong logcat không?
- User đã đăng nhập chưa?
- `video_id` có đúng không?

## Enable Realtime (tùy chọn):

Để comments tự động cập nhật realtime:

```sql
-- Trong Supabase Dashboard > Database > Replication
-- Bật realtime cho bảng comments
alter publication supabase_realtime add table comments;
```

## Xóa tất cả data để test lại:

```sql
-- Cẩn thận! Xóa tất cả comments
DELETE FROM public.comment_likes;
DELETE FROM public.comment_dislikes;
DELETE FROM public.comments;
DELETE FROM public.notifications;
```

## Liên hệ hỗ trợ:

Nếu gặp lỗi khác, kiểm tra:
1. Logcat trong Android Studio
2. Supabase Logs (Dashboard > Logs)
3. RLS Policies (Dashboard > Database > Policies)
