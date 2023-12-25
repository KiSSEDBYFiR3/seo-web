import 'package:elementary_helper/elementary_helper.dart';
import 'package:rxdart/rxdart.dart';
import 'package:seo_web/core/common/errors_bus/errors_bus.dart';
import 'package:seo_web/core/exception/exceptions.dart';
import 'package:seo_web/feature/data/model/cart/mapper/cart_mapper.dart';
import 'package:seo_web/feature/domain/entity/cart_entity.dart';
import 'package:seo_web/feature/domain/entity/cart_offer_entity.dart';
import 'package:seo_web/feature/domain/entity/products_entity.dart';
import 'package:seo_web/feature/domain/managers/cart/i_cart_manager.dart';
import 'package:seo_web/feature/domain/repository/cart/i_cart_repository.dart';
import 'package:seo_web/feature/domain/repository/order/i_order_repository.dart';
import 'package:logging/logging.dart';

class CartManager implements ICartManager {
  final ICartRepository _cartRepository;
  final IErrorsBus _errorsBus;

  final IOrderRepository _orderRepository;

  Logger get _logger => Logger('Cart');

  CartManager({
    required ICartRepository cartRepository,
    required IOrderRepository orderRepository,
    required IErrorsBus errorsBus,
  })  : _cartRepository = cartRepository,
        _orderRepository = orderRepository,
        _errorsBus = errorsBus;

  @override
  EntityStateNotifier<CartEntity?> get cartState => _cartState;

  final EntityStateNotifier<CartEntity?> _cartState = EntityStateNotifier();

  @override
  Future<void> addToCart({required ProductEntity product}) async {
    try {
      final oldCart = _cartState.value.data;

      final oldOffers = oldCart?.offers ?? [];

      List<CartOfferEntity> newOffers = [];

      newOffers.addAll(oldOffers);

      newOffers.add(
        CartOfferEntity(
          id: product.id,
          count: 1,
          product: product,
        ),
      );

      newOffers = recalculateOffers(newOffers);

      final appendedCart = oldCart?.copyWith(offers: newOffers);

      _cartState.loading(appendedCart);

      final cart = await _cartRepository.addToCart(id: product.id);
      _cartState.content(cart);

      _cartChangedController.add(cart);
    } catch (e) {
      _logger.shout(e);

      _errorsBus.addException(Exceptions.addToCartException);

      throw Exceptions.addToCartException;
    }
  }

  @override
  Future<void> createOrder() async {
    try {
      await _orderRepository.createOrder();
    } catch (e) {
      _logger.shout(e);

      _errorsBus.addException(Exceptions.orderException);
      throw Exceptions.orderException;
    }
  }

  @override
  Future<void> deleteFromCart({required ProductEntity product}) async {
    try {
      final oldCart = _cartState.value.data;

      final oldOffers = oldCart?.offers;

      List<CartOfferEntity> newOffers = [];

      newOffers.addAll(oldOffers ?? []);

      final index = newOffers.indexWhere((element) => element.id == product.id);

      if (index != -1) {
        newOffers.removeAt(index);
      }

      newOffers = recalculateOffers(newOffers);

      final reducedCart = oldCart?.copyWith(offers: newOffers);

      _cartState.loading(reducedCart);

      final cart = await _cartRepository.deleteFromCart(id: product.id);
      _cartState.content(cart);

      _cartChangedController.add(cart);
    } catch (e) {
      _logger.shout(e);
      _errorsBus.addException(Exceptions.deleteFromCartException);
      throw Exceptions.deleteFromCartException;
    }
  }

  @override
  Future<void> getCart() async {
    try {
      final oldCart = _cartState.value.data;
      _cartState.loading(oldCart);

      final cart = await _cartRepository.getCart();
      _cartState.content(cart);

      _cartChangedController.add(cart);
    } catch (e) {
      _logger.shout(e);

      _errorsBus.addException(Exceptions.getCartException);
      throw Exceptions.getCartException;
    }
  }

  @override
  void init() async {
    await getCart();
  }

  @override
  void dispose() {
    _cartChangedController.close();
    cartChangedController.close();
    _errorsBus.dispose();
    _cartState.dispose();
    cartState.dispose();
  }

  @override
  BehaviorSubject<CartEntity> get cartChangedController =>
      _cartChangedController;

  final BehaviorSubject<CartEntity> _cartChangedController = BehaviorSubject();
}
