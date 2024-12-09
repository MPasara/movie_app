import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';
import 'package:movie_app/common/utils/constants/sembast_constants.dart';
import 'package:movie_app/features/favourite/data/repositories/database_service.dart';
import 'package:movie_app/features/popular/domain/entities/movie.dart';
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
  Database? _database;

  @override
  Future<void> initDatabase() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      await dir.create(recursive: true);
      final dbPath = join(dir.path, SembastConstants.dbName);
      _database = await databaseFactoryIo.openDatabase(dbPath);
    } catch (e, st) {
      logDebug('Init sembast database failed...', e, st);
    }
  }

  @override
  Future<void> favouriteMovie(Movie movie) async {
    try {
      await _storeRef.record(movie.id).put(
            _database!,
            movie.toJson(),
          );
    } catch (e, st) {
      logDebug('Favourite movie failed...', e, st);
    }
  }

  @override
  Future<void> unfavouriteMovie(Movie movie) async {
    try {
      await _storeRef.record(movie.id).delete(_database!);
    } catch (e, st) {
      logDebug('Unfavourite movie failed...', e, st);
    }
  }

  @override
  Future<bool> isMovieFavourite(int movieId) async {
    try {
      final record = await _storeRef.record(movieId).get(_database!);
      return record != null;
    } catch (e, st) {
      logDebug('Is movie favourite failed...', e, st);
      return false;
    }
  }

  @override
  Future<List<Movie>> getFavouriteMovies() async {
    final favouriteMovies = <Movie>[];
    try {
      final records = await _storeRef.find(_database!);

      for (final record in records) {
        final movieJson = record.value as Map<String, dynamic>;
        favouriteMovies.add(Movie.fromJson(movieJson));
      }

      return favouriteMovies;
    } on Exception catch (e, st) {
      logDebug('Get favourite movies failed..', e, st);
      return [];
    }
  }
}
