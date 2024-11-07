import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app/common/domain/router/navigation_extensions.dart';
import 'package:movie_app/common/presentation/build_context_extensions.dart';
import 'package:movie_app/common/presentation/image_assets.dart';
import 'package:movie_app/common/presentation/widgets/genre_chip.dart';
import 'package:movie_app/common/utils/constants.dart';
import 'package:movie_app/features/popular/domain/entities/movie.dart';
import 'package:movie_app/features/popular/domain/notifiers/popular_movies_notifier.dart';
import 'package:movie_app/features/popular/presentation/movie_details_page.dart';
import 'package:movie_app/generated/l10n.dart';

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
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: InkWell(
                  onTap: () => ref.pushNamed(
                    data: movie,
                    ref.getRouteNameFromCurrentLocation(
                      MovieDetailsPage.routeName,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 100,
                          height: 130,
                          child: Image.network(
                            kImagesBaseUrl + movie.posterImagePath,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    flex: 5,
                                    child: Text(
                                      movie.title,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      softWrap: true,
                                      style: TextStyle(
                                        color: context.appColors.defaultColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.bookmark_outline,
                                        color: context.appColors.defaultColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      ImageAssets.star,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      S.of(context).movie_rating(
                                            movie.voteAverage
                                                .toStringAsFixed(1),
                                          ),
                                      style: TextStyle(
                                        color: context.appColors.defaultColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Wrap(
                                spacing: 5,
                                runSpacing: 4,
                                children: [
                                  for (final genre in movie.genres)
                                    GenreChip(name: genre),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _handlePullToRefresh() async {
    await ref.read(popularMoviesNotifierProvider.notifier).getPopularMovies(1);
  }

  @override
  bool get wantKeepAlive => true;
}
