// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'explore_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExploreEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ExploreEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ExploreEvent()';
  }
}

/// @nodoc
class $ExploreEventCopyWith<$Res> {
  $ExploreEventCopyWith(ExploreEvent _, $Res Function(ExploreEvent) __);
}

/// Adds pattern-matching-related methods to [ExploreEvent].
extension ExploreEventPatterns on ExploreEvent {
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
    TResult Function(LoadGenres value)? loadGenres,
    TResult Function(LoadMoviesByGenre value)? loadMoviesByGenre,
    TResult Function(LoadPopularMovies value)? loadPopularMovies,
    TResult Function(LoadTopRatedMovies value)? loadTopRatedMovies,
    TResult Function(LoadRecentlyAdded value)? loadRecentlyAdded,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case LoadGenres() when loadGenres != null:
        return loadGenres(_that);
      case LoadMoviesByGenre() when loadMoviesByGenre != null:
        return loadMoviesByGenre(_that);
      case LoadPopularMovies() when loadPopularMovies != null:
        return loadPopularMovies(_that);
      case LoadTopRatedMovies() when loadTopRatedMovies != null:
        return loadTopRatedMovies(_that);
      case LoadRecentlyAdded() when loadRecentlyAdded != null:
        return loadRecentlyAdded(_that);
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
    required TResult Function(LoadGenres value) loadGenres,
    required TResult Function(LoadMoviesByGenre value) loadMoviesByGenre,
    required TResult Function(LoadPopularMovies value) loadPopularMovies,
    required TResult Function(LoadTopRatedMovies value) loadTopRatedMovies,
    required TResult Function(LoadRecentlyAdded value) loadRecentlyAdded,
  }) {
    final _that = this;
    switch (_that) {
      case LoadGenres():
        return loadGenres(_that);
      case LoadMoviesByGenre():
        return loadMoviesByGenre(_that);
      case LoadPopularMovies():
        return loadPopularMovies(_that);
      case LoadTopRatedMovies():
        return loadTopRatedMovies(_that);
      case LoadRecentlyAdded():
        return loadRecentlyAdded(_that);
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
    TResult? Function(LoadGenres value)? loadGenres,
    TResult? Function(LoadMoviesByGenre value)? loadMoviesByGenre,
    TResult? Function(LoadPopularMovies value)? loadPopularMovies,
    TResult? Function(LoadTopRatedMovies value)? loadTopRatedMovies,
    TResult? Function(LoadRecentlyAdded value)? loadRecentlyAdded,
  }) {
    final _that = this;
    switch (_that) {
      case LoadGenres() when loadGenres != null:
        return loadGenres(_that);
      case LoadMoviesByGenre() when loadMoviesByGenre != null:
        return loadMoviesByGenre(_that);
      case LoadPopularMovies() when loadPopularMovies != null:
        return loadPopularMovies(_that);
      case LoadTopRatedMovies() when loadTopRatedMovies != null:
        return loadTopRatedMovies(_that);
      case LoadRecentlyAdded() when loadRecentlyAdded != null:
        return loadRecentlyAdded(_that);
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
    TResult Function()? loadGenres,
    TResult Function(String genreId, String genreName, int page)?
        loadMoviesByGenre,
    TResult Function(int page)? loadPopularMovies,
    TResult Function(int page)? loadTopRatedMovies,
    TResult Function(int page)? loadRecentlyAdded,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case LoadGenres() when loadGenres != null:
        return loadGenres();
      case LoadMoviesByGenre() when loadMoviesByGenre != null:
        return loadMoviesByGenre(_that.genreId, _that.genreName, _that.page);
      case LoadPopularMovies() when loadPopularMovies != null:
        return loadPopularMovies(_that.page);
      case LoadTopRatedMovies() when loadTopRatedMovies != null:
        return loadTopRatedMovies(_that.page);
      case LoadRecentlyAdded() when loadRecentlyAdded != null:
        return loadRecentlyAdded(_that.page);
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
    required TResult Function() loadGenres,
    required TResult Function(String genreId, String genreName, int page)
        loadMoviesByGenre,
    required TResult Function(int page) loadPopularMovies,
    required TResult Function(int page) loadTopRatedMovies,
    required TResult Function(int page) loadRecentlyAdded,
  }) {
    final _that = this;
    switch (_that) {
      case LoadGenres():
        return loadGenres();
      case LoadMoviesByGenre():
        return loadMoviesByGenre(_that.genreId, _that.genreName, _that.page);
      case LoadPopularMovies():
        return loadPopularMovies(_that.page);
      case LoadTopRatedMovies():
        return loadTopRatedMovies(_that.page);
      case LoadRecentlyAdded():
        return loadRecentlyAdded(_that.page);
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
    TResult? Function()? loadGenres,
    TResult? Function(String genreId, String genreName, int page)?
        loadMoviesByGenre,
    TResult? Function(int page)? loadPopularMovies,
    TResult? Function(int page)? loadTopRatedMovies,
    TResult? Function(int page)? loadRecentlyAdded,
  }) {
    final _that = this;
    switch (_that) {
      case LoadGenres() when loadGenres != null:
        return loadGenres();
      case LoadMoviesByGenre() when loadMoviesByGenre != null:
        return loadMoviesByGenre(_that.genreId, _that.genreName, _that.page);
      case LoadPopularMovies() when loadPopularMovies != null:
        return loadPopularMovies(_that.page);
      case LoadTopRatedMovies() when loadTopRatedMovies != null:
        return loadTopRatedMovies(_that.page);
      case LoadRecentlyAdded() when loadRecentlyAdded != null:
        return loadRecentlyAdded(_that.page);
      case _:
        return null;
    }
  }
}

