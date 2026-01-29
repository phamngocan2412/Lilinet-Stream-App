import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../injection_container.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../bloc/search/search_bloc.dart';
import '../bloc/search/search_event.dart';
import '../bloc/search/search_state.dart';
import '../widgets/movie_card.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SearchBloc>(),
      child: const SearchPageView(),
    );
  }
}

class SearchPageView extends StatefulWidget {
  const SearchPageView({super.key});

  @override
  State<SearchPageView> createState() => _SearchPageViewState();
}

class _SearchPageViewState extends State<SearchPageView> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<SearchBloc>().add(SearchLoadMore());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          autofocus: true,
          maxLength: 100,
          style: Theme.of(context).textTheme.bodyLarge,
          decoration: InputDecoration(
            hintText: 'Search anime...',
            counterText: "",
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _controller.clear();
                context.read<SearchBloc>().add(SearchCleared());
              },
            ),
          ),
          onChanged: (query) {
            context.read<SearchBloc>().add(SearchQueryChanged(query));
          },
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    _buildFilterChip(context, 'All', state.activeFilter),
                    const SizedBox(width: 8),
                    _buildFilterChip(context, 'TV Series', state.activeFilter),
                    const SizedBox(width: 8),
                    _buildFilterChip(context, 'Movie', state.activeFilter),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state.query.isEmpty) {
            return const EmptyStateWidget(
              icon: Icons.search,
              message: 'Search for anime',
            );
          }

          final filteredMovies = state.activeFilter == 'All'
              ? state.movies
              : state.movies
                    .where((m) => m.type == state.activeFilter)
                    .toList();

          if (state.isLoading && state.movies.isEmpty) {
            return const Center(child: LoadingIndicator());
          }

          if (state.hasError && state.movies.isEmpty) {
            return Center(
              child: AppErrorWidget(
                message: state.errorMessage,
                onRetry: () {
                  context.read<SearchBloc>().add(
                    SearchQueryChanged(state.query),
                  );
                },
              ),
            );
          }

          if (filteredMovies.isEmpty) {
            if (state.isLoading) {
              return const Center(child: LoadingIndicator());
            }
            return EmptyStateWidget(
              icon: Icons.movie_outlined,
              message:
                  'No ${state.activeFilter == 'All' ? '' : state.activeFilter} results found for "${state.query}"',
            );
          }

          // Calculate optimal cache width
          final screenWidth = MediaQuery.of(context).size.width;
          final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
          final cacheWidth = ((screenWidth - 32) / 2 * devicePixelRatio).ceil();

          return GridView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: filteredMovies.length + (state.isLoading ? 1 : 0),
            addAutomaticKeepAlives: false, // Reduce memory overhead
            addRepaintBoundaries: true, // Optimize repaints
            itemBuilder: (context, index) {
              if (index >= filteredMovies.length) {
                return const Center(child: LoadingIndicator());
              }

              final movie = filteredMovies[index];
              return MovieCard(
                movie: movie,
                onTap: () => context.push(
                  '/movie/${movie.id}?type=${movie.type}',
                  extra: movie,
                ),
                memCacheWidth: cacheWidth,
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildFilterChip(
    BuildContext context,
    String label,
    String currentFilter,
  ) {
    final isSelected = label == currentFilter;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        context.read<SearchBloc>().add(SearchFilterChanged(label));
      },
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      selectedColor: Theme.of(context).colorScheme.primaryContainer,
      labelStyle: TextStyle(
        color: isSelected
            ? Theme.of(context).colorScheme.onPrimaryContainer
            : Theme.of(context).colorScheme.onSurfaceVariant,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide.none,
      ),
      showCheckmark: false,
    );
  }
}
