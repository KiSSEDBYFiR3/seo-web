import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seo_web/core/exception/cart_exception.dart';
import 'package:seo_web/feature/domain/entity/cart_entity.dart';
import 'package:seo_web/feature/domain/entity/products_entity.dart';
import 'package:seo_web/feature/domain/managers/cart/i_cart_manager.dart';
import 'package:seo_web/feature/domain/managers/favorites/i_favorites_manager.dart';
import 'package:seo_web/feature/domain/providers/favorites/favorites_provider.dart';
import 'package:seo_web/feature/presentation/bloc/cart/cart_events.dart';
import 'package:seo_web/feature/presentation/bloc/cart/cart_states.dart';

final class CartBloc extends Bloc<CartEvent, CartState> with FavoritesProvider {
  final ICartManager _cartManager;
  final IFavoritesManager favoritesManager;

  CartEntity? get cart => _cartManager.cartState.value.data;

  EntityStateNotifier<CartEntity?> get _cartState => _cartManager.cartState;

  CartBloc({
    required ICartManager cartManager,
    required this.favoritesManager,
  })  : _cartManager = cartManager,
        super(InitialCartState()) {
    on<LoadCartEvent>(_onLoadEvent);
    on<AddToCartEvent>(_onAddToCartEvent);
    on<RemoveFromCartEvent>(_onRemoveFromCartEvent);
    on<CartErrorEvent>(_onCartErrorEvent);

    init();
  }

  void init() {
    _cartState.addListener(loadCartEvent);
  }

  void dispose() {
    _cartState.removeListener(loadCartEvent);
    favoritesState.dispose();
    _cartState.dispose();
  }

  void _onLoadEvent(LoadCartEvent event, Emitter<CartState> emit) async {
    emit(LoadingState(cart));

    try {
      await _cartManager.getCart();
      emit(LoadedState(cart));
    } on CartException catch (e) {
      addErrorEvent(e.message);
    }
  }

  void _onAddToCartEvent(AddToCartEvent event, Emitter<CartState> emit) async {
    emit(LoadingState(cart));

    try {
      await _cartManager.addToCart(product: event.product);

      emit(LoadedState(cart));
    } on CartException catch (e) {
      addErrorEvent(e.message);
    }
  }

  void _onRemoveFromCartEvent(
      RemoveFromCartEvent event, Emitter<CartState> emit) async {
    emit(LoadingState(cart));
    try {
      await _cartManager.deleteFromCart(product: event.product);
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
