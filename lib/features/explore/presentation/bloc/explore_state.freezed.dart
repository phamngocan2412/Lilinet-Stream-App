// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'explore_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExploreState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ExploreState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ExploreState()';
  }
}

/// @nodoc
class $ExploreStateCopyWith<$Res> {
  $ExploreStateCopyWith(ExploreState _, $Res Function(ExploreState) __);
}

/// Adds pattern-matching-related methods to [ExploreState].
extension ExploreStatePatterns on ExploreState {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExploreInitial value)? initial,
    TResult Function(ExploreLoading value)? loading,
    TResult Function(GenresLoaded value)? genresLoaded,
    TResult Function(MoviesLoaded value)? moviesLoaded,
    TResult Function(ExploreError value)? error,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case ExploreInitial() when initial != null:
        return initial(_that);
      case ExploreLoading() when loading != null:
        return loading(_that);
      case GenresLoaded() when genresLoaded != null:
        return genresLoaded(_that);
      case MoviesLoaded() when moviesLoaded != null:
        return moviesLoaded(_that);
      case ExploreError() when error != null:
        return error(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ExploreInitial value) initial,
    required TResult Function(ExploreLoading value) loading,
    required TResult Function(GenresLoaded value) genresLoaded,
    required TResult Function(MoviesLoaded value) moviesLoaded,
    required TResult Function(ExploreError value) error,
  }) {
    final _that = this;
    switch (_that) {
      case ExploreInitial():
        return initial(_that);
      case ExploreLoading():
        return loading(_that);
      case GenresLoaded():
        return genresLoaded(_that);
      case MoviesLoaded():
        return moviesLoaded(_that);
      case ExploreError():
        return error(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ExploreInitial value)? initial,
    TResult? Function(ExploreLoading value)? loading,
    TResult? Function(GenresLoaded value)? genresLoaded,
    TResult? Function(MoviesLoaded value)? moviesLoaded,
    TResult? Function(ExploreError value)? error,
  }) {
    final _that = this;
    switch (_that) {
      case ExploreInitial() when initial != null:
        return initial(_that);
      case ExploreLoading() when loading != null:
        return loading(_that);
      case GenresLoaded() when genresLoaded != null:
        return genresLoaded(_that);
      case MoviesLoaded() when moviesLoaded != null:
        return moviesLoaded(_that);
      case ExploreError() when error != null:
        return error(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Genre> genres)? genresLoaded,
    TResult Function(
            List<Movie> movies, String category, int currentPage, bool hasMore)?
        moviesLoaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case ExploreInitial() when initial != null:
        return initial();
      case ExploreLoading() when loading != null:
        return loading();
      case GenresLoaded() when genresLoaded != null:
        return genresLoaded(_that.genres);
      case MoviesLoaded() when moviesLoaded != null:
        return moviesLoaded(
            _that.movies, _that.category, _that.currentPage, _that.hasMore);
      case ExploreError() when error != null:
        return error(_that.message);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Genre> genres) genresLoaded,
    required TResult Function(
            List<Movie> movies, String category, int currentPage, bool hasMore)
        moviesLoaded,
    required TResult Function(String message) error,
  }) {
    final _that = this;
    switch (_that) {
      case ExploreInitial():
        return initial();
      case ExploreLoading():
        return loading();
      case GenresLoaded():
        return genresLoaded(_that.genres);
      case MoviesLoaded():
        return moviesLoaded(
            _that.movies, _that.category, _that.currentPage, _that.hasMore);
      case ExploreError():
        return error(_that.message);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Genre> genres)? genresLoaded,
    TResult? Function(
            List<Movie> movies, String category, int currentPage, bool hasMore)?
        moviesLoaded,
    TResult? Function(String message)? error,
  }) {
    final _that = this;
    switch (_that) {
      case ExploreInitial() when initial != null:
        return initial();
      case ExploreLoading() when loading != null:
        return loading();
      case GenresLoaded() when genresLoaded != null:
        return genresLoaded(_that.genres);
      case MoviesLoaded() when moviesLoaded != null:
        return moviesLoaded(
            _that.movies, _that.category, _that.currentPage, _that.hasMore);
      case ExploreError() when error != null:
        return error(_that.message);
      case _:
        return null;
    }
  }
}

/// @nodoc

class ExploreInitial implements ExploreState {
  const ExploreInitial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ExploreInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ExploreState.initial()';
  }
}

/// @nodoc

class ExploreLoading implements ExploreState {
  const ExploreLoading();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ExploreLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ExploreState.loading()';
  }
}

/// @nodoc

