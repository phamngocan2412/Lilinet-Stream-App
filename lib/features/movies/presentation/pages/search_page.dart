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
          style: Theme.of(context).textTheme.bodyLarge,
          decoration: InputDecoration(
            hintText: 'Search anime...',
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
      ),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state.query.isEmpty) {
            return const EmptyStateWidget(
              icon: Icons.search,
              message: 'Search for anime',
            );
          }

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

          if (state.movies.isEmpty) {
            return EmptyStateWidget(
              icon: Icons.movie_outlined,
              message: 'No results found for "${state.query}"',
            );
          }

          return GridView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: state.movies.length + (state.isLoading ? 1 : 0),
            addAutomaticKeepAlives: false, // Reduce memory overhead
            addRepaintBoundaries: true, // Optimize repaints
            itemBuilder: (context, index) {
              if (index >= state.movies.length) {
                return const Center(child: LoadingIndicator());
              }

              final movie = state.movies[index];
              return MovieCard(
                movie: movie,
                onTap: () => context.push(
                  '/movie/${movie.id}?type=${movie.type}',
                  extra: movie,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
