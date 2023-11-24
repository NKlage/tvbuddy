import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tmdb_api/tmdb_api.dart' show TimeWindow;

import '../../domain.dart' show TrendingEntity;
import '../../presentation.dart' show TrendingMovieListController;

part 'trending_movie_list.controller.state.freezed.dart';

/// [TrendingMovieListController] State
@freezed
class TrendingMovieListControllerState with _$TrendingMovieListControllerState {
  /// Default Constructor
  const factory TrendingMovieListControllerState({
    @Default(1) int currentPage,
    @Default(false) bool hasNext,
    @Default(AsyncData(<TrendingEntity>[]))
    AsyncValue<Iterable<TrendingEntity>> tvOrMovies,
    @Default(TimeWindow.day) TimeWindow timeWindow,
  }) = _TrendingMovieListControllerState;
}
