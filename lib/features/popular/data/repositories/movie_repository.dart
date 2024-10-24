import 'package:either_dart/either.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app/common/data/api_client.dart';
import 'package:movie_app/common/data/providers.dart';
import 'package:movie_app/common/utils/constants.dart';
import 'package:movie_app/features/popular/data/models/movie_response.dart';
import 'package:q_architecture/q_architecture.dart';

final movieRepositoryProvider = Provider<MovieRepository>(
  (ref) => MovieRepositoryImpl(
    ref.read(
      apiClientProvider,
    ),
  ),
);

abstract interface class MovieRepository {
  EitherFailureOr<MovieResponseWrapper> getMovies();
}

class MovieRepositoryImpl implements MovieRepository {
  final ApiClient _apiClient;

  MovieRepositoryImpl(this._apiClient);
  @override
  EitherFailureOr<MovieResponseWrapper> getMovies() async {
    try {
      final response = await _apiClient.getMovies(
        kBearerToken,
        kApiLanguage,
        1,
      );
      return Right(response);
    } catch (e, st) {
      return Left(
        Failure(title: 'Fetch movies failed', error: e, stackTrace: st),
      );
    }
  }
}
