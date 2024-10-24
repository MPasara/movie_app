import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app/common/presentation/image_assets.dart';
import 'package:movie_app/common/utils/constants.dart';
import 'package:movie_app/features/popular/data/models/movie_response.dart';
import 'package:movie_app/generated/l10n.dart';

class PopularMoviesListWidget extends StatelessWidget {
  const PopularMoviesListWidget({
    super.key,
    required this.movies,
  });

  final MovieResponseWrapper movies;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: movies.results.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(
              bottom: 20,
            ),
            child: InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    SizedBox(
                      width: 100,
                      height: 130,
                      child: Image.network(
                        kImagesBaseUrl + movies.results[index].posterPath,
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
                                  movies.results[index].title,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  softWrap: true,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.bookmark_outline,
                                    color: Colors.white,
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
                                const SizedBox(width: 4),
                                Text(
                                  S.of(context).movie_rating(
                                        movies.results[index].voteAverage
                                            .toStringAsFixed(1),
                                      ),
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Wrap(
                            spacing: 5,
                            runSpacing: 4,
                            children: [
                              Container(
                                color: Colors.brown,
                                child: const Text(
                                  'Comedy',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Container(
                                color: Colors.brown,
                                child: const Text(
                                  'Tragedy',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Container(
                                color: Colors.brown,
                                child: const Text(
                                  'Ex-Yu',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Container(
                                color: Colors.brown,
                                child: const Text(
                                  'Comedy',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
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
    );
  }
}
