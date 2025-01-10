// ignore_for_file: always_use_package_imports

import 'package:dio/dio.dart';
import 'package:flutter_loggy_dio/flutter_loggy_dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app/common/data/package_info_service.dart';
import 'package:movie_app/common/utils/header_interceptor.dart';
import 'package:movie_app/features/favourite/data/repositories/database_service.dart';
import 'package:movie_app/features/favourite/data/repositories/database_service_impl.dart';

import '../../main/app_environment.dart';
import 'api_client.dart';

final apiClientProvider = Provider<ApiClient>(
  (ref) => ApiClient(
    ref.watch(
      dioProvider(EnvInfo.apiBaseUrl),
    ),
  ),
  name: 'Api client provider',
);

final dioProvider = Provider.family<Dio, String>(
  (ref, baseUrl) => Dio(
    BaseOptions(baseUrl: baseUrl),
  )..interceptors.addAll(
      [
        LoggyDioInterceptor(requestBody: true, requestHeader: true),
        HeaderInterceptor(),
      ],
    ),
  name: 'Dio provider',
);

final databaseServiceProvider = Provider<DatabaseService>(
  (ref) => DatabaseServiceImpl(),
  name: 'Database service provider',
);

final packageInfoServiceProvider = Provider<PackageInfoService>(
  (ref) => PackageInfoService(),
  name: 'package Info Service provider',
);
