import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/common/data/api_client.dart';
import 'package:movie_app/common/data/genre_response.dart';
import 'package:movie_app/common/data/local_storage_service.dart';
import 'package:movie_app/common/data/package_info_service.dart';
import 'package:movie_app/common/domain/entities/app_info.dart';
import 'package:movie_app/features/favourite/data/repositories/database_service.dart';
import 'package:movie_app/features/popular/data/models/movie_response.dart';
import 'package:movie_app/features/popular/data/repositories/genre_repository.dart';
import 'package:movie_app/features/popular/domain/entities/movie.dart';

class MockDatabaseService extends Mock implements DatabaseService {}

class MockLocalStorageService extends Mock implements LocalStorageService {}

class MockPackageInfoService extends Mock implements PackageInfoService {}

final mockResponseMapper =
    MockFunction<MovieResponse, Movie>(); // Model -> Entity
final mockRequestMapper =
    MockFunction<Movie, MovieResponse>(); // Entity -> Model

// Helper class to create mock functions
class MockFunction<T, R> extends Mock {
  R call(T arg);
}

class MockApiClient extends Mock implements ApiClient {}

class MockRef extends Mock implements Ref {}

class MockGenreRepository extends Mock implements GenreRepository {}

class MockAllGenresProvider extends Mock
    implements StateController<Map<int, String>> {}

final kTestMovieResponse = [
  MovieResponse(
    id: 1,
    title: 'Test Movie',
    genreIds: [1, 2],
    voteAverage: 7.5,
    overview: '',
    posterPath: '',
  ),
];

final kTestGenres = [
  GenreResponse(id: 1, name: 'Action'),
  GenreResponse(id: 2, name: 'Drama'),
];

final kTestGenreResponse = GenreResponseWrapper(
  genres: [
    GenreResponse(id: 1, name: 'testGenre'),
  ],
);

final testException = Exception('testException');

final expectedAppInfo =
    AppInfo(version: '1.0.0', name: 'testName', buildNumber: '123');

final testMovie = Movie(
  id: 1,
  title: 'Test Movie',
  genres: ['Action', 'Drama'],
  description: '',
  posterImagePath: '',
  backdropImagePath: '',
  voteAverage: 1,
);

final testMovieResponse = MovieResponse(
  id: 1,
  title: 'Test Movie',
  genreIds: [1, 2],
  voteAverage: 7.5,
  overview: 'Test overview',
  posterPath: '/test.jpg',
);

const testPage = 1;
final testMovieResponseWrapper = MovieResponseWrapper(
  page: 1,
  results: kTestMovieResponse,
  totalPages: 10,
  totalResults: 100,
);

final testGenreResponseWrapper = GenreResponseWrapper(
  genres: kTestGenres,
);
