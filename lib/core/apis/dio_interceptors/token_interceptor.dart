import 'package:dio/dio.dart';
import 'package:final_project/core/utils/dot_env_util.dart';

class TokenInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final apiKey = DotEnvUtil.apiKey;
    options.headers["Authorization"] = "Bearer $apiKey";
    return handler.next(options);
  }
}
