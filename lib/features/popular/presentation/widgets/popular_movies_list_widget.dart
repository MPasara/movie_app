import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app/common/domain/router/navigation_extensions.dart';
import 'package:movie_app/common/presentation/build_context_extensions.dart';
import 'package:movie_app/common/presentation/image_assets.dart';
import 'package:movie_app/common/presentation/widgets/genre_chip.dart';
import 'package:movie_app/common/utils/constants.dart';
import 'package:movie_app/features/popular/domain/entities/movie.dart';
import 'package:movie_app/features/popular/presentation/movie_details_page.dart';
import 'package:movie_app/generated/l10n.dart';

class PopularMoviesListWidget extends ConsumerWidget {
  const PopularMoviesListWidget({
    super.key,
    required this.movies,
    required this.scrollController,
  });

  final List<Movie> movies;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: RawScrollbar(
        padding: const EdgeInsets.only(right: 4),
        thumbColor: context.appColors.secondary!.withOpacity(0.75),
        controller: scrollController,
        thickness: 5,
        child: ListView.builder(
          controller: scrollController,
          padding: const EdgeInsets.only(top: 16),
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(
                bottom: 20,
              ),
              child: InkWell(
                onTap: () => ref.pushNamed(
                  data: movies[index],
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
                          kImagesBaseUrl + movies[index].posterImagePath,
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
                                    movies[index].title,
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
                              padding: const EdgeInsets.only(
                                bottom: 12,
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    ImageAssets.star,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    S.of(context).movie_rating(
                                          movies[index]
                                              .voteAverage
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
                                for (final genre in movies[index].genres)
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
    );
  }
}
