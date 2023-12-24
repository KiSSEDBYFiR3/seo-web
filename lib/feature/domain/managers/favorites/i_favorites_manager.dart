import 'package:elementary_helper/elementary_helper.dart';
import 'package:rxdart/rxdart.dart';
import 'package:seo_web/feature/domain/entity/products_entity.dart';

abstract interface class IFavoritesManager {
  EntityStateNotifier<List<ProductEntity>> get favoritesState;

  BehaviorSubject<List<ProductEntity>> get favoritesChangedController;

  Future<void> addToFavorites({required ProductEntity product});

  Future<void> deleteFromFavorites({required ProductEntity product});

  Future<void> getFavorites();

  void init();

  void dispose();
}
