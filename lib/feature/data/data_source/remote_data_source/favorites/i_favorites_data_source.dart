import 'package:seo_web/feature/data/model/product/product_dto.dart';

abstract interface class IFavoritesDataSource {
  Future<List<ProductDto>> addToFavorites({required int id});

  Future<List<ProductDto>> deleteFromFavorites({required int id});

  Future<List<ProductDto>> getFavorites();
}
