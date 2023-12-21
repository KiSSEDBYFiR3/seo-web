import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:seo_web/core/common/urls/urls.dart';
import 'package:seo_web/core/interceptors/auth_interceptor.dart';
import 'package:seo_web/feature/domain/repository/auth/i_auth_repository.dart';
import 'package:seo_web/feature/domain/repository/i_local_repository.dart';

Future<Dio> configureDio(
  List<Interceptor> interceptors,
  IAuthRepository authRepository,
  ILocalAuthRepository localAuthRepository,
) async {
  final Dio dio = Dio();
  const timeout = Duration(seconds: 30);
  dio.options
    ..baseUrl = Urls.mainUrl
    ..connectTimeout = timeout
    ..sendTimeout = timeout
    ..receiveTimeout = timeout;

  dio.interceptors.add(PrettyDioLogger());
  dio.interceptors.addAll(interceptors);

  final authInterceptor = AuthInterceptor(
    authRepository: authRepository,
    localAuthRepository: localAuthRepository,
    dio: dio,
  )..init();

  dio.interceptors.add(authInterceptor);

  return dio;
}
