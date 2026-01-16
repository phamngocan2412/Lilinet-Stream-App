import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/app_theme.dart';
import 'routes/app_router.dart';
import 'injection_container.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/auth_event.dart';
import 'features/auth/presentation/bloc/auth_state.dart';
import 'features/favorites/presentation/bloc/favorites_bloc.dart';
import 'features/favorites/presentation/bloc/favorites_event.dart';
import 'features/settings/presentation/bloc/settings_bloc.dart';
import 'features/settings/presentation/bloc/settings_event.dart';
import 'features/settings/presentation/bloc/settings_state.dart';
import 'features/settings/domain/entities/app_settings.dart' as domain;
import 'features/video_player/presentation/bloc/video_player_bloc.dart';
import 'features/history/presentation/bloc/history_bloc.dart';
import 'features/main/presentation/bloc/navigation_cubit.dart'; // Added

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Auth BLoC - Available globally
        BlocProvider(
          create: (context) => getIt<AuthBloc>()..add(CheckAuthStatus()),
        ),
        // Favorites BLoC - Available globally
        BlocProvider(
          create: (context) => getIt<FavoritesBloc>()..add(LoadFavorites()),
        ),
        // History BLoC - Available globally (Added)
        BlocProvider(create: (context) => getIt<HistoryBloc>()..loadHistory()),
        // Settings BLoC - Available globally
        BlocProvider(
          create: (context) => getIt<SettingsBloc>()..add(LoadSettings()),
        ),
        // Video Player BLoC - Available globally
        BlocProvider<VideoPlayerBloc>(
          create: (context) => getIt<VideoPlayerBloc>(),
        ),
        // Navigation Cubit - Available globally
        BlocProvider(create: (context) => getIt<NavigationCubit>()),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            context.read<FavoritesBloc>().add(LoadFavorites());
          } else if (state is Unauthenticated) {
            context.read<FavoritesBloc>().add(ClearFavorites());
          }
        },
        child: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, settingsState) {
            ThemeMode themeMode = ThemeMode.system;

            if (settingsState is SettingsLoaded ||
                settingsState is SettingsSaved) {
              final settings = settingsState is SettingsLoaded
                  ? settingsState.settings
                  : (settingsState as SettingsSaved).settings;

              switch (settings.themeMode) {
                case domain.ThemeMode.light:
                  themeMode = ThemeMode.light;
                  break;
                case domain.ThemeMode.dark:
                  themeMode = ThemeMode.dark;
                  break;
                case domain.ThemeMode.system:
                  themeMode = ThemeMode.system;
                  break;
              }
            }

            return MaterialApp.router(
              title: 'Lilinet',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeMode,
              routerConfig: AppRouter.router,
            );
          },
        ),
      ),
    );
  }
}
