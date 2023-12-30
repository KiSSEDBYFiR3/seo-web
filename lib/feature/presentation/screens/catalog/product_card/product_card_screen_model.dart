import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:rxdart/rxdart.dart';
import 'package:seo_web/feature/domain/entity/cart_entity.dart';
import 'package:seo_web/feature/domain/entity/products_entity.dart';
import 'package:seo_web/feature/domain/managers/cart/i_cart_manager.dart';
import 'package:seo_web/feature/domain/managers/favorites/i_favorites_manager.dart';
import 'package:seo_web/feature/domain/managers/products/i_products_manager.dart';
import 'package:seo_web/feature/domain/providers/cart/cart_provider.dart';
import 'package:seo_web/feature/domain/providers/favorites/favorites_provider.dart';

abstract interface class IProductModel extends ElementaryModel {
  BehaviorSubject<ProductEntity> get selectedProductController;

  void findProductById(int id);

  EntityStateNotifier<List<ProductEntity>> get favoritesState;
  EntityStateNotifier<CartEntity?> get cartState;

  Future<void> addToCart({required ProductEntity product});

  Future<void> deleteFromFavorites({required ProductEntity product});
  Future<void> addToFavorites({required ProductEntity product});

  Future<void> getAllProducts();
}

final class ProductModel extends ElementaryModel
    with FavoritesProvider, CartProvider
    implements IProductModel {
  final IProductsManager productsManager;

  ProductModel({
    super.errorHandler,
    required this.productsManager,
    required this.cartManager,
    required this.favoritesManager,
  });

  @override
  BehaviorSubject<ProductEntity> get selectedProductController =>
      productsManager.selectedProductController;

  @override
  void findProductById(int id) => productsManager.findProductById(id);

  @override
  final ICartManager cartManager;

  @override
  final IFavoritesManager favoritesManager;

  @override
  Future<void> getAllProducts() async => await productsManager.getAllProducts();
}
