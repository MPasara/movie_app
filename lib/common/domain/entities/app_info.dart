import 'package:package_info_plus/package_info_plus.dart';

class AppInfo {
  AppInfo({
    required this.name,
    required this.version,
    required this.buildNumber,
  });

  final String name;
  final String version;
  final String buildNumber;

  factory AppInfo.fromPackageInfo(PackageInfo info) => AppInfo(
        name: info.appName,
        version: info.version,
        buildNumber: info.buildNumber,
      );
}
