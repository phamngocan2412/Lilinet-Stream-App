// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'explore_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ExploreState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Genre> genres) genresLoaded,
    required TResult Function(
      List<Movie> movies,
      String category,
      int currentPage,
      bool hasMore,
    )
    moviesLoaded,
    required TResult Function(String message) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Genre> genres)? genresLoaded,
    TResult? Function(
      List<Movie> movies,
      String category,
      int currentPage,
      bool hasMore,
    )?
    moviesLoaded,
    TResult? Function(String message)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Genre> genres)? genresLoaded,
    TResult Function(
      List<Movie> movies,
      String category,
      int currentPage,
      bool hasMore,
    )?
    moviesLoaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ExploreInitial value) initial,
    required TResult Function(ExploreLoading value) loading,
    required TResult Function(GenresLoaded value) genresLoaded,
    required TResult Function(MoviesLoaded value) moviesLoaded,
    required TResult Function(ExploreError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ExploreInitial value)? initial,
    TResult? Function(ExploreLoading value)? loading,
    TResult? Function(GenresLoaded value)? genresLoaded,
    TResult? Function(MoviesLoaded value)? moviesLoaded,
    TResult? Function(ExploreError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExploreInitial value)? initial,
    TResult Function(ExploreLoading value)? loading,
    TResult Function(GenresLoaded value)? genresLoaded,
    TResult Function(MoviesLoaded value)? moviesLoaded,
    TResult Function(ExploreError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExploreStateCopyWith<$Res> {
  factory $ExploreStateCopyWith(
    ExploreState value,
    $Res Function(ExploreState) then,
  ) = _$ExploreStateCopyWithImpl<$Res, ExploreState>;
}

/// @nodoc
class _$ExploreStateCopyWithImpl<$Res, $Val extends ExploreState>
    implements $ExploreStateCopyWith<$Res> {
  _$ExploreStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExploreState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ExploreInitialImplCopyWith<$Res> {
  factory _$$ExploreInitialImplCopyWith(
    _$ExploreInitialImpl value,
    $Res Function(_$ExploreInitialImpl) then,
  ) = __$$ExploreInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ExploreInitialImplCopyWithImpl<$Res>
    extends _$ExploreStateCopyWithImpl<$Res, _$ExploreInitialImpl>
    implements _$$ExploreInitialImplCopyWith<$Res> {
  __$$ExploreInitialImplCopyWithImpl(
    _$ExploreInitialImpl _value,
    $Res Function(_$ExploreInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExploreState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ExploreInitialImpl implements ExploreInitial {
  const _$ExploreInitialImpl();

  @override
  String toString() {
    return 'ExploreState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ExploreInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Genre> genres) genresLoaded,
    required TResult Function(
      List<Movie> movies,
      String category,
      int currentPage,
      bool hasMore,
    )
    moviesLoaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Genre> genres)? genresLoaded,
    TResult? Function(
      List<Movie> movies,
      String category,
      int currentPage,
      bool hasMore,
    )?
    moviesLoaded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Genre> genres)? genresLoaded,
    TResult Function(
      List<Movie> movies,
      String category,
      int currentPage,
      bool hasMore,
    )?
    moviesLoaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ExploreInitial value) initial,
    required TResult Function(ExploreLoading value) loading,
    required TResult Function(GenresLoaded value) genresLoaded,
    required TResult Function(MoviesLoaded value) moviesLoaded,
    required TResult Function(ExploreError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ExploreInitial value)? initial,
    TResult? Function(ExploreLoading value)? loading,
    TResult? Function(GenresLoaded value)? genresLoaded,
    TResult? Function(MoviesLoaded value)? moviesLoaded,
    TResult? Function(ExploreError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExploreInitial value)? initial,
    TResult Function(ExploreLoading value)? loading,
    TResult Function(GenresLoaded value)? genresLoaded,
    TResult Function(MoviesLoaded value)? moviesLoaded,
    TResult Function(ExploreError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class ExploreInitial implements ExploreState {
  const factory ExploreInitial() = _$ExploreInitialImpl;
}

/// @nodoc
abstract class _$$ExploreLoadingImplCopyWith<$Res> {
  factory _$$ExploreLoadingImplCopyWith(
    _$ExploreLoadingImpl value,
    $Res Function(_$ExploreLoadingImpl) then,
  ) = __$$ExploreLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ExploreLoadingImplCopyWithImpl<$Res>
    extends _$ExploreStateCopyWithImpl<$Res, _$ExploreLoadingImpl>
    implements _$$ExploreLoadingImplCopyWith<$Res> {
  __$$ExploreLoadingImplCopyWithImpl(
    _$ExploreLoadingImpl _value,
    $Res Function(_$ExploreLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExploreState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ExploreLoadingImpl implements ExploreLoading {
  const _$ExploreLoadingImpl();

  @override
  String toString() {
    return 'ExploreState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ExploreLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Genre> genres) genresLoaded,
    required TResult Function(
      List<Movie> movies,
      String category,
      int currentPage,
      bool hasMore,
    )
    moviesLoaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Genre> genres)? genresLoaded,
    TResult? Function(
      List<Movie> movies,
      String category,
      int currentPage,
      bool hasMore,
    )?
    moviesLoaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Genre> genres)? genresLoaded,
    TResult Function(
      List<Movie> movies,
      String category,
      int currentPage,
      bool hasMore,
    )?
    moviesLoaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ExploreInitial value) initial,
    required TResult Function(ExploreLoading value) loading,
    required TResult Function(GenresLoaded value) genresLoaded,
    required TResult Function(MoviesLoaded value) moviesLoaded,
    required TResult Function(ExploreError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ExploreInitial value)? initial,
    TResult? Function(ExploreLoading value)? loading,
    TResult? Function(GenresLoaded value)? genresLoaded,
    TResult? Function(MoviesLoaded value)? moviesLoaded,
    TResult? Function(ExploreError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExploreInitial value)? initial,
    TResult Function(ExploreLoading value)? loading,
    TResult Function(GenresLoaded value)? genresLoaded,
    TResult Function(MoviesLoaded value)? moviesLoaded,
    TResult Function(ExploreError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class ExploreLoading implements ExploreState {
  const factory ExploreLoading() = _$ExploreLoadingImpl;
}

/// @nodoc
abstract class _$$GenresLoadedImplCopyWith<$Res> {
  factory _$$GenresLoadedImplCopyWith(
    _$GenresLoadedImpl value,
    $Res Function(_$GenresLoadedImpl) then,
  ) = __$$GenresLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Genre> genres});
}

/// @nodoc
class __$$GenresLoadedImplCopyWithImpl<$Res>
    extends _$ExploreStateCopyWithImpl<$Res, _$GenresLoadedImpl>
    implements _$$GenresLoadedImplCopyWith<$Res> {
  __$$GenresLoadedImplCopyWithImpl(
    _$GenresLoadedImpl _value,
    $Res Function(_$GenresLoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExploreState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? genres = null}) {
    return _then(
      _$GenresLoadedImpl(
        genres: null == genres
            ? _value._genres
            : genres // ignore: cast_nullable_to_non_nullable
                  as List<Genre>,
      ),
    );
  }
}

/// @nodoc

class _$GenresLoadedImpl implements GenresLoaded {
  const _$GenresLoadedImpl({required final List<Genre> genres})
    : _genres = genres;

  final List<Genre> _genres;
  @override
  List<Genre> get genres {
    if (_genres is EqualUnmodifiableListView) return _genres;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_genres);
  }

  @override
  String toString() {
    return 'ExploreState.genresLoaded(genres: $genres)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GenresLoadedImpl &&
            const DeepCollectionEquality().equals(other._genres, _genres));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_genres));

  /// Create a copy of ExploreState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GenresLoadedImplCopyWith<_$GenresLoadedImpl> get copyWith =>
      __$$GenresLoadedImplCopyWithImpl<_$GenresLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Genre> genres) genresLoaded,
    required TResult Function(
      List<Movie> movies,
      String category,
      int currentPage,
      bool hasMore,
    )
    moviesLoaded,
    required TResult Function(String message) error,
  }) {
    return genresLoaded(genres);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Genre> genres)? genresLoaded,
    TResult? Function(
      List<Movie> movies,
      String category,
      int currentPage,
      bool hasMore,
    )?
    moviesLoaded,
    TResult? Function(String message)? error,
  }) {
    return genresLoaded?.call(genres);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Genre> genres)? genresLoaded,
    TResult Function(
      List<Movie> movies,
      String category,
      int currentPage,
      bool hasMore,
    )?
    moviesLoaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (genresLoaded != null) {
      return genresLoaded(genres);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ExploreInitial value) initial,
    required TResult Function(ExploreLoading value) loading,
    required TResult Function(GenresLoaded value) genresLoaded,
    required TResult Function(MoviesLoaded value) moviesLoaded,
    required TResult Function(ExploreError value) error,
  }) {
    return genresLoaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ExploreInitial value)? initial,
    TResult? Function(ExploreLoading value)? loading,
    TResult? Function(GenresLoaded value)? genresLoaded,
    TResult? Function(MoviesLoaded value)? moviesLoaded,
    TResult? Function(ExploreError value)? error,
  }) {
    return genresLoaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExploreInitial value)? initial,
    TResult Function(ExploreLoading value)? loading,
    TResult Function(GenresLoaded value)? genresLoaded,
    TResult Function(MoviesLoaded value)? moviesLoaded,
    TResult Function(ExploreError value)? error,
    required TResult orElse(),
  }) {
    if (genresLoaded != null) {
      return genresLoaded(this);
    }
    return orElse();
  }
}

