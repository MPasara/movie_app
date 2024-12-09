import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app/features/popular/data/mappers/movie_entity_mapper.dart';
import 'package:movie_app/features/popular/data/models/movie_response.dart';
import 'package:movie_app/features/popular/domain/entities/movie_wrapper.dart';
import 'package:q_architecture/q_architecture.dart';

final movieWrapperEntityMapper =
    Provider<EntityMapper<MovieWrapper, MovieResponseWrapper>>(
  (ref) => (response) {
    final movieMapper = ref.read(twoWayMovieEntityMapperProvider);
    return MovieWrapper(
      totalPages: response.totalPages,
      currentPage: response.page,
      movies: response.results
          .map(
            (movieResponse) => movieMapper.responseMapper(movieResponse),
          )
          .toList(growable: true),
    );
  },
);
