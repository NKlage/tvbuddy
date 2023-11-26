import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../../../core/presentation.dart' show UseProviderOnInit;
import '../../domain.dart' show TrendingEntity;
import '../../presentation.dart';
import '../../shared.dart' show TrendingProviders;
import '../../shared/localized_build_context.dart';

/// Trending Movie / TV List
class TrendingMovieList extends ConsumerWidget {
  /// Default Constructor
  const TrendingMovieList({required bool isMovieList, super.key})
      : _isMovieList = isMovieList;

  final bool _isMovieList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timeWindow = ref.watch(
      TrendingProviders.trendingMovieListController
          .select((value) => value.timeWindow),
    );

    final textTheme = Theme.of(context).textTheme;

    return Column(
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.trendingLocalizations.trendingShowsTitle,
                style:
                    textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              TimeWindowButton(
                currentTimeWindow: timeWindow,
                onTap: ref
                    .read(
                      TrendingProviders.trendingMovieListController.notifier,
                    )
                    .toogleTimeWindow,
              ),
            ],
          ),
        ),
        Expanded(
          child: _MovieList(
            showMovieList: !_isMovieList,
          ),
        ),
      ],
    );
  }
}

class _MovieList extends ConsumerStatefulWidget {
  const _MovieList({required this.showMovieList});

  final bool showMovieList;

  @override
  ConsumerState<_MovieList> createState() => _MovieListState();
}

class _MovieListState extends ConsumerState<_MovieList> with UseProviderOnInit {
  final ScrollController _scrollController = ScrollController();
  late TrendingMovieListController trendingMovieListController;
  ProviderSubscription<TrendingMovieListControllerState>? _stateSubscription;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(
      () {
        if (_scrollController.offset ==
            _scrollController.position.maxScrollExtent) {
          _loadNext();
        }
      },
    );
    trendingMovieListController = ref.read(
      TrendingProviders.trendingMovieListController.notifier,
    );
    useOnInit(() => trendingMovieListController.getTvShows());

    _stateSubscription = ref.listenManual(
      TrendingProviders.trendingMovieListController,
      (
        TrendingMovieListControllerState? previous,
        TrendingMovieListControllerState? next,
      ) {
        if (previous?.timeWindow != next?.timeWindow &&
            0 < _scrollController.position.pixels) {
          _scrollController.jumpTo(0);
        }
      },
    );
  }

  Future<void> _loadNext() async {
    final state = ref.read(TrendingProviders.trendingMovieListController);

    if (!state.hasNext) {
      return;
    }

    await trendingMovieListController.getTvShows(
      page: state.currentPage + 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasNext = ref.read(
      TrendingProviders.trendingMovieListController
          .select((value) => value.hasNext),
    );
    final items = ref.watch(
      TrendingProviders.trendingMovieListController
          .select((value) => value.tvOrMovies),
    );

    return items.when(
      data: (movies) {
        final movieList = movies.toList();
        return ListView.builder(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: movies.length + 1,
          itemBuilder: (_, int index) {
            if (index < movies.length) {
              final currentItem = movieList[index];
              final valueKey =
                  widget.showMovieList ? 'trending-movie' : 'trending-tv';

              return _MovieListItem(
                tvOrMovie: currentItem,
                key: ValueKey('$valueKey-${currentItem.id}'),
              );
            } else {
              return hasNext
                  ? const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    )
                  : Container();
            }
          },
        );
      },
      error: (error, stack) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(context.trendingLocalizations.movieListError),
            PlatformTextButton(
              child: Text(context.trendingLocalizations.reloadActionText),
              onPressed: () async {
                await ref
                    .read(
                      TrendingProviders.trendingMovieListController.notifier,
                    )
                    .getTvShows();
              },
            ),
          ],
        );
      },
      loading: CircularProgressIndicator.adaptive,
    );
  }

  @override
  void dispose() {
    _stateSubscription?.close();
    _scrollController.dispose();
    super.dispose();
  }
}

/// Movie List Item
class _MovieListItem extends StatelessWidget {
  /// Default Constructor
  const _MovieListItem({required TrendingEntity tvOrMovie, super.key})
      : _tvOrMovie = tvOrMovie;

  final TrendingEntity _tvOrMovie;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    const outerRadius = 15.0;
    const padding = 2.0;
    const innerRadius = outerRadius - padding;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(outerRadius),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(padding),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(innerRadius),
            ),
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: _tvOrMovie.posterPath,
                  fit: BoxFit.contain,
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: 55,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          stops: const [
                            0.1,
                            0.7,
                            0.9,
                          ],
                          colors: [
                            Colors.white,
                            Colors.white.withOpacity(0.8),
                            Colors.white.withOpacity(0.5),
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          _tvOrMovie.name,
                          style: textTheme.bodyMedium?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Switch TMDB TimeWindow Button
class TimeWindowButton extends StatelessWidget {
  /// Default Constructor
  const TimeWindowButton({
    required TimeWindow currentTimeWindow,
    void Function()? onTap,
    super.key,
  })  : _onTap = onTap,
        _currentTimeWindow = currentTimeWindow;

  final TimeWindow _currentTimeWindow;
  final VoidCallback? _onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(25),
          ),
          border: Border.all(
            color: Colors.grey,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _getButton(text: 'Day', timeWindow: TimeWindow.day),
            _getButton(text: 'Week', timeWindow: TimeWindow.week),
          ],
        ),
      ),
    );
  }

  Widget _getButton({required String text, required TimeWindow timeWindow}) {
    final widget = Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Text(text),
      ),
    );

    const circularRadius = Radius.circular(24);

    final box = BoxDecoration(
      borderRadius: BorderRadius.only(
        topRight: _currentTimeWindow == TimeWindow.week
            ? circularRadius
            : Radius.zero,
        bottomRight: _currentTimeWindow == TimeWindow.week
            ? circularRadius
            : Radius.zero,
        topLeft:
            _currentTimeWindow == TimeWindow.day ? circularRadius : Radius.zero,
        bottomLeft:
            _currentTimeWindow == TimeWindow.day ? circularRadius : Radius.zero,
      ),
      border: Border.all(
        color:
            _currentTimeWindow == timeWindow ? Colors.grey : Colors.transparent,
      ),
      color:
          _currentTimeWindow == timeWindow ? Colors.green : Colors.transparent,
    );

    return GestureDetector(
      onTap: _onTap,
      child: FractionallySizedBox(
        heightFactor: 1,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 50,
          ),
          child: DecoratedBox(
            decoration: box,
            child: widget,
          ),
        ),
      ),
    );
  }
}
