import 'package:elementary_helper/elementary_helper.dart';
import 'package:seo_web/feature/domain/entity/cart_entity.dart';
import 'package:seo_web/feature/domain/entity/products_entity.dart';

abstract interface class ICartManager {
  EntityStateNotifier<CartEntity?> get cartState;

  Future<void> addToCart({required ProductEntity product});

  Future<void> deleteFromCart({required ProductEntity product});

  Future<void> getCart();

  Future<void> createOrder();

  void init();

  void dispose();
}
