import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app/features/popular/data/models/movie_response.dart';
import 'package:movie_app/features/popular/domain/entities/movie.dart';
import 'package:movie_app/features/popular/domain/providers/all_genres_provider.dart';
import 'package:movie_app/generated/l10n.dart';
import 'package:q_architecture/q_architecture.dart';

final movieEntityMapperProvider = Provider<EntityMapper<Movie, MovieResponse>>(
  (ref) => (response) {
    final genresMap = ref.read(allGenresProvider);

    return Movie(
      id: response.id,
      title: response.title,
      description: response.overview,
      posterImagePath: response.posterPath,
      backdropImagePath: response.backdropPath ?? '',
      voteAverage: response.voteAverage,
      genres: response.genreIds
          .map((id) => genresMap[id] ?? S.current.unknown_genre)
          .toList(),
    );
  },
);
