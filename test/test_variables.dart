import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/common/data/api_client.dart';
import 'package:movie_app/common/data/genre_response.dart';
import 'package:movie_app/common/data/local_storage_service.dart';
import 'package:movie_app/common/data/package_info_service.dart';
import 'package:movie_app/common/data/repositories/app_info_repository.dart';
import 'package:movie_app/common/data/repositories/locale_repository.dart';
import 'package:movie_app/common/data/repositories/theme_repository.dart';
import 'package:movie_app/common/domain/entities/app_info.dart';
import 'package:movie_app/features/favourite/data/repositories/database_service.dart';
import 'package:movie_app/features/popular/data/models/movie_response.dart';
import 'package:movie_app/features/popular/data/repositories/genre_repository.dart';
import 'package:movie_app/features/popular/data/repositories/movie_repository.dart';
import 'package:movie_app/features/popular/domain/entities/movie.dart';
import 'package:movie_app/features/popular/domain/entities/movie_wrapper.dart';
import 'package:movie_app/generated/l10n.dart';
import 'package:q_architecture/q_architecture.dart';

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

const languageCode = 'en';

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

final testFailure = Failure(title: S.current.unknown_error_occurred);
final testMovieFailure = Failure(title: S.current.fetch_movies_failed);

final testMovieWrapper = MovieWrapper(
  currentPage: 1,
  totalPages: 2,
  movies: [testMovie.copyWith(id: 1)],
  isLoading: false,
);

final testMovieWrapperPage2 = MovieWrapper(
  currentPage: 2,
  totalPages: 3,
  movies: [testMovie.copyWith(id: 2), testMovie.copyWith(id: 3)],
  isLoading: false,
);

class MockMovieRepository extends Mock implements MovieRepository {}

class MockAppInfoRepository extends Mock implements AppInfoRepository {}

class MockLocaleRepository extends Mock implements LocaleRepository {}

class MockThemeRepository extends Mock implements ThemeRepository {}
