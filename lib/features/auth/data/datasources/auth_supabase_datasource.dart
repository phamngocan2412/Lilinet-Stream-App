import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/app_user_model.dart';

@lazySingleton
class AuthSupabaseDataSource {
  final SupabaseClient supabaseClient;

  AuthSupabaseDataSource(this.supabaseClient);

  Future<AppUserModel> signInWithEmail({
    required String email,
    required String password,
  }) async {
    final response = await supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );

    if (response.user == null) {
      throw Exception('Sign in failed');
    }

    return AppUserModel.fromSupabaseUser(response.user!);
  }

  Future<AppUserModel> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  }) async {
    final response = await supabaseClient.auth.signUp(
      email: email,
      password: password,
      data: displayName != null ? {'display_name': displayName} : null,
    );

    if (response.user == null) {
      throw Exception('Sign up failed');
    }

    return AppUserModel.fromSupabaseUser(response.user!);
  }

  Future<void> signOut() async {
    await supabaseClient.auth.signOut();
  }

  Future<AppUserModel?> getCurrentUser() async {
    final user = supabaseClient.auth.currentUser;
    if (user == null) return null;
    return AppUserModel.fromSupabaseUser(user);
  }

  Stream<AppUserModel?> get authStateChanges {
    return supabaseClient.auth.onAuthStateChange.map((event) {
      final user = event.session?.user;
      if (user == null) return null;
      return AppUserModel.fromSupabaseUser(user);
    });
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await supabaseClient.auth.resetPasswordForEmail(email);
  }

  Future<AppUserModel> updateProfile({
    String? displayName,
    String? avatarUrl,
  }) async {
    final user = supabaseClient.auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    final updates = UserAttributes(
      data: {'display_name': displayName, 'avatar_url': avatarUrl},
    );

    final response = await supabaseClient.auth.updateUser(updates);
    if (response.user == null) throw Exception('Update profile failed');

    return AppUserModel.fromSupabaseUser(response.user!);
  }

  Future<void> changePassword(String newPassword) async {
    final user = supabaseClient.auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    await supabaseClient.auth.updateUser(UserAttributes(password: newPassword));
  }

  Future<void> deleteAccount() async {
    final user = supabaseClient.auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    // Note: Supabase Client SDK doesn't always allow self-deletion depending on config.
    // Usually requires an Edge Function or RPC.
    // However, for standard implementation we try the admin API if available or use an RPC.
    // Since we don't have the admin key here, we'll assume there is an RPC 'delete_user'
    // OR we rely on standard auth policies.
    // Actually, supabase-flutter doesn't have a direct deleteUser() for self.
    // It's usually handled by calling an RPC function.
    // For now, we will assume a backend function exists or use a workaround if needed.
    // Workaround: Call an RPC function defined in Supabase
    try {
      await supabaseClient.rpc('delete_user_account');
    } catch (e) {
      // Fallback: If RPC doesn't exist, we might need to instruct user to contact support
      // or implement the SQL function.
      throw Exception('Could not delete account. Please contact support.');
    }

    await signOut();
  }
}
