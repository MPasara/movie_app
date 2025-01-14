import 'package:either_dart/either.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app/common/data/local_storage_service.dart';
import 'package:movie_app/generated/l10n.dart';
import 'package:q_architecture/q_architecture.dart';

final localeRepositoryProvider = Provider<LocaleRepository>(
  (ref) => LocaleRepositoryImpl(
    ref.watch(localStorageServiceProvider),
  ),
  name: 'Locale Repository Provider',
);

abstract class LocaleRepository {
  EitherFailureOr<void> setLanguage(String languageCode);
  EitherFailureOr<String?> getLanguage();
}

class LocaleRepositoryImpl implements LocaleRepository {
  LocaleRepositoryImpl(this._localStorageService);

  final LocalStorageService _localStorageService;

  @override
  EitherFailureOr<String?> getLanguage() async {
    try {
      final languageCode = await _localStorageService.getLanguageCode();
      return Right(languageCode);
    } catch (e, st) {
      return Left(
        Failure(
          title: S.current.fetch_language_failed,
          error: e,
          stackTrace: st,
        ),
      );
    }
  }

  @override
  EitherFailureOr<void> setLanguage(String languageCode) async {
    try {
      final code = await _localStorageService.setLanguageCode(languageCode);
      return Right(code);
    } catch (e, st) {
      return Left(
        Failure(
          title: S.current.set_language_failed,
          error: e,
          stackTrace: st,
        ),
      );
    }
  }
}