abstract class GenresLoaded implements ExploreState {
  const factory GenresLoaded({required final List<Genre> genres}) =
      _$GenresLoadedImpl;

  List<Genre> get genres;

  /// Create a copy of ExploreState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GenresLoadedImplCopyWith<_$GenresLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MoviesLoadedImplCopyWith<$Res> {
  factory _$$MoviesLoadedImplCopyWith(
    _$MoviesLoadedImpl value,
    $Res Function(_$MoviesLoadedImpl) then,
  ) = __$$MoviesLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    List<Movie> movies,
    String category,
    int currentPage,
    bool hasMore,
  });
}

/// @nodoc
class __$$MoviesLoadedImplCopyWithImpl<$Res>
    extends _$ExploreStateCopyWithImpl<$Res, _$MoviesLoadedImpl>
    implements _$$MoviesLoadedImplCopyWith<$Res> {
  __$$MoviesLoadedImplCopyWithImpl(
    _$MoviesLoadedImpl _value,
    $Res Function(_$MoviesLoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExploreState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? movies = null,
    Object? category = null,
    Object? currentPage = null,
    Object? hasMore = null,
  }) {
    return _then(
      _$MoviesLoadedImpl(
        movies: null == movies
            ? _value._movies
            : movies // ignore: cast_nullable_to_non_nullable
                  as List<Movie>,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        currentPage: null == currentPage
            ? _value.currentPage
            : currentPage // ignore: cast_nullable_to_non_nullable
                  as int,
        hasMore: null == hasMore
            ? _value.hasMore
            : hasMore // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$MoviesLoadedImpl implements MoviesLoaded {
  const _$MoviesLoadedImpl({
    required final List<Movie> movies,
    required this.category,
    this.currentPage = 1,
    this.hasMore = true,
  }) : _movies = movies;

  final List<Movie> _movies;
  @override
  List<Movie> get movies {
    if (_movies is EqualUnmodifiableListView) return _movies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_movies);
  }

  @override
  final String category;
  @override
  @JsonKey()
  final int currentPage;
  @override
  @JsonKey()
  final bool hasMore;

  @override
  String toString() {
    return 'ExploreState.moviesLoaded(movies: $movies, category: $category, currentPage: $currentPage, hasMore: $hasMore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MoviesLoadedImpl &&
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
    hasMore,
  );

  /// Create a copy of ExploreState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MoviesLoadedImplCopyWith<_$MoviesLoadedImpl> get copyWith =>
      __$$MoviesLoadedImplCopyWithImpl<_$MoviesLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Genre> genres) genresLoaded,
    required TResult Function(
      List<Movie> movies,
      String category,
      int currentPage,
      bool hasMore,
    )
    moviesLoaded,
    required TResult Function(String message) error,
  }) {
    return moviesLoaded(movies, category, currentPage, hasMore);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Genre> genres)? genresLoaded,
    TResult? Function(
      List<Movie> movies,
      String category,
      int currentPage,
      bool hasMore,
    )?
    moviesLoaded,
    TResult? Function(String message)? error,
  }) {
    return moviesLoaded?.call(movies, category, currentPage, hasMore);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Genre> genres)? genresLoaded,
    TResult Function(
      List<Movie> movies,
      String category,
      int currentPage,
      bool hasMore,
    )?
    moviesLoaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (moviesLoaded != null) {
      return moviesLoaded(movies, category, currentPage, hasMore);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ExploreInitial value) initial,
    required TResult Function(ExploreLoading value) loading,
    required TResult Function(GenresLoaded value) genresLoaded,
    required TResult Function(MoviesLoaded value) moviesLoaded,
    required TResult Function(ExploreError value) error,
  }) {
    return moviesLoaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ExploreInitial value)? initial,
    TResult? Function(ExploreLoading value)? loading,
    TResult? Function(GenresLoaded value)? genresLoaded,
    TResult? Function(MoviesLoaded value)? moviesLoaded,
    TResult? Function(ExploreError value)? error,
  }) {
    return moviesLoaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExploreInitial value)? initial,
    TResult Function(ExploreLoading value)? loading,
    TResult Function(GenresLoaded value)? genresLoaded,
    TResult Function(MoviesLoaded value)? moviesLoaded,
    TResult Function(ExploreError value)? error,
    required TResult orElse(),
  }) {
    if (moviesLoaded != null) {
      return moviesLoaded(this);
    }
    return orElse();
  }
}

