import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../movies/presentation/pages/home_page.dart';
import '../../../explore/presentation/pages/explore_page.dart';
import '../../../favorites/presentation/pages/favorites_page.dart';
import '../../../history/presentation/pages/recently_watched_page.dart';
import '../bloc/navigation_cubit.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  static const List<Widget> _pages = [
    HomePage(),
    ExplorePage(),
    FavoritesPage(),
    RecentlyWatchedPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, int>(
      builder: (context, currentIndex) {
        return IndexedStack(index: currentIndex, children: _pages);
      },
    );
  }
}
