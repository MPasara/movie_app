import 'package:either_dart/either.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app/common/data/api_client.dart';
import 'package:movie_app/common/data/providers.dart';
import 'package:movie_app/common/utils/constants/constants.dart';
import 'package:movie_app/features/popular/data/mappers/movie_wrapper_entity_mapper.dart';
import 'package:movie_app/features/popular/data/models/movie_response.dart';
import 'package:movie_app/features/popular/data/repositories/genre_repository.dart';
import 'package:movie_app/features/popular/domain/entities/movie_wrapper.dart';
import 'package:movie_app/features/popular/domain/providers/all_genres_provider.dart';
import 'package:movie_app/generated/l10n.dart';
import 'package:q_architecture/q_architecture.dart';

final movieRepositoryProvider = Provider<MovieRepository>(
  (ref) => MovieRepositoryImpl(
    ref,
    ref.watch(apiClientProvider),
    ref.watch(genreRepositoryProvider),
    ref.watch(movieWrapperEntityMapper),
  ),
  name: 'Movie repository provider',
);

abstract interface class MovieRepository {
  EitherFailureOr<MovieWrapper> getMovies(int page);
}

class MovieRepositoryImpl implements MovieRepository {
  final Ref ref;
  final ApiClient _apiClient;
  final GenreRepository _genreRepository;
  final EntityMapper<MovieWrapper, MovieResponseWrapper>
      _movieWrapperEntityMapper;

  MovieRepositoryImpl(
    this.ref,
    this._apiClient,
    this._genreRepository,
    this._movieWrapperEntityMapper,
  );

  @override
  EitherFailureOr<MovieWrapper> getMovies(int page) async {
    final genreMap = ref.read(allGenresProvider.notifier);

    try {
      final response = await _apiClient.getMovies(
        kBearerToken,
        kApiLanguage,
        page,
      );

      final eitherFailureOrGenres = await _genreRepository.getAllGenres();
      //genre try-catch
      try {
        eitherFailureOrGenres.fold(
          (failure) => Failure(title: failure.title, error: failure.error),
          (response) {
            if (genreMap.state.isEmpty) {
              genreMap.state = {
                for (final genre in response.genres) genre.id: genre.name,
              };
            }
          },
        );
      } catch (e, st) {
        return Left(
          Failure(
            title: S.current.fetch_genres_failed,
            error: e,
            stackTrace: st,
          ),
        );
      }
      //
      final movieWrapperEntity = _movieWrapperEntityMapper(response);

      return Right(movieWrapperEntity);
    } catch (e, st) {
      return Left(
        Failure(title: S.current.fetch_movies_failed, error: e, stackTrace: st),
      );
    }
  }
}
