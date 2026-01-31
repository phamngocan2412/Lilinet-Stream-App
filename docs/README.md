# Lilinet App Documentation

Thư mục này chứa tài liệu chi tiết về dự án Lilinet App - ứng dụng xem phim Flutter.

## 📚 Danh Sách Tài Liệu

### 1. [00_HE_THONG_TONG_QUAN.md](00_HE_THONG_TONG_QUAN.md)
**Tổng quan hệ thống**
- Giới thiệu dự án
- Kiến trúc Clean Architecture
- Tech stack và dependencies
- Navigation structure
- Database schema tổng quan

### 2. [01_AUTH.md](01_AUTH.md)
**Feature: Authentication**
- Đăng nhập/đăng ký/đăng xuất
- Supabase Auth integration
- Guest mode support
- State management (AuthBloc)
- Sơ đồ sequence & activity

### 3. [02_MOVIES_SEARCH.md](02_MOVIES_SEARCH.md)
**Feature: Movies & Search**
- Trending movies
- Search functionality
- Movie details
- Consumet API integration
- Caching strategy

### 4. [03_VIDEO_PLAYER.md](03_VIDEO_PLAYER.md)
**Feature: Video Player**
- MediaKit integration
- Miniplayer mode
- Custom controls
- Gestures & subtitles
- Background playback

### 5. [04_COMMENTS.md](04_COMMENTS.md)
**Feature: Comments**
- Comment system với replies
- Like/unlike functionality
- Trending comments
- Guest comments support
- Supabase real-time (planned)

### 6. [05_FAVORITES_HISTORY.md](05_FAVORITES_HISTORY.md)
**Feature: Favorites & History**
- Danh sách yêu thích
- Lịch sử xem phim
- Watch progress tracking
- Continue watching

### 7. [06_EXPLORE_SETTINGS.md](06_EXPLORE_SETTINGS.md)
**Feature: Explore & Settings**
- Khám phá thể loại (genres)
- Filter & sort options
- App settings (theme, language)
- Cache management

### 8. [07_CONSUMET_API.md](07_CONSUMET_API.md) 🎬 **QUAN TRỌNG**
**Backend: Consumet API (Movie Data)**
- Giới thiệu Consumet API
- Các providers (Goku, FlixHQ, DramaCool)
- Endpoints chi tiết (trending, search, info, watch)
- Caching & error handling
- Self-hosting guide
- Rate limiting & best practices

### 9. [08_SUPABASE_SCHEMA.md](08_SUPABASE_SCHEMA.md) 🗄️ **NEW**
**Backend: Supabase Database Schema**
- ERD Diagram
- Table definitions (SQL)
- Row Level Security (RLS) policies
- Functions & Triggers
- Real-time subscriptions
- Migration scripts

### 10. [09_SETUP_GUIDE.md](09_SETUP_GUIDE.md) 🛠️ **NEW**
**Environment Setup Guide**
- Prerequisites & software
- Project setup
- .env configuration
- Supabase setup
- Consumet API setup
- Common issues & solutions

### 11. [99_THIEU_GI_CAN_LAM.md](99_THIEU_GI_CAN_LAM.md) ⚠️ **QUAN TRỌNG NHẤT**
**Tổng hợp những gì đang thiếu**
- Các feature cần làm ngay (High Priority)
- Medium & Low priority features
- Known bugs & issues
- Technical debt
- Recommended roadmap
- Quick wins

## 🗺 Cách Sử Dụng

1. **Người mới bắt đầu:** Đọc [00_HE_THONG_TONG_QUAN.md](00_HE_THONG_TONG_QUAN.md) trước
2. **Developer:** Xem feature cụ thể trong các file 01-06
3. **Project Manager/Product Owner:** Tập trung vào [99_THIEU_GI_CAN_LAM.md](99_THIEU_GI_CAN_LAM.md)

## 🔗 Mermaid Diagrams

Các file tài liệu chứa sơ đồ Mermaid. Để xem:
- Trên GitHub: Tự động render
- VS Code: Cài extension "Markdown Preview Mermaid Support"
- Online: [Mermaid Live Editor](https://mermaid.live)

## 📝 Conventions

- Mỗi feature có file riêng
- Sequence diagrams cho use cases chính
- Activity diagrams cho user flows
- Code snippets minh họa
- Checklist những gì còn thiếu

## 🔄 Maintenance

Tài liệu này cần được cập nhật khi:
- Thêm feature mới
- Thay đổi architecture
- Refactor codebase
- Fix bugs quan trọng

**Last updated:** January 2026
