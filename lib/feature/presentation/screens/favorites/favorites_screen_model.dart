import 'dart:async';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:seo_web/core/exception/favorites_exception.dart';
import 'package:seo_web/feature/domain/entity/cart_entity.dart';
import 'package:seo_web/feature/domain/entity/products_entity.dart';
import 'package:seo_web/feature/presentation/bloc/favorites/favorites_bloc.dart';
import 'package:seo_web/feature/presentation/bloc/favorites/favorites_states.dart';

abstract interface class IFavoritesModel extends ElementaryModel {
  Future<void> deleteFromCart({required ProductEntity product});
  Future<void> getCart();
  Future<void> addToCart({required ProductEntity product});

  void deleteFromFavorites({required ProductEntity product});
  void getFavorites();
  void addToFavorites({required ProductEntity product});

  EntityStateNotifier<CartEntity?> get cartState;
  EntityStateNotifier<List<ProductEntity>> get favoritesState;
}

final class FavoritesModel extends ElementaryModel implements IFavoritesModel {
  final FavoritesBloc _bloc;

  FavoritesModel({required FavoritesBloc bloc}) : _bloc = bloc;

  @override
  Future<void> addToCart({required ProductEntity product}) async =>
      await _bloc.addToCart(product: product);

  @override
  void addToFavorites({required ProductEntity product}) =>
      _bloc.addToFavoritesEvent(product);

  @override
  EntityStateNotifier<CartEntity?> get cartState => _bloc.cartState;

  @override
  Future<void> deleteFromCart({required ProductEntity product}) async =>
      await _bloc.deleteFromCart(product: product);

  @override
  void deleteFromFavorites({required ProductEntity product}) =>
      _bloc.removeFromFavoritesEvent(product);

  @override
  Future<void> getCart() async => await _bloc.getCart();

  @override
  void getFavorites() => _bloc.loadFavoritesEvent();

  @override
  EntityStateNotifier<List<ProductEntity>> favoritesState =
      EntityStateNotifier();

  late final StreamSubscription _favoritesBlocSubscription;

  @override
  void init() {
    _favoritesBlocSubscription = _bloc.stream.listen(_parseStates);
    super.init();
  }

  @override
  void dispose() {
    _favoritesBlocSubscription.cancel();
    cartState.dispose();
    favoritesState.dispose();
    super.dispose();
  }

  void _parseStates(FavoritesState state) {
    return switch (state) {
      LoadingState() => favoritesState.loading(state.favorites),
      LoadedState() => favoritesState.content(state.favorites),
      ErrorState() => favoritesState.error(
          FavoritesException(state.message),
          state.favorites,
        ),
      InitialFavoritesState() => getCart()
    };
  }
}
