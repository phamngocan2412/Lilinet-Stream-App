import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'core/supabase/supabase_config.dart';
import 'app.dart';
import 'features/history/presentation/bloc/history_bloc.dart';
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize MediaKit
  MediaKit.ensureInitialized();

  // Initialize Supabase
  await SupabaseConfig.initialize();

  // Initialize Dependency Injection
  await configureDependencies();

  // Load Watch History immediately
  getIt<HistoryBloc>().loadHistory();

  runApp(const MyApp());
}
