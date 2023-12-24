import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seo_web/feature/domain/entity/cart_entity.dart';
import 'package:seo_web/feature/domain/entity/products_entity.dart';
import 'package:seo_web/feature/presentation/screens/favorites/favorites_screen.dart';
import 'package:seo_web/feature/presentation/screens/favorites/favorites_screen_model.dart';
import 'package:seo_web/generated/l10n.dart';

import 'dart:developer' as dev;

abstract interface class IFavoritesWidgetModel
    extends WidgetModel<FavoritesWidget, IFavoritesModel> {
  IFavoritesWidgetModel({required IFavoritesModel model}) : super(model);

  Future<void> deleteFromCart({required ProductEntity product});
  Future<void> getCart();
  Future<void> addToCart({required ProductEntity product});

  void deleteFromFavorites({required ProductEntity product});
  void getFavorites();
  void addToFavorites({required ProductEntity product});

  S get locale;

  bool isInFavorites(ProductEntity product);
  bool isInCart(ProductEntity product);

  Future<void> onCartTap(ProductEntity product);

  void onFavoriteTap(ProductEntity product);

  EntityStateNotifier<CartEntity?> get cartState;
  EntityStateNotifier<List<ProductEntity>> get favoritesState;
}

FavoritesWidgetModel favoritesWMFactory(BuildContext context) =>
    FavoritesWidgetModel(
      model: context.read<IFavoritesModel>(),
    );

final class FavoritesWidgetModel
    extends WidgetModel<FavoritesWidget, IFavoritesModel>
    implements IFavoritesWidgetModel {
  FavoritesWidgetModel({required IFavoritesModel model}) : super(model);

  List<ProductEntity>? get _favorites => model.favoritesState.value.data;
  CartEntity? get _cart => model.cartState.value.data;

  @override
  Future<void> addToCart({required ProductEntity product}) async =>
      await model.addToCart(product: product);

  @override
  void addToFavorites({required ProductEntity product}) async =>
      model.addToFavorites(product: product);

  @override
  EntityStateNotifier<CartEntity?> get cartState => model.cartState;

  @override
  Future<void> deleteFromCart({required ProductEntity product}) async =>
      await model.deleteFromCart(product: product);

  @override
  void deleteFromFavorites({required ProductEntity product}) =>
      model.deleteFromFavorites(product: product);

  @override
  EntityStateNotifier<List<ProductEntity>> get favoritesState =>
      model.favoritesState;

  @override
  void dispose() {
    favoritesState.dispose();
    cartState.dispose();
    super.dispose();
  }

  @override
  Future<void> getCart() async => await model.getCart();

  @override
  void getFavorites() => model.getFavorites();

  @override
  bool isInFavorites(ProductEntity product) {
    return _favorites?.contains(product) ?? false;
  }

  @override
  S get locale => S.of(context);

  @override
  bool isInCart(ProductEntity product) {
    return _cart?.products.contains(product) ?? false;
  }

  @override
  Future<void> onCartTap(ProductEntity product) async {
    final isCartOffer = isInCart(product);

    try {
      if (isCartOffer) {
        await model.deleteFromCart(product: product);
      } else {
        await model.addToCart(product: product);
      }
    } catch (e) {
      dev.log(e.toString());
    }
  }

  @override
  void onFavoriteTap(ProductEntity product) {
    final isFavorite = isInFavorites(product);
    return isFavorite
        ? model.deleteFromFavorites(product: product)
        : model.addToFavorites(product: product);
  }
}
