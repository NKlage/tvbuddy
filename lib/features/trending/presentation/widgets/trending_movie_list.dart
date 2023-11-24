import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/presentation.dart' show UseProviderOnInit;
import '../../domain.dart' show TrendingEntity;
import '../../shared.dart' show TrendingProviders;
import '../../shared/localized_build_context.dart';
import 'trending_movie_list.controller.dart';

/// Trending Movie / TV List
class TrendingMovieList extends StatelessWidget {
  /// Default Constructor
  const TrendingMovieList({required bool isMovieList, super.key})
      : _isMovieList = isMovieList;

  final bool _isMovieList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            context.trendingLocalizations.trendingShowsTitle,
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

    if (!widget.showMovieList) {
      useOnInit(() => trendingMovieListController.getDailyShows());
    } else {
      useOnInit(() => trendingMovieListController.getDailyMovies());
    }
  }

  Future<void> _loadNext() async {
    final state = ref.read(TrendingProviders.trendingMovieListController);

    if (!state.hasNext) {
      return;
    }

    await trendingMovieListController.getDailyShows(
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
                // TODO(nk): prüfen ob Serien oder Filme angezeigt werden sollen und
                // die entsprechende Methode aufrufen. !!! TimeWindow beachten
                await ref
                    .read(
                        TrendingProviders.trendingMovieListController.notifier)
                    .getDailyShows();
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
