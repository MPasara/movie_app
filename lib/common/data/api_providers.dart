import 'package:dio/dio.dart';
import 'package:flutter_loggy_dio/flutter_loggy_dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app/common/data/api_client.dart';
import 'package:movie_app/main/app_environment.dart';

final apiClientProvider = Provider<ApiClient>(
  (ref) => ApiClient(
    ref.watch(
      dioProvider(EnvInfo.apiBaseUrl),
    ),
  ),
  name: 'Api provider',
);

final dioProvider = Provider.family<Dio, String>(
  (ref, baseUrl) {
    final dio = Dio(
      BaseOptions(baseUrl: baseUrl),
    );
    dio.interceptors.addAll(
      [
        LoggyDioInterceptor(requestBody: true, requestHeader: true),
        /* CustomInterceptors(
          ref.read(hiveProvider.notifier),
          dio,
        ), */
      ],
    );
    return dio;
  },
  name: 'Dio provider',
);
