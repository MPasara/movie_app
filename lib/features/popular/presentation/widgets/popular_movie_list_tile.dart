import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app/common/domain/router/navigation_extensions.dart';
import 'package:movie_app/common/presentation/build_context_extensions.dart';
import 'package:movie_app/common/presentation/image_assets.dart';
import 'package:movie_app/common/presentation/widgets/genre_chip.dart';
import 'package:movie_app/common/utils/constants/constants.dart';
import 'package:movie_app/features/favourite/domain/notifiers/favourite_movies_notifier.dart';
import 'package:movie_app/features/popular/domain/entities/movie.dart';
import 'package:movie_app/features/popular/presentation/movie_details_page.dart';
import 'package:movie_app/generated/l10n.dart';

class PopularMovieListTile extends ConsumerStatefulWidget {
  const PopularMovieListTile({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  ConsumerState<PopularMovieListTile> createState() =>
      _PopularMovieListTileState();
}

class _PopularMovieListTileState extends ConsumerState<PopularMovieListTile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isFavourite =
        ref.watch(favouriteMoviesProvider).containsKey(widget.movie.id);
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: InkWell(
        onTap: () => ref.pushNamed(
          data: widget.movie,
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
                child: CachedNetworkImage(
                  imageUrl: kImagesBaseUrl + widget.movie.posterImagePath,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 5,
                          child: Text(
                            widget.movie.title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            softWrap: true,
                            style: context.appTextStyles.movieCardTitle,
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: IconButton(
                            onPressed: () {
                              HapticFeedback.mediumImpact();
                              ref
                                  .read(favouriteMoviesProvider.notifier)
                                  .toggleFavourite(widget.movie);
                            },
                            icon: Icon(
                              isFavourite
                                  ? Icons.bookmark
                                  : Icons.bookmark_outline,
                              color: isFavourite
                                  ? context.appColors.secondary
                                  : context.appColors.defaultColor,
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
                                  widget.movie.voteAverage.toStringAsFixed(1),
                                ),
                            style: context.appTextStyles.movieRating,
                          ),
                        ],
                      ),
                    ),
                    Wrap(
                      spacing: 5,
                      runSpacing: 4,
                      children: [
                        for (final genre in widget.movie.genres)
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
  }
}
