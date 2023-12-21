import 'package:seo_web/feature/domain/entity/cart_entity.dart';

abstract interface class ICartRepository {
  Future<CartEntity> addToCart({required int id});

  Future<CartEntity> deleteFromCart({required int id});

  Future<CartEntity> getCart();
}