class GenresLoaded implements ExploreState {
  const GenresLoaded({required final List<Genre> genres}) : _genres = genres;

  final List<Genre> _genres;
  List<Genre> get genres {
    if (_genres is EqualUnmodifiableListView) return _genres;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_genres);
  }

  /// Create a copy of ExploreState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GenresLoadedCopyWith<GenresLoaded> get copyWith =>
      _$GenresLoadedCopyWithImpl<GenresLoaded>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GenresLoaded &&
            const DeepCollectionEquality().equals(other._genres, _genres));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_genres));

  @override
  String toString() {
    return 'ExploreState.genresLoaded(genres: $genres)';
  }
}

/// @nodoc
abstract mixin class $GenresLoadedCopyWith<$Res>
    implements $ExploreStateCopyWith<$Res> {
  factory $GenresLoadedCopyWith(
          GenresLoaded value, $Res Function(GenresLoaded) _then) =
      _$GenresLoadedCopyWithImpl;
  @useResult
  $Res call({List<Genre> genres});
}

/// @nodoc
class _$GenresLoadedCopyWithImpl<$Res> implements $GenresLoadedCopyWith<$Res> {
  _$GenresLoadedCopyWithImpl(this._self, this._then);

  final GenresLoaded _self;
  final $Res Function(GenresLoaded) _then;

  /// Create a copy of ExploreState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? genres = null,
  }) {
    return _then(GenresLoaded(
      genres: null == genres
          ? _self._genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<Genre>,
    ));
  }
}

/// @nodoc

class MoviesLoaded implements ExploreState {
  const MoviesLoaded(
      {required final List<Movie> movies,
      required this.category,
      this.currentPage = 1,
      this.hasMore = true})
      : _movies = movies;

  final List<Movie> _movies;
  List<Movie> get movies {
    if (_movies is EqualUnmodifiableListView) return _movies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_movies);
  }

  final String category;
  @JsonKey()
  final int currentPage;
  @JsonKey()
  final bool hasMore;

  /// Create a copy of ExploreState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MoviesLoadedCopyWith<MoviesLoaded> get copyWith =>
      _$MoviesLoadedCopyWithImpl<MoviesLoaded>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MoviesLoaded &&
            const DeepCollectionEquality().equals(other._movies, _movies) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_movies),
      category,
      currentPage,
      hasMore);

  @override
  String toString() {
    return 'ExploreState.moviesLoaded(movies: $movies, category: $category, currentPage: $currentPage, hasMore: $hasMore)';
  }
}

/// @nodoc
abstract mixin class $MoviesLoadedCopyWith<$Res>
    implements $ExploreStateCopyWith<$Res> {
  factory $MoviesLoadedCopyWith(
          MoviesLoaded value, $Res Function(MoviesLoaded) _then) =
      _$MoviesLoadedCopyWithImpl;
  @useResult
  $Res call(
      {List<Movie> movies, String category, int currentPage, bool hasMore});
}

/// @nodoc
class _$MoviesLoadedCopyWithImpl<$Res> implements $MoviesLoadedCopyWith<$Res> {
  _$MoviesLoadedCopyWithImpl(this._self, this._then);

  final MoviesLoaded _self;
  final $Res Function(MoviesLoaded) _then;

  /// Create a copy of ExploreState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? movies = null,
    Object? category = null,
    Object? currentPage = null,
    Object? hasMore = null,
  }) {
    return _then(MoviesLoaded(
      movies: null == movies
          ? _self._movies
          : movies // ignore: cast_nullable_to_non_nullable
              as List<Movie>,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      currentPage: null == currentPage
          ? _self.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      hasMore: null == hasMore
          ? _self.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class ExploreError implements ExploreState {
  const ExploreError({required this.message});

  final String message;

  /// Create a copy of ExploreState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ExploreErrorCopyWith<ExploreError> get copyWith =>
      _$ExploreErrorCopyWithImpl<ExploreError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ExploreError &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'ExploreState.error(message: $message)';
  }
}

/// @nodoc
abstract mixin class $ExploreErrorCopyWith<$Res>
    implements $ExploreStateCopyWith<$Res> {
  factory $ExploreErrorCopyWith(
          ExploreError value, $Res Function(ExploreError) _then) =
      _$ExploreErrorCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$ExploreErrorCopyWithImpl<$Res> implements $ExploreErrorCopyWith<$Res> {
  _$ExploreErrorCopyWithImpl(this._self, this._then);

  final ExploreError _self;
  final $Res Function(ExploreError) _then;

  /// Create a copy of ExploreState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(ExploreError(
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
