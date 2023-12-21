import 'package:seo_web/feature/data/model/cart/cart_dto.dart';

abstract interface class ICartDataSource {
  Future<CartDto> addToCart({required int id});

  Future<CartDto> deleteFromCart({required int id});

  Future<CartDto> getCart();
}
