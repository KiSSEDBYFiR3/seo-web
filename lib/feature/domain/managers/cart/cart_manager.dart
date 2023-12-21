import 'package:elementary_helper/elementary_helper.dart';
import 'package:seo_web/feature/domain/entity/cart_entity.dart';
import 'package:seo_web/feature/domain/entity/products_entity.dart';
import 'package:seo_web/feature/domain/managers/cart/i_cart_manager.dart';
import 'package:seo_web/feature/domain/repository/cart/i_cart_repository.dart';
import 'package:seo_web/feature/domain/repository/order/i_order_repository.dart';

class CartManager implements ICartManager {
  final ICartRepository _cartRepository;

  final IOrderRepository _orderRepository;

  CartManager(
      {required ICartRepository cartRepository,
      required IOrderRepository orderRepository})
      : _cartRepository = cartRepository,
        _orderRepository = orderRepository;

  @override
  EntityStateNotifier<CartEntity?> get cartState => _cartState;

  final EntityStateNotifier<CartEntity?> _cartState = EntityStateNotifier();

  @override
  Future<void> addToCart({required ProductEntity product}) async {
    final oldCart = _cartState.value.data;

    final oldProducts = oldCart?.products ?? [];

    oldProducts.add(product);

    final appendedCart = oldCart?.copyWith(products: oldProducts);

    _cartState.loading(appendedCart);

    final cart = await _cartRepository.addToCart(id: product.id);
    _cartState.content(cart);
  }

  @override
  Future<void> createOrder() async => await _orderRepository.createOrder();

  @override
  Future<void> deleteFromCart({required ProductEntity product}) async {
    final oldCart = _cartState.value.data;

    final oldProducts = oldCart?.products;
    final index =
        oldProducts?.indexWhere((element) => element.id == product.id);

    if (index != null) {
      oldProducts?.removeAt(index);
    }

    final reducedCart = oldCart?.copyWith(products: oldProducts ?? []);

    _cartState.loading(reducedCart);

    final cart = await _cartRepository.deleteFromCart(id: product.id);
    _cartState.content(cart);
  }

  @override
  Future<void> getCart() async {
    final oldCart = _cartState.value.data;
    _cartState.loading(oldCart);

    final cart = await _cartRepository.getCart();
    _cartState.content(cart);
  }

  @override
  void init() async {
    await getCart();
  }

  @override
  void dispose() {
    _cartState.dispose();
    cartState.dispose();
  }
}
