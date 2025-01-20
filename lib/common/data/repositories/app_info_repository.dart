import 'package:either_dart/either.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app/common/data/package_info_service.dart';
import 'package:movie_app/common/data/providers.dart';
import 'package:movie_app/common/domain/entities/app_info.dart';
import 'package:movie_app/generated/l10n.dart';
import 'package:q_architecture/q_architecture.dart';

final appInfoRepositoryProvider = Provider<AppInfoRepository>(
  (ref) => AppInfoRepositoryImpl(
    ref.watch(packageInfoServiceProvider),
  ),
);

abstract class AppInfoRepository {
  EitherFailureOr<AppInfo> getVersionNumbebr();
}

class AppInfoRepositoryImpl implements AppInfoRepository {
  final PackageInfoService _packageInfoService;

  AppInfoRepositoryImpl(this._packageInfoService);

  @override
  EitherFailureOr<AppInfo> getVersionNumbebr() async {
    try {
      final versionNumber = await _packageInfoService.getVersionNumber();
      return Right(versionNumber);
    } catch (e, st) {
      return Left(
        Failure(
          title: S.current.fetch_app_version_failed,
          error: e,
          stackTrace: st,
        ),
      );
    }
  }
}
