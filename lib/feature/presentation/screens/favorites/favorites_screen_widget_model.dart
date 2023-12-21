import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seo_web/feature/domain/entity/cart_entity.dart';
import 'package:seo_web/feature/domain/entity/products_entity.dart';
import 'package:seo_web/feature/presentation/screens/favorites/favorites_screen.dart';
import 'package:seo_web/feature/presentation/screens/favorites/favorites_screen_model.dart';

abstract interface class IFavoritesWidgetModel
    extends WidgetModel<FavoritesScreen, IFavoritesModel> {
  IFavoritesWidgetModel({required IFavoritesModel model}) : super(model);

  Future<void> deleteFromCart({required ProductEntity product});
  Future<void> getCart();
  Future<void> addToCart({required ProductEntity product});

  void deleteFromFavorites({required ProductEntity product});
  void getFavorites();
  void addToFavorites({required ProductEntity product});

  EntityStateNotifier<CartEntity?> get cartState;
  EntityStateNotifier<List<ProductEntity>> get favoritesState;
}

FavoritesWidgetModel favoritesWMFactory(BuildContext context) =>
    FavoritesWidgetModel(
      model: context.read<IFavoritesModel>(),
    );

final class FavoritesWidgetModel
    extends WidgetModel<FavoritesScreen, IFavoritesModel>
    implements IFavoritesWidgetModel {
  FavoritesWidgetModel({required IFavoritesModel model}) : super(model);

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
  Future<void> getCart() async => await model.getCart();

  @override
  void getFavorites() => model.getFavorites();
}
