import 'package:dio/dio.dart';
import 'package:seo_web/feature/domain/repository/auth/i_auth_repository.dart';

class AuthInterceptor extends Interceptor {
  final IAuthRepository authRepository;
  final Dio _dio;

  String refreshToken;
  String accessToken;
  final String basicToken;

  AuthInterceptor({
    required this.authRepository,
    required Dio dio,
    required this.accessToken,
    required this.refreshToken,
    required this.basicToken,
  }) : _dio = dio;

  Future<void> init() async {
    if (accessToken.isEmpty || refreshToken.isEmpty) {
      final tokens = await authRepository.authorize();
      accessToken = tokens.$1;
      refreshToken = tokens.$2;
      return;
    }
    final tokens = await authRepository.updateToken();
    accessToken = tokens.$1;
    refreshToken = tokens.$2;
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['authorization'] = 'Bearer $accessToken';

    if (options.path == '/auth/refresh') {
      options.headers['authorization'] = 'Bearer $refreshToken';
    }

    if (options.path == '/auth') {
      options.headers['authorization'] = basicToken;
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    try {
      if (err.response?.statusCode == 401) {
        if (err.requestOptions.path != '/auth/refresh') {
          final tokens = await authRepository.updateToken();
          accessToken = tokens.$1;
          refreshToken = tokens.$2;
        } else {
          final tokens = await authRepository.authorize();
          accessToken = tokens.$1;
          refreshToken = tokens.$2;
        }
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
