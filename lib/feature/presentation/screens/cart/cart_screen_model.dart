import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:seo_web/core/exception/app_exceptions.dart';
import 'package:seo_web/feature/domain/entity/cart_entity.dart';
import 'package:seo_web/feature/domain/entity/products_entity.dart';
import 'package:seo_web/feature/domain/managers/favorites/i_favorites_manager.dart';
import 'package:seo_web/feature/domain/providers/favorites/favorites_provider.dart';
import 'package:seo_web/feature/presentation/bloc/cart/cart_bloc.dart';
import 'package:seo_web/feature/presentation/bloc/cart/cart_states.dart';

final class CartModel extends ElementaryModel
    with FavoritesProvider
    implements ICartModel {
  final CartBloc _bloc;

  CartModel({
    required CartBloc bloc,
    required this.favoritesManager,
  }) : _bloc = bloc;

  late final StreamSubscription<CartState> _blocSubscription;

  @override
  void addToCart({required ProductEntity product}) =>
      _bloc.addToCartEvent(product);

  @override
  EntityStateNotifier<CartEntity?> cartState = EntityStateNotifier();

  @override
  EntityStateNotifier<List<ProductEntity>> get favoritesState =>
      _bloc.favoritesState;

  @override
  void deleteFromCart({required ProductEntity product}) =>
      _bloc.removeFromCartEvent(product);

  @override
  void getCart() => _bloc.loadCartEvent();

  @override
  void init() {
    _bloc.stream.listen(_parseStates);
    super.init();
  }

  void _parseStates(CartState state) {
    return switch (state) {
      LoadingState() => cartState.loading(state.cart),
      LoadedState() => cartState.content(state.cart),
      ErrorState() => cartState.error(
          CartException(state.message),
          state.cart,
        ),
      InitialCartState() => getCart(),
    };
  }

  @override
  void dispose() {
    _bloc.dispose();
    cartState.dispose();
    _blocSubscription.cancel();
    super.dispose();
  }

  @override
  Future<void> addToFavorites({required ProductEntity product}) async =>
      await _bloc.addToFavorites(product: product);

  @override
  Future<void> deleteFromFavorites({required ProductEntity product}) async =>
      await _bloc.deleteFromFavorites(product: product);

  @override
  Future<void> getFavorites() async => await _bloc.getFavorites();

  @override
  final IFavoritesManager favoritesManager;
}

abstract interface class ICartModel extends ElementaryModel {
  void deleteFromCart({required ProductEntity product});
  void getCart();
  void addToCart({required ProductEntity product});

  Future<void> deleteFromFavorites({required ProductEntity product});
  Future<void> getFavorites();
  Future<void> addToFavorites({required ProductEntity product});

  EntityStateNotifier<CartEntity?> get cartState;
  EntityStateNotifier<List<ProductEntity>> get favoritesState;
}
