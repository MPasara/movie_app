import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app/common/data/repositories/app_info_repository.dart';
import 'package:movie_app/common/domain/entities/app_info.dart';
import 'package:q_architecture/base_notifier.dart';

final appInfoNotifierProvider =
    NotifierProvider<AppInfoNotifier, BaseState<AppInfo>>(
  () => AppInfoNotifier(),
);

class AppInfoNotifier extends BaseNotifier<AppInfo> {
  late AppInfoRepository _appInfoRepository;
  @override
  void prepareForBuild() {
    _appInfoRepository = ref.watch(appInfoRepositoryProvider);
    Future.microtask(() => getAppInfo());
  }

  Future getAppInfo() => execute(
        _appInfoRepository.getVersionNumber(),
        globalFailure: true,
        withLoadingState: true,
      );
}
