import 'package:seo_web/feature/data/data_source/remote_data_source/cart/i_cart_data_source.dart';
import 'package:seo_web/feature/data/model/cart/cart_dto.dart';
import 'package:seo_web/feature/data/services/cart/cart_service.dart';

class CartDataSource implements ICartDataSource {
  final CartService _cartService;

  const CartDataSource({required CartService cartService})
      : _cartService = cartService;

  @override
  Future<CartDto> addToCart({required int id}) async =>
      await _cartService.addToCart(id: id);

  @override
  Future<CartDto> deleteFromCart({required int id}) async =>
      _cartService.deleteFromCart(id: id);

  @override
  Future<CartDto> getCart() async => await _cartService.getCart();
}
