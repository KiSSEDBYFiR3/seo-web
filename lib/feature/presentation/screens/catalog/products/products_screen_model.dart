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

abstract interface class IProductsModel extends ElementaryModel {
  Future<void> deleteFromCart({required ProductEntity product});
  Future<void> getCart();
  Future<void> addToCart({required ProductEntity product});

  EntityStateNotifier<CartEntity?> get cartState;
  EntityStateNotifier<List<ProductEntity>> get productsState;
  EntityStateNotifier<List<ProductEntity>> get favoritesState;

  BehaviorSubject<String> get selectedCategoryName;

  Future<void> getAllProducts();

  Future<void> deleteFromFavorites({required ProductEntity product});
  Future<void> getFavorites();
  Future<void> addToFavorites({required ProductEntity product});
}

final class ProductsModel extends ElementaryModel
    with FavoritesProvider, CartProvider
    implements IProductsModel {
  final IProductsManager productsManager;

  @override
  final IFavoritesManager favoritesManager;
  @override
  final ICartManager cartManager;

  ProductsModel({
    required this.cartManager,
    required this.favoritesManager,
    required this.productsManager,
  });
  @override
  Future<void> addToCart({required ProductEntity product}) async =>
      await cartManager.addToCart(product: product);

  @override
  EntityStateNotifier<CartEntity?> get cartState => cartManager.cartState;

  @override
  Future<void> deleteFromCart({required ProductEntity product}) async =>
      await cartManager.deleteFromCart(product: product);

  @override
  Future<void> getCart() async => await cartManager.getCart();

  @override
  Future<void> getAllProducts() async => await productsManager.getAllProducts();

  @override
  EntityStateNotifier<List<ProductEntity>> get productsState =>
      productsManager.productsState;

  @override
  BehaviorSubject<String> get selectedCategoryName =>
      productsManager.selectedCategoryName;
}
