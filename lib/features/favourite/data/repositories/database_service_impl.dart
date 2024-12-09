import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';
import 'package:movie_app/common/utils/constants/sembast_constants.dart';
import 'package:movie_app/features/favourite/data/repositories/database_service.dart';
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
  Future<void> favouriteMovie(int movieId) async {
    try {
      await _storeRef.record(movieId).put(
        _database!,
        {
          SembastConstants.favourite: true,
        },
      );
    } catch (e, st) {
      logDebug('Favourite movie failed...', e, st);
    }
  }

  @override
  Future<void> unfavouriteMovie(int movieId) async {
    try {
      await _storeRef.record(movieId).delete(_database!);
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
  Future<List<int>> getFavouriteMovieIds() async {
    try {
      final records = await _storeRef.find(_database!);
      final favouriteMoviesIds = records.map((record) => record.key).toList();
      return favouriteMoviesIds;
    } on Exception catch (e, st) {
      logDebug('Get favourite movies failed..', e, st);
      return [];
    }
  }
}
