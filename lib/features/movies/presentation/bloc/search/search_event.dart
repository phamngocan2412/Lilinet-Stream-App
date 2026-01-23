import 'package:equatable/equatable.dart';

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

class SearchLoadMore extends SearchEvent {}

class SearchCleared extends SearchEvent {}

class SearchFilterChanged extends SearchEvent {
  final String filter; // 'All', 'TV Series', 'Movie'

  const SearchFilterChanged(this.filter);

  @override
  List<Object> get props => [filter];
}
