import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seo_web/feature/domain/entity/cart_entity.dart';
import 'package:seo_web/feature/domain/entity/products_entity.dart';
import 'package:seo_web/feature/presentation/screens/cart/cart_screen.dart';
import 'package:seo_web/feature/presentation/screens/cart/cart_screen_model.dart';

abstract interface class ICartWidgetModel
    extends WidgetModel<CartScreen, ICartModel> {
  ICartWidgetModel(super.model);

  void deleteFromCart({required ProductEntity product});
  void getCart();
  void addToCart({required ProductEntity product});

  Future<void> deleteFromFavorites({required ProductEntity product});
  Future<void> getFavorites();
  Future<void> addToFavorites({required ProductEntity product});

  EntityStateNotifier<CartEntity?> get cartState;
  EntityStateNotifier<List<ProductEntity>> get favoritesState;
}

WidgetModel cartWMFactory(BuildContext context) => CartWidgetModel(
      model: context.read<ICartModel>(),
    );

class CartWidgetModel extends WidgetModel<CartScreen, ICartModel>
    implements ICartWidgetModel {
  CartWidgetModel({required ICartModel model}) : super(model);

  @override
  void addToCart({required ProductEntity product}) =>
      model.addToCart(product: product);
  @override
  EntityStateNotifier<CartEntity?> get cartState => model.cartState;

  @override
  void deleteFromCart({required ProductEntity product}) =>
      model.deleteFromCart(product: product);

  @override
  void getCart() => model.getCart();

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    model.init();
  }

  @override
  void dispose() {
    model.dispose();
    super.dispose();
  }

  void showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        backgroundColor: Theme.of(context).colorScheme.error,
        content: SizedBox(
          child: Center(
            child: Text(
              message,
              style: TextStyle(
                fontFamily: "Lexend",
                fontWeight: FontWeight.w500,
                fontSize: 17,
                color: Theme.of(context).colorScheme.onError,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Future<void> addToFavorites({required ProductEntity product}) async =>
      await model.addToFavorites(product: product);

  @override
  Future<void> deleteFromFavorites({required ProductEntity product}) async =>
      await model.deleteFromFavorites(product: product);

  @override
  EntityStateNotifier<List<ProductEntity>> get favoritesState =>
      model.favoritesState;

  @override
  Future<void> getFavorites() async => await model.getFavorites();
}