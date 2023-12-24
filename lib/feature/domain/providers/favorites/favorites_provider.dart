import 'package:elementary_helper/elementary_helper.dart';
import 'package:seo_web/feature/domain/entity/products_entity.dart';
import 'package:seo_web/feature/domain/managers/favorites/i_favorites_manager.dart';

abstract interface class IFavoritesProvider {
  IFavoritesManager get favoritesManager;

  EntityStateNotifier<List<ProductEntity>> get favoritesState;

  Future<void> deleteFromFavorites({required ProductEntity product});
  Future<void> getFavorites();
  Future<void> addToFavorites({required ProductEntity product});
}

mixin FavoritesProvider implements IFavoritesProvider {
  @override
  EntityStateNotifier<List<ProductEntity>> get favoritesState =>
      favoritesManager.favoritesState;
  @override
  Future<void> deleteFromFavorites({required ProductEntity product}) async =>
      await favoritesManager.deleteFromFavorites(product: product);

  @override
  Future<void> getFavorites() async => await favoritesManager.getFavorites();

  @override
  Future<void> addToFavorites({required ProductEntity product}) async =>
      await favoritesManager.addToFavorites(product: product);
}
