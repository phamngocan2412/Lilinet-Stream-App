import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lilinet_app/l10n/app_localizations.dart';
import 'core/extensions/settings_state_extension.dart';
import 'core/theme/app_theme.dart';
import 'core/network/network_cubit.dart';
import 'core/widgets/offline_banner.dart';
import 'routes/app_router.dart';
import 'injection_container.dart';
import 'features/movies/presentation/bloc/trending_movies/trending_movies_bloc.dart';
import 'features/explore/presentation/bloc/explore_bloc.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/auth_event.dart';
import 'features/auth/presentation/bloc/auth_state.dart';
import 'features/favorites/presentation/bloc/favorites_bloc.dart';
import 'features/favorites/presentation/bloc/favorites_event.dart';
import 'features/settings/presentation/bloc/settings_bloc.dart';
import 'features/settings/presentation/bloc/settings_event.dart';
import 'features/settings/presentation/bloc/settings_state.dart';
import 'features/video_player/presentation/bloc/video_player_bloc.dart';
import 'features/history/presentation/bloc/history_bloc.dart';
import 'features/main/presentation/bloc/navigation_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Auth BLoC - Available globally
        BlocProvider(
          create: (context) => getIt<AuthBloc>()..add(const CheckAuthStatus()),
        ),
        // Favorites BLoC - Available globally
        BlocProvider(
          create: (context) =>
              getIt<FavoritesBloc>()..add(const LoadFavorites()),
        ),
        // History BLoC
        BlocProvider.value(value: getIt<HistoryBloc>()),
        // Trending Movies BLoC
        BlocProvider.value(value: getIt<TrendingMoviesBloc>()),
        // Explore BLoC
        BlocProvider.value(value: getIt<ExploreBloc>()),
        // Settings BLoC - Available globally
        BlocProvider(
          create: (context) => getIt<SettingsBloc>()..add(const LoadSettings()),
        ),
        // Video Player BLoC
        BlocProvider.value(value: getIt<VideoPlayerBloc>()),
        // Navigation Cubit - Available globally
        BlocProvider(create: (context) => getIt<NavigationCubit>()),
        // Network Cubit - Available globally
        BlocProvider(create: (context) => getIt<NetworkCubit>()),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            context.read<FavoritesBloc>().add(const LoadFavorites());
          } else if (state is Unauthenticated) {
            context.read<FavoritesBloc>().add(const ClearFavorites());
          }
        },
        child: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, settingsState) {
            // Simplified ThemeMode extraction using extension
            final themeMode = settingsState.toThemeMode;

            return MaterialApp.router(
              title: 'Lilinet',
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeMode,
              routerConfig: AppRouter.router,
              builder: (context, child) {
                return OfflineBanner(child: child!);
              },
            );
          },
        ),
      ),
    );
  }
}
