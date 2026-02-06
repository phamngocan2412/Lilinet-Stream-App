import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../injection_container.dart';
import '../../../../core/services/miniplayer_height_notifier.dart';
import '../../../video_player/presentation/bloc/video_player_bloc.dart';
import '../../../video_player/presentation/bloc/video_player_state.dart';
import '../../../video_player/presentation/widgets/miniplayer_widget.dart';
import '../bloc/navigation_cubit.dart';

class ScaffoldWithPlayer extends StatelessWidget {
  final Widget child;
  final GoRouterState state;

  const ScaffoldWithPlayer({
    super.key,
    required this.child,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final miniplayerNotifier = getIt<MiniplayerHeightNotifier>();

    return BlocBuilder<NavigationCubit, int>(
      builder: (context, navIndex) {
        return BlocBuilder<VideoPlayerBloc, VideoPlayerState>(
          buildWhen: (previous, current) => previous.status != current.status,
          builder: (context, playerState) {
            final isExpanded = playerState.status == VideoPlayerStatus.expanded;
            final isClosed = playerState.status == VideoPlayerStatus.closed;

            // Determine if we should show the Navigation Bar
            bool showNavBar = true;
            final path = state.uri.path;
            if (path.startsWith('/movie/') ||
                path == '/search' ||
                path == '/settings') {
              showNavBar = false;
            }

            // Calculate miniplayer height based on Nav Bar visibility
            // If Nav Bar is visible, Miniplayer sits on top of it (no bottom padding needed)
            // If Nav Bar is hidden, Miniplayer sits at bottom of screen (needs bottom padding)
            final double baseHeight = 60;
            final double bottomPadding = MediaQuery.of(context).padding.bottom;
            final double miniplayerHeight = showNavBar
                ? baseHeight
                : (baseHeight + bottomPadding);

            // Update miniplayer height notifier
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (isClosed) {
                miniplayerNotifier.reset();
              } else if (!isExpanded) {
                // Only set height when minimized
                miniplayerNotifier.updateHeight(miniplayerHeight);
              } else {
                // When expanded, no need for padding
                miniplayerNotifier.reset();
              }
            });
            // Logic removed: Don't hide navbar based on player state to prevent layout bugs if state desyncs

            return Scaffold(
              body: Stack(
                children: [
                  // Main Content with bottom padding when miniplayer is visible
                  // This ensures content isn't hidden behind the miniplayer
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: (!isClosed && !isExpanded) ? miniplayerHeight : 0,
                    ),
                    child: child,
                  ),

                  // Video Player Overlay - ONLY when not expanded
                  // Positioned ABOVE the bottom navigation bar when nav bar is visible
                  if (!isClosed && !isExpanded)
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: showNavBar
                          ? 80
                          : 0, // Add space for bottom nav bar
                      child: MiniplayerWidget(
                        // Dynamic height based on Nav Bar visibility
                        miniplayerHeight: miniplayerHeight,
                        maxWidth: MediaQuery.of(context).size.width,
                      ),
                    ),

                  // Fullscreen Video Player Overlay - when expanded
                  // This goes on top of everything
                  if (isExpanded)
                    Positioned.fill(
                      child: MiniplayerWidget(
                        miniplayerHeight: miniplayerHeight,
                        maxWidth: MediaQuery.of(context).size.width,
                      ),
                    ),
                ],
              ),
              bottomNavigationBar: showNavBar && !isExpanded
                  ? NavigationBar(
                      selectedIndex: navIndex,
                      onDestinationSelected: (index) {
                        context.read<NavigationCubit>().setIndex(index);
                        // If we are on a detail page and tap a tab, we should probably go back to home root?
                        // But since MainScreen uses IndexedStack, it just switches tabs.
                        // If we are on /movie/1, and tap 'Search', the Body changes to MainScreen (which shows Search).
                        // Wait, GoRouter ShellRoute:
                        // If I navigate to '/', builder is MainScreen.
                        // If I navigate to '/movie/1', builder is MovieDetailsPage.
                        // If I am on '/movie/1' and I tap the NavBar...
                        // The NavBar is in the Shell.
                        // I need to navigate to '/' when a tab is selected?
                        // Actually, `MainScreen` is ONLY rendered on path '/'.
                        // If I am on `/movie/1`, `child` is `MovieDetailsPage`.
                        // If I change `navIndex` in Cubit, `child` remains `MovieDetailsPage`!
                        // So, clicking a tab MUST navigate to `/`.
                        if (state.uri.path != '/') {
                          context.go('/');
                        }
                      },
                      destinations: const [
                        NavigationDestination(
                          icon: Icon(Icons.home_outlined),
                          selectedIcon: Icon(Icons.home),
                          label: 'Home',
                        ),
                        NavigationDestination(
                          icon: Icon(Icons.explore_outlined),
                          selectedIcon: Icon(Icons.explore),
                          label: 'Explore',
                        ),
                        NavigationDestination(
                          icon: Icon(Icons.favorite_outline),
                          selectedIcon: Icon(Icons.favorite),
                          label: 'Favorites',
                        ),
                        NavigationDestination(
                          icon: Icon(Icons.history_outlined),
                          selectedIcon: Icon(Icons.history),
                          label: 'Resume',
                        ),
                      ],
                    )
                  : null,
            );
          },
        );
      },
    );
  }
}
