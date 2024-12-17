import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app/common/utils/constants/sembast_constants.dart';
import 'package:movie_app/features/favourite/data/repositories/database_service.dart';
import 'package:movie_app/features/popular/data/models/movie_response.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';

final databaseServiceProvider = Provider<DatabaseService>(
  (ref) => DatabaseServiceImpl(),
  name: 'Database service provider',
);

class DatabaseServiceImpl implements DatabaseService {
  final _storeRef =
      intMapStoreFactory.store(SembastConstants.favouriteMoviesStore);
  late final Database _database;

  @override
  Future<void> initDatabase() async {
    final dir = await getApplicationDocumentsDirectory();
    await dir.create(recursive: true);
    final dbPath = join(dir.path, SembastConstants.dbName);
    _database = await databaseFactoryIo.openDatabase(dbPath);
  }

  @override
  Future<void> favouriteMovie(MovieResponse movie) async {
    await _storeRef.record(movie.id).put(
          _database,
          movie.toJson(),
        );
  }

  @override
  Future<void> unfavouriteMovie(int movieId) async =>
      _storeRef.record(movieId).delete(_database);

  @override
  Future<bool> isMovieFavourite(int movieId) async {
    final record = await _storeRef.record(movieId).get(_database);
    return record != null;
  }

  @override
  Future<List<MovieResponse>> getFavouriteMovies() async {
    final favouriteMovies = <MovieResponse>[];
    final records = await _storeRef.find(_database);

    for (final record in records) {
      final movieJson = record.value;
      favouriteMovies.add(MovieResponse.fromJson(movieJson));
    }

    return favouriteMovies;
  }
}
