import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app/common/domain/entities/app_info.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:q_architecture/base_notifier.dart';
import 'package:q_architecture/q_architecture.dart';

final appInfoNotifierProvider =
    StateNotifierProvider<AppInfoNotifier, BaseState<AppInfo>>(
  (ref) => AppInfoNotifier(ref)..getAppInfo(),
);

class AppInfoNotifier extends BaseStateNotifier<AppInfo> {
  AppInfoNotifier(super.ref);

  Future<AppInfo> getAppInfo() async {
    try {
      state = const BaseState.loading();
      final packageInfo = await PackageInfo.fromPlatform();
      final appInfo = AppInfo.fromPackageInfo(packageInfo);
      state = BaseState.data(appInfo);
      return appInfo;
    } catch (e) {
      state = BaseState.error(Failure.generic());
      return AppInfo(
        name: '/',
        version: '0',
        buildNumber: '0',
      );
    }
  }
}
