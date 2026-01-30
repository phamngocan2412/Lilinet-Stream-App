import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
    return BlocBuilder<NavigationCubit, int>(
      builder: (context, navIndex) {
        return BlocBuilder<VideoPlayerBloc, VideoPlayerState>(
          buildWhen: (previous, current) => previous.status != current.status,
          builder: (context, playerState) {
            final isExpanded = playerState.status == VideoPlayerStatus.expanded;
            final isClosed = playerState.status == VideoPlayerStatus.closed;

            // Determine if we should show the Navigation Bar
            // We hide it if:
            // 1. We are on a detail page (starts with /movie/)
            // 2. We are on Search or Settings pages
            bool showNavBar = true;
            final path = state.uri.path;
            if (path.startsWith('/movie/') ||
                path == '/search' ||
                path == '/settings') {
              showNavBar = false;
            }
            // Logic removed: Don't hide navbar based on player state to prevent layout bugs if state desyncs

            return Scaffold(
              body: Stack(
                children: [
                  // Main Content
                  // We add padding to the bottom of the child content
                  // ONLY if the Player is visible (minimized) AND we are NOT on a detail page (where player floats)
                  // Wait, if miniplayer is visible, it floats over the content.
                  // If we are on Home/MainScreen, the content (IndexedStack) takes full height.
                  // The Miniplayer will sit at the bottom.
                  // We might want to add padding to the `child` so the last list item isn't obscured by the miniplayer.
                  // But `child` is opaque here. `MainScreen` doesn't know about padding.
                  // Usually, lists have 'bottom content padding'.
                  // For now, we will just let it float over. Overlap is better than broken layout.
                  // We can add a bottom safe area later if needed.
                  child,

                  // Video Player Overlay
                  if (!isClosed)
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      top: isExpanded ? 0 : null,
                      child: MiniplayerWidget(
                        // Fixed height to prevent inconsistency when navigating
                        // Always add bottom padding for safe area consistency
                        miniplayerHeight:
                            60 + MediaQuery.of(context).padding.bottom,
                        maxWidth: MediaQuery.of(context).size.width,
                      ),
                    ),
                ],
              ),
              bottomNavigationBar: showNavBar
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
