import 'package:dio/dio.dart';
import 'package:loggy/loggy.dart';
import 'package:movie_app/common/utils/constants/constants.dart';

class CustomInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logDebug('REQUEST[${options.method}] => PATH: ${options.path}');
    options.headers['Authorization'] = 'Bearer $kBearerToken';
    super.onRequest(options, handler);
  }
}
