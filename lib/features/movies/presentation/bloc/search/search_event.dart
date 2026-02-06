import 'package:equatable/equatable.dart';
import '../../../../explore/domain/entities/filter_options.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchQueryChanged extends SearchEvent {
  final String query;

  const SearchQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}

class SearchLoadMore extends SearchEvent {
  const SearchLoadMore();
}

class SearchCleared extends SearchEvent {
  const SearchCleared();
}

class SearchFilterChanged extends SearchEvent {
  final String filter; // 'All', 'TV Series', 'Movie'

  const SearchFilterChanged(this.filter);

  @override
  List<Object> get props => [filter];
}

class SearchOptionsChanged extends SearchEvent {
  final FilterOptions options;

  const SearchOptionsChanged(this.options);

  @override
  List<Object> get props => [options];
}
