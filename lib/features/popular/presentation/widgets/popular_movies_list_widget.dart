import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app/common/presentation/build_context_extensions.dart';
import 'package:movie_app/features/popular/domain/entities/movie.dart';
import 'package:movie_app/features/popular/domain/notifiers/popular_movies_notifier.dart';
import 'package:movie_app/features/popular/presentation/widgets/popular_movie_list_tile.dart';

class PopularMoviesListWidget extends ConsumerStatefulWidget {
  const PopularMoviesListWidget({
    super.key,
    required this.movies,
    required this.scrollController,
  });

  final List<Movie> movies;
  final ScrollController scrollController;

  @override
  ConsumerState<PopularMoviesListWidget> createState() =>
      _PopularMoviesListWidgetState();
}

class _PopularMoviesListWidgetState
    extends ConsumerState<PopularMoviesListWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Expanded(
      child: RawScrollbar(
        padding: const EdgeInsets.only(right: 4),
        thumbColor: context.appColors.defaultColor!.withOpacity(0.8),
        controller: widget.scrollController,
        thickness: 3,
        child: RefreshIndicator(
          onRefresh: _handlePullToRefresh,
          color: context.appColors.defaultColor,
          backgroundColor: context.appColors.background,
          displacement: 12,
          child: ListView.builder(
            controller: widget.scrollController,
            padding: const EdgeInsets.only(top: 16),
            itemCount: widget.movies.length,
            itemBuilder: (context, index) {
              final movie = widget.movies[index];
              return PopularMovieListTile(movie: movie);
            },
          ),
        ),
      ),
    );
  }

  Future<void> _handlePullToRefresh() async {
    HapticFeedback.mediumImpact();
    await ref.read(popularMoviesNotifierProvider.notifier).getPopularMovies(1);
  }

  @override
  bool get wantKeepAlive => true;
}
