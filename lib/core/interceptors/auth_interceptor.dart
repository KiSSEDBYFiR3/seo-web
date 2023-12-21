import 'package:dio/dio.dart';
import 'package:seo_web/core/common/consts/consts.dart';
import 'package:seo_web/feature/domain/repository/auth/i_auth_repository.dart';
import 'package:seo_web/feature/domain/repository/i_local_repository.dart';

class AuthInterceptor extends Interceptor {
  final IAuthRepository authRepository;
  final ILocalAuthRepository localAuthRepository;
  final Dio _dio;

  late String _refreshToken;
  late String _accessToken;

  AuthInterceptor({
    required this.authRepository,
    required this.localAuthRepository,
    required Dio dio,
  }) : _dio = dio;

  Future<void> init() async {
    await authRepository.updateToken();
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['authorization'] = _accessToken;

    if (options.path == '/auth/refresh/') {
      options.headers['authorization'] = _refreshToken;
    }

    if (options.path == '/auth/') {
      options.headers['authorization'] = Consts.basicAuthToken;
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    try {
      if (err.response?.statusCode == 401) {
        await authRepository.updateToken();
        final response = await _retry(err.requestOptions);

        handler.resolve(response);

        return;
      }
      handler.next(err);
    } catch (e) {
      handler.reject(err);
    }
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );

    return _dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
}
