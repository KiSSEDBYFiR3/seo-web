import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:seo_web/core/common/urls/urls.dart';
import 'package:seo_web/feature/data/model/product/product_dto.dart';

part 'products_service.g.dart';

@RestApi(parser: Parser.FlutterCompute)
abstract class ProductsService {
  factory ProductsService(Dio dio, {String baseUrl}) = _ProductsService;

  @GET(Urls.product)
  Future<List<ProductDto>> getAllProducts();
}
