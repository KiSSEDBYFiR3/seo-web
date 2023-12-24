import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:seo_web/core/common/urls/urls.dart';
import 'package:seo_web/feature/data/model/cart/cart_dto.dart';

part 'cart_service.g.dart';

@RestApi(parser: Parser.FlutterCompute)
abstract class CartService {
  factory CartService(Dio dio, {String baseUrl}) = _CartService;

  @POST('${Urls.cart}/')
  Future<CartDto> addToCart({@Query('id') required int id});

  @DELETE('${Urls.cart}/')
  Future<CartDto> deleteFromCart({@Query('id') required int id});

  @GET(Urls.cart)
  Future<CartDto> getCart();
}
