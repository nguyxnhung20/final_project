import 'package:dio/dio.dart';
import 'package:final_project/core/apis/dio_interceptors/logging_interceptor.dart';
import 'package:final_project/core/apis/dio_interceptors/token_interceptor.dart';
import 'package:final_project/core/utils/dot_env_util.dart';

class DioClient {
  late Dio dio;

  final baseUrl = DotEnvUtil.hostApi + DotEnvUtil.apiVesion;

  DioClient() {
    initDio();
  }

  void initDio() {
    dio = Dio();
    dio.options = BaseOptions(
      baseUrl: baseUrl,
      receiveTimeout: const Duration(seconds: 8),
      connectTimeout: const Duration(seconds: 3),
    );
    dio.interceptors.add(LoggingInterceptor());
    dio.interceptors.add(TokenInterceptor());
  }
}
