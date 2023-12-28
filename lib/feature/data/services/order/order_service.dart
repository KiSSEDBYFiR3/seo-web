import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:seo_web/core/common/urls/urls.dart';

part 'order_service.g.dart';

@RestApi(parser: Parser.FlutterCompute)
abstract class OrderService {
  factory OrderService(Dio dio, {String baseUrl}) = _OrderService;

  @POST(Urls.order)
  Future<String> createOrder();
}
