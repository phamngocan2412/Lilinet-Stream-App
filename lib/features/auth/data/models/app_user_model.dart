import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/app_user.dart';

class AppUserModel extends AppUser {
  const AppUserModel({
    required super.id,
    required super.email,
    super.displayName,
    super.avatarUrl,
    super.createdAt,
  });

  factory AppUserModel.fromSupabaseUser(User user) {
    return AppUserModel(
      id: user.id,
      email: user.email ?? '',
      displayName: (user.userMetadata?['display_name'] as String?),
      avatarUrl: (user.userMetadata?['avatar_url'] as String?),
      createdAt:
          user.createdAt.isNotEmpty ? DateTime.tryParse(user.createdAt) : null,
    );
  }

  AppUser toEntity() {
    return AppUser(
      id: id,
      email: email,
      displayName: displayName,
      avatarUrl: avatarUrl,
      createdAt: createdAt,
    );
  }
}
