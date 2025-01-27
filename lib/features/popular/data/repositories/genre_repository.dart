import 'package:either_dart/either.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app/common/data/api_client.dart';
import 'package:movie_app/common/data/genre_response.dart';
import 'package:movie_app/common/data/providers.dart';
import 'package:movie_app/generated/l10n.dart';
import 'package:q_architecture/q_architecture.dart';

final genreRepositoryProvider = Provider<GenreRepository>(
  (ref) => GenreRepositoryImpl(
    ref.watch(apiClientProvider),
  ),
  name: 'Genre repository provider',
);

abstract interface class GenreRepository {
  EitherFailureOr<GenreResponseWrapper> getAllGenres();
}

class GenreRepositoryImpl implements GenreRepository {
  final ApiClient _apiClient;

  GenreRepositoryImpl(this._apiClient);
  @override
  EitherFailureOr<GenreResponseWrapper> getAllGenres() async {
    try {
      final response = await _apiClient.getAllGenres();
      return Right(response);
    } catch (e, st) {
      return Left(
        Failure(title: S.current.fetch_genres_failed, error: e, stackTrace: st),
      );
    }
  }
}
