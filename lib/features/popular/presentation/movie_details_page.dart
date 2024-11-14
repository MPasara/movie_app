import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app/common/domain/router/navigation_extensions.dart';
import 'package:movie_app/common/presentation/build_context_extensions.dart';
import 'package:movie_app/common/presentation/image_assets.dart';
import 'package:movie_app/common/presentation/spacing.dart';
import 'package:movie_app/common/presentation/widgets/genre_chip.dart';
import 'package:movie_app/common/utils/constants.dart';
import 'package:movie_app/features/popular/domain/entities/movie.dart';
import 'package:movie_app/generated/l10n.dart';

class MovieDetailsPage extends ConsumerWidget {
  static const routeName = '/movie-details';

  final Movie movie;
  const MovieDetailsPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: 334,
            child: CachedNetworkImage(
              imageUrl: kImagesBaseUrl +
                  ((movie.backdropImagePath?.isNotEmpty == true)
                      ? movie.backdropImagePath!
                      : movie.posterImagePath),
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 50,
            left: 20,
            child: GestureDetector(
              onTap: () => ref.pop(),
              child: SvgPicture.asset(ImageAssets.arrowBack),
            ),
          ),
          Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.37),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: BoxDecoration(
              color: context.appColors.background,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 22),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 5,
                          child: Text(
                            movie.title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            softWrap: true,
                            style: TextStyle(
                              color: context.appColors.defaultColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
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
                        top: 4,
                        bottom: 12,
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            ImageAssets.star,
                          ),
                          spacing4,
                          Text(
                            S.of(context).movie_rating(
                                  movie.voteAverage.toStringAsFixed(1),
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
                    const SizedBox(height: 40),
                    movie.description != ''
                        ? Text(
                            S.of(context).description,
                            style: TextStyle(
                              color: context.appColors.defaultColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          )
                        : const SizedBox(),
                    Column(
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          movie.description,
                          style: TextStyle(
                            color: context.appColors.defaultColor,
                            fontWeight: FontWeight.w300,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 14),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
