import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app/common/data/two_way_entity_mapper.dart';
import 'package:movie_app/features/popular/data/models/movie_response.dart';
import 'package:movie_app/features/popular/domain/entities/movie.dart';
import 'package:movie_app/features/popular/domain/providers/all_genres_provider.dart';
import 'package:movie_app/generated/l10n.dart';

final twoWayMovieEntityMapperProvider =
    Provider<TwoWayEntityMapper<Movie, MovieResponse>>(
  (ref) {
    final genresMap = ref.read(allGenresProvider);
    final reverseGenresMap = {
      for (final entry in genresMap.entries) entry.value: entry.key,
    };
    return (
      responseMapper: (response) => Movie(
            id: response.id,
            title: response.title,
            description: response.overview,
            posterImagePath: response.posterPath,
            backdropImagePath: response.backdropPath,
            voteAverage: response.voteAverage,
            genres: response.genreIds
                .map((id) => genresMap[id] ?? S.current.unknown_genre)
                .toList(),
          ),
      requestMapper: (entity) => MovieResponse(
            id: entity.id,
            title: entity.title,
            overview: entity.description,
            posterPath: entity.posterImagePath,
            backdropPath: entity.backdropImagePath,
            voteAverage: entity.voteAverage,
            genreIds: entity.genres
                .map((genreName) => reverseGenresMap[genreName] ?? -1)
                .where((id) => id != -1)
                .toList(),
          ),
    );
  },
);
