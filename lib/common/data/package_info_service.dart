import 'package:movie_app/common/domain/entities/app_info.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PackageInfoService {
  Future<AppInfo> getVersionNumber() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final appInfo = AppInfo.fromPackageInfo(packageInfo);
    return appInfo;
  }
}
