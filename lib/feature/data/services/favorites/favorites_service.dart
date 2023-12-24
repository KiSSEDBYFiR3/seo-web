import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:seo_web/core/common/urls/urls.dart';
import 'package:seo_web/feature/data/model/product/product_dto.dart';

part 'favorites_service.g.dart';

@RestApi(parser: Parser.FlutterCompute)
abstract class FavoritesService {
  factory FavoritesService(Dio dio, {String baseUrl}) = _FavoritesService;

  @POST('${Urls.favorites}/')
  Future<List<ProductDto>> addToFavorites({@Query('id') required int id});

  @DELETE('${Urls.favorites}/')
  Future<List<ProductDto>> deleteFromFavorites({@Query('id') required int id});

  @GET(Urls.favorites)
  Future<List<ProductDto>> getFavorites();
}
