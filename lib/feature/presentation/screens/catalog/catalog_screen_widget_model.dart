import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seo_web/core/navigation/app_router.dart';
import 'package:seo_web/feature/domain/entity/cart_entity.dart';
import 'package:seo_web/feature/domain/entity/products_entity.dart';
import 'package:seo_web/feature/presentation/screens/catalog/catalog_screen_model.dart';
import 'package:seo_web/feature/presentation/screens/catalog/catalog_screen.dart';
import 'package:seo_web/generated/l10n.dart';

import 'dart:developer' as dev;

abstract interface class ICatalogWidgetModel
    extends WidgetModel<CatalogWidget, ICatalogModel> {
  ICatalogWidgetModel({required ICatalogModel model}) : super(model);
  Future<void> getCart();
  EntityStateNotifier<CartEntity?> get cartState;
  EntityStateNotifier<List<ProductEntity>> get productsState;
  Future<void> getAllProducts();

  Future<void> onCartTap(ProductEntity product);

  Future<void> onFavoriteTap(ProductEntity product);

  EntityStateNotifier<List<ProductEntity>> get favoritesState;

  S get locale;

  void goToCart();

  bool isInFavorites(ProductEntity product);
  bool isInCart(ProductEntity product);
}

CatalogWidgetModel catalogWMFactory(BuildContext context) =>
    CatalogWidgetModel(model: context.read<ICatalogModel>());

final class CatalogWidgetModel extends WidgetModel<CatalogWidget, ICatalogModel>
    implements ICatalogWidgetModel {
  CatalogWidgetModel({required ICatalogModel model}) : super(model);

  List<ProductEntity>? get _favorites => model.favoritesState.value.data;
  CartEntity? get _cart => model.cartState.value.data;

  @override
  EntityStateNotifier<List<ProductEntity>> get favoritesState =>
      model.favoritesState;
  @override
  EntityStateNotifier<CartEntity?> get cartState => model.cartState;

  @override
  Future<void> getAllProducts() async => await model.getAllProducts();

  @override
  Future<void> getCart() async => await model.getCart();

  @override
  EntityStateNotifier<List<ProductEntity>> get productsState =>
      model.productsState;

  StackRouter get _router => AutoRouter.of(context);

  @override
  void dispose() {
    productsState.dispose();
    favoritesState.dispose();
    cartState.dispose();
    super.dispose();
  }

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
      if (!isCartOffer) {
        await model.addToCart(product: product);
      } else {
        goToCart();
      }
    } catch (e) {
      dev.log(e.toString());
    }
  }

  @override
  Future<void> onFavoriteTap(ProductEntity product) {
    final isFavorite = isInFavorites(product);
    return isFavorite
        ? model.deleteFromFavorites(product: product)
        : model.addToFavorites(product: product);
  }

  @override
  void goToCart() async {
    await _router.navigate(const CartTab());
  }
}
