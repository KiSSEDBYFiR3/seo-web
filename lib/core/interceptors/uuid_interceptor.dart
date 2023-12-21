import 'package:dio/dio.dart';

class UUIDInterceptor extends Interceptor {
  final String uuid;
  const UUIDInterceptor(this.uuid);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['UUID'] = uuid;
    super.onRequest(options, handler);
  }
}
