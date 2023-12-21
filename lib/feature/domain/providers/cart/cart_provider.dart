import 'package:elementary_helper/elementary_helper.dart';
import 'package:seo_web/feature/domain/entity/cart_entity.dart';
import 'package:seo_web/feature/domain/entity/products_entity.dart';
import 'package:seo_web/feature/domain/managers/cart/i_cart_manager.dart';

abstract interface class ICartProvider {
  ICartManager get cartManager;

  EntityStateNotifier<CartEntity?> get cartState;

  Future<void> deleteFromCart({required ProductEntity product});
  Future<void> getCart();
  Future<void> addToCart({required ProductEntity product});
}

mixin CartProvider implements ICartProvider {
  @override
  EntityStateNotifier<CartEntity?> get cartState => cartManager.cartState;

  @override
  Future<void> deleteFromCart({required ProductEntity product}) async =>
      await cartManager.deleteFromCart(product: product);

  @override
  Future<void> getCart() async => await cartManager.getCart();

  @override
  Future<void> addToCart({required ProductEntity product}) async =>
      await cartManager.addToCart(product: product);
}