/// @nodoc

class LoadGenres implements ExploreEvent {
  const LoadGenres();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is LoadGenres);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ExploreEvent.loadGenres()';
  }
}

/// @nodoc

class LoadMoviesByGenre implements ExploreEvent {
  const LoadMoviesByGenre(
      {required this.genreId, required this.genreName, this.page = 1});

  final String genreId;
  final String genreName;
  @JsonKey()
  final int page;

  /// Create a copy of ExploreEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LoadMoviesByGenreCopyWith<LoadMoviesByGenre> get copyWith =>
      _$LoadMoviesByGenreCopyWithImpl<LoadMoviesByGenre>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LoadMoviesByGenre &&
            (identical(other.genreId, genreId) || other.genreId == genreId) &&
            (identical(other.genreName, genreName) ||
                other.genreName == genreName) &&
            (identical(other.page, page) || other.page == page));
  }

  @override
  int get hashCode => Object.hash(runtimeType, genreId, genreName, page);

  @override
  String toString() {
    return 'ExploreEvent.loadMoviesByGenre(genreId: $genreId, genreName: $genreName, page: $page)';
  }
}

/// @nodoc
abstract mixin class $LoadMoviesByGenreCopyWith<$Res>
    implements $ExploreEventCopyWith<$Res> {
  factory $LoadMoviesByGenreCopyWith(
          LoadMoviesByGenre value, $Res Function(LoadMoviesByGenre) _then) =
      _$LoadMoviesByGenreCopyWithImpl;
  @useResult
  $Res call({String genreId, String genreName, int page});
}

