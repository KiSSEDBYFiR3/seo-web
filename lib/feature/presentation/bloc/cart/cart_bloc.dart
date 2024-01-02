import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seo_web/core/exception/app_exceptions.dart';
import 'package:seo_web/feature/domain/entity/cart_entity.dart';
import 'package:seo_web/feature/domain/entity/products_entity.dart';
import 'package:seo_web/feature/domain/managers/cart/i_cart_manager.dart';
import 'package:seo_web/feature/domain/managers/favorites/i_favorites_manager.dart';
import 'package:seo_web/feature/domain/providers/favorites/favorites_provider.dart';
import 'package:seo_web/feature/presentation/bloc/cart/cart_events.dart';
import 'package:seo_web/feature/presentation/bloc/cart/cart_states.dart';

final class CartBloc extends Bloc<CartEvent, CartState> with FavoritesProvider {
  final ICartManager cartManager;
  @override
  final IFavoritesManager favoritesManager;

  CartEntity? get cart => cartManager.cartState.value.data;

  late final StreamSubscription _cartChangeSubscription;

  CartBloc({
    required this.cartManager,
    required this.favoritesManager,
  }) : super(InitialCartState()) {
    on<LoadCartEvent>(_onLoadEvent);
    on<AddToCartEvent>(_onAddToCartEvent);
    on<RemoveFromCartEvent>(_onRemoveFromCartEvent);
    on<CartErrorEvent>(_onCartErrorEvent);
    on<UpdateStateEvent>(_onUpdateStateEvent);
    on<CreateOrderEvent>(_onCreateOrderEvent);

    init();
  }

  void init() {
    _cartChangeSubscription =
        cartManager.cartChangedController.listen(_onCartChanged);
  }

  void _onUpdateStateEvent(UpdateStateEvent event, Emitter<CartState> emit) {
    emit(LoadingState(event.cart));

    emit(LoadedState(event.cart));
  }

  void dispose() {
    _cartChangeSubscription.cancel();
    cartManager.dispose();
  }

  void _onCartChanged(CartEntity cart) {
    addUpdateStateEvent(cart);
  }

  void _onLoadEvent(LoadCartEvent event, Emitter<CartState> emit) async {
    emit(LoadingState(cart));

    try {
      await cartManager.getCart();
      emit(LoadedState(cart));
    } on CartException catch (e) {
      addErrorEvent(e.message);
    }
  }

  void addCreateOrderEvent() {
    add(CreateOrderEvent());
  }

  void _onCreateOrderEvent(
      CreateOrderEvent event, Emitter<CartState> emit) async {
    emit(LoadedState(cart));
    try {
      await cartManager.createOrder();
      loadCartEvent();
    } on OrderException catch (e) {
      addErrorEvent(e.message);
    }
  }

  void _onAddToCartEvent(AddToCartEvent event, Emitter<CartState> emit) async {
    emit(LoadingState(cart));

    try {
      await cartManager.addToCart(product: event.product);

      emit(LoadedState(cart));
    } on CartException catch (e) {
      addErrorEvent(e.message);
    }
  }

  void _onRemoveFromCartEvent(
      RemoveFromCartEvent event, Emitter<CartState> emit) async {
    emit(LoadingState(cart));
    try {
      await cartManager.deleteFromCart(product: event.product);
      emit(LoadedState(cart));
    } on CartException catch (e) {
      addErrorEvent(e.message);
    }
  }

  void _onCartErrorEvent(CartErrorEvent event, Emitter<CartState> emit) {
    emit(ErrorState(message: event.message, cart: cart));
  }

  void addToCartEvent(ProductEntity product) {
    add(AddToCartEvent(product: product));
  }

  void addUpdateStateEvent(CartEntity cart) {
    add(UpdateStateEvent(cart: cart));
  }

  void removeFromCartEvent(ProductEntity product) {
    add(RemoveFromCartEvent(product: product));
  }

  void loadCartEvent() {
    add(LoadCartEvent());
  }

  void addErrorEvent(String message) {
    add(CartErrorEvent(message));
  }
}