abstract class MoviesLoaded implements ExploreState {
  const factory MoviesLoaded({
    required final List<Movie> movies,
    required final String category,
    final int currentPage,
    final bool hasMore,
  }) = _$MoviesLoadedImpl;

  List<Movie> get movies;
  String get category;
  int get currentPage;
  bool get hasMore;

  /// Create a copy of ExploreState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MoviesLoadedImplCopyWith<_$MoviesLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ExploreErrorImplCopyWith<$Res> {
  factory _$$ExploreErrorImplCopyWith(
    _$ExploreErrorImpl value,
    $Res Function(_$ExploreErrorImpl) then,
  ) = __$$ExploreErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ExploreErrorImplCopyWithImpl<$Res>
    extends _$ExploreStateCopyWithImpl<$Res, _$ExploreErrorImpl>
    implements _$$ExploreErrorImplCopyWith<$Res> {
  __$$ExploreErrorImplCopyWithImpl(
    _$ExploreErrorImpl _value,
    $Res Function(_$ExploreErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExploreState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$ExploreErrorImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ExploreErrorImpl implements ExploreError {
  const _$ExploreErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'ExploreState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExploreErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of ExploreState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExploreErrorImplCopyWith<_$ExploreErrorImpl> get copyWith =>
      __$$ExploreErrorImplCopyWithImpl<_$ExploreErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Genre> genres) genresLoaded,
    required TResult Function(
      List<Movie> movies,
      String category,
      int currentPage,
      bool hasMore,
    )
    moviesLoaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Genre> genres)? genresLoaded,
    TResult? Function(
      List<Movie> movies,
      String category,
      int currentPage,
      bool hasMore,
    )?
    moviesLoaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Genre> genres)? genresLoaded,
    TResult Function(
      List<Movie> movies,
      String category,
      int currentPage,
      bool hasMore,
    )?
    moviesLoaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ExploreInitial value) initial,
    required TResult Function(ExploreLoading value) loading,
    required TResult Function(GenresLoaded value) genresLoaded,
    required TResult Function(MoviesLoaded value) moviesLoaded,
    required TResult Function(ExploreError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ExploreInitial value)? initial,
    TResult? Function(ExploreLoading value)? loading,
    TResult? Function(GenresLoaded value)? genresLoaded,
    TResult? Function(MoviesLoaded value)? moviesLoaded,
    TResult? Function(ExploreError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExploreInitial value)? initial,
    TResult Function(ExploreLoading value)? loading,
    TResult Function(GenresLoaded value)? genresLoaded,
    TResult Function(MoviesLoaded value)? moviesLoaded,
    TResult Function(ExploreError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ExploreError implements ExploreState {
  const factory ExploreError({required final String message}) =
      _$ExploreErrorImpl;

  String get message;

  /// Create a copy of ExploreState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExploreErrorImplCopyWith<_$ExploreErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
