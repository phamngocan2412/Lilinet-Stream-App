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
}
