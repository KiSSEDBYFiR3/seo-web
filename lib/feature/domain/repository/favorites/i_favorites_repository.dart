import 'package:seo_web/feature/domain/entity/products_entity.dart';

abstract interface class IFavoritesRepository {
  Future<List<ProductEntity>> addToFavorites({required int id});

  Future<List<ProductEntity>> deleteFromFavorites({required int id});

  Future<List<ProductEntity>> getFavorites();
}