/// @nodoc
class _$LoadMoviesByGenreCopyWithImpl<$Res>
    implements $LoadMoviesByGenreCopyWith<$Res> {
  _$LoadMoviesByGenreCopyWithImpl(this._self, this._then);

  final LoadMoviesByGenre _self;
  final $Res Function(LoadMoviesByGenre) _then;

  /// Create a copy of ExploreEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? genreId = null,
    Object? genreName = null,
    Object? page = null,
  }) {
    return _then(LoadMoviesByGenre(
      genreId: null == genreId
          ? _self.genreId
          : genreId // ignore: cast_nullable_to_non_nullable
              as String,
      genreName: null == genreName
          ? _self.genreName
          : genreName // ignore: cast_nullable_to_non_nullable
              as String,
      page: null == page
          ? _self.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class LoadPopularMovies implements ExploreEvent {
  const LoadPopularMovies({this.page = 1});

  @JsonKey()
  final int page;

  /// Create a copy of ExploreEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LoadPopularMoviesCopyWith<LoadPopularMovies> get copyWith =>
      _$LoadPopularMoviesCopyWithImpl<LoadPopularMovies>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LoadPopularMovies &&
            (identical(other.page, page) || other.page == page));
  }

  @override
  int get hashCode => Object.hash(runtimeType, page);

  @override
  String toString() {
    return 'ExploreEvent.loadPopularMovies(page: $page)';
  }
}

/// @nodoc
abstract mixin class $LoadPopularMoviesCopyWith<$Res>
    implements $ExploreEventCopyWith<$Res> {
  factory $LoadPopularMoviesCopyWith(
          LoadPopularMovies value, $Res Function(LoadPopularMovies) _then) =
      _$LoadPopularMoviesCopyWithImpl;
  @useResult
  $Res call({int page});
}

/// @nodoc
class _$LoadPopularMoviesCopyWithImpl<$Res>
    implements $LoadPopularMoviesCopyWith<$Res> {
  _$LoadPopularMoviesCopyWithImpl(this._self, this._then);

  final LoadPopularMovies _self;
  final $Res Function(LoadPopularMovies) _then;

  /// Create a copy of ExploreEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? page = null,
  }) {
    return _then(LoadPopularMovies(
      page: null == page
          ? _self.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class LoadTopRatedMovies implements ExploreEvent {
  const LoadTopRatedMovies({this.page = 1});

  @JsonKey()
  final int page;

  /// Create a copy of ExploreEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LoadTopRatedMoviesCopyWith<LoadTopRatedMovies> get copyWith =>
      _$LoadTopRatedMoviesCopyWithImpl<LoadTopRatedMovies>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LoadTopRatedMovies &&
            (identical(other.page, page) || other.page == page));
  }

  @override
  int get hashCode => Object.hash(runtimeType, page);

  @override
  String toString() {
    return 'ExploreEvent.loadTopRatedMovies(page: $page)';
  }
}

/// @nodoc
abstract mixin class $LoadTopRatedMoviesCopyWith<$Res>
    implements $ExploreEventCopyWith<$Res> {
  factory $LoadTopRatedMoviesCopyWith(
          LoadTopRatedMovies value, $Res Function(LoadTopRatedMovies) _then) =
      _$LoadTopRatedMoviesCopyWithImpl;
  @useResult
  $Res call({int page});
}

/// @nodoc
class _$LoadTopRatedMoviesCopyWithImpl<$Res>
    implements $LoadTopRatedMoviesCopyWith<$Res> {
  _$LoadTopRatedMoviesCopyWithImpl(this._self, this._then);

  final LoadTopRatedMovies _self;
  final $Res Function(LoadTopRatedMovies) _then;

  /// Create a copy of ExploreEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? page = null,
  }) {
    return _then(LoadTopRatedMovies(
      page: null == page
          ? _self.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class LoadRecentlyAdded implements ExploreEvent {
  const LoadRecentlyAdded({this.page = 1});

  @JsonKey()
  final int page;

  /// Create a copy of ExploreEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LoadRecentlyAddedCopyWith<LoadRecentlyAdded> get copyWith =>
      _$LoadRecentlyAddedCopyWithImpl<LoadRecentlyAdded>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LoadRecentlyAdded &&
            (identical(other.page, page) || other.page == page));
  }

  @override
  int get hashCode => Object.hash(runtimeType, page);

  @override
  String toString() {
    return 'ExploreEvent.loadRecentlyAdded(page: $page)';
  }
}

/// @nodoc
abstract mixin class $LoadRecentlyAddedCopyWith<$Res>
    implements $ExploreEventCopyWith<$Res> {
  factory $LoadRecentlyAddedCopyWith(
          LoadRecentlyAdded value, $Res Function(LoadRecentlyAdded) _then) =
      _$LoadRecentlyAddedCopyWithImpl;
  @useResult
  $Res call({int page});
}

/// @nodoc
class _$LoadRecentlyAddedCopyWithImpl<$Res>
    implements $LoadRecentlyAddedCopyWith<$Res> {
  _$LoadRecentlyAddedCopyWithImpl(this._self, this._then);

  final LoadRecentlyAdded _self;
  final $Res Function(LoadRecentlyAdded) _then;

  /// Create a copy of ExploreEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? page = null,
  }) {
    return _then(LoadRecentlyAdded(
      page: null == page
          ? _self.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
