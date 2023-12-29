import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:seo_web/core/common/consts/consts.dart';
import 'package:seo_web/core/interceptors/auth_interceptor.dart';
import 'package:seo_web/feature/domain/repository/auth/i_auth_repository.dart';
import 'package:seo_web/feature/domain/repository/i_local_repository.dart';

import 'package:seo_web/core/common/urls/main_url.dart';

Future<Dio> configureDio(
  List<Interceptor> interceptors,
  IAuthRepository Function(Dio) authRepository,
  ILocalAuthRepository localAuthRepository,
) async {
  final Dio dio = Dio();
  const timeout = Duration(seconds: 30);
  dio.options
    ..baseUrl = MainUrl.url
    ..contentType = Headers.formUrlEncodedContentType
    ..connectTimeout = timeout
    ..sendTimeout = timeout
    ..receiveTimeout = timeout;

  dio.interceptors.add(PrettyDioLogger());
  dio.interceptors.addAll(interceptors);

  final refreshToken = await localAuthRepository.getRefreshToken();
  final accessToken = await localAuthRepository.getAccessToken();

  final authInterceptor = AuthInterceptor(
    authRepository: authRepository(dio),
    dio: dio,
    accessToken: accessToken,
    refreshToken: refreshToken,
    basicToken: Consts.basicAuthToken,
  );

  dio.interceptors.add(authInterceptor);
  await authInterceptor.init();

  return dio;
}
