import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:seo_web/feature/domain/entity/cart_entity.dart';
import 'package:seo_web/feature/domain/entity/products_entity.dart';
import 'package:seo_web/feature/domain/managers/cart/i_cart_manager.dart';
import 'package:seo_web/feature/domain/managers/products/i_products_manager.dart';

abstract interface class ICatalogModel extends ElementaryModel {
  Future<void> deleteFromCart({required ProductEntity product});
  Future<void> getCart();
  Future<void> addToCart({required ProductEntity product});
  EntityStateNotifier<CartEntity?> get cartState;
  EntityStateNotifier<List<ProductEntity>> get productsState;
  Future<void> getAllProducts();
  Future<void> deleteFromFavorites({required ProductEntity product});
  Future<void> getFavorites();
  Future<void> addToFavorites({required ProductEntity product});
}

final class CatalogModel extends ElementaryModel implements ICatalogModel {
  final ICartManager _cartManager;
  final IProductsManager _productsManager;

  CatalogModel({
    required ICartManager cartManager,
    required IProductsManager productsManager,
  })  : _cartManager = cartManager,
        _productsManager = productsManager;

  @override
  Future<void> addToCart({required ProductEntity product}) async =>
      await _cartManager.addToCart(product: product);

  @override
  EntityStateNotifier<CartEntity?> get cartState => _cartManager.cartState;

  @override
  Future<void> deleteFromCart({required ProductEntity product}) async =>
      await _cartManager.deleteFromCart(product: product);

  @override
  Future<void> getCart() async => await _cartManager.getCart();

  @override
  Future<void> getAllProducts() async =>
      await _productsManager.getAllProducts();

  @override
  EntityStateNotifier<List<ProductEntity>> get productsState =>
      _productsManager.productsState;

  @override
  void init() async {
    await getAllProducts();
    super.init();
  }

  @override
  void dispose() {
    productsState.dispose();
    cartState.dispose();
    super.dispose();
  }

  @override
  Future<void> addToFavorites({required ProductEntity product}) {
    // TODO: implement addToFavorites
    throw UnimplementedError();
  }

  @override
  Future<void> deleteFromFavorites({required ProductEntity product}) {
    // TODO: implement deleteFromFavorites
    throw UnimplementedError();
  }

  @override
  Future<void> getFavorites() {
    // TODO: implement getFavorites
    throw UnimplementedError();
  }
}
