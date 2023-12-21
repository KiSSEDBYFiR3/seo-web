import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seo_web/feature/domain/entity/cart_entity.dart';
import 'package:seo_web/feature/domain/entity/products_entity.dart';
import 'package:seo_web/feature/presentation/screens/catalog/catalog_screen_model.dart';
import 'package:seo_web/feature/presentation/screens/catalog/catalog_screen.dart';

abstract interface class ICatalogWidgetModel
    extends WidgetModel<CatalogScreen, ICatalogModel> {
  ICatalogWidgetModel({required ICatalogModel model}) : super(model);
  Future<void> deleteFromCart({required ProductEntity product});
  Future<void> getCart();
  Future<void> addToCart({required ProductEntity product});
  EntityStateNotifier<CartEntity?> get cartState;
  EntityStateNotifier<List<ProductEntity>> get productsState;
  Future<void> getAllProducts();
}

CatalogWidgetModel catalogWMFactory(BuildContext context) =>
    CatalogWidgetModel(model: context.read<ICatalogModel>());

final class CatalogWidgetModel extends WidgetModel<CatalogScreen, ICatalogModel>
    implements ICatalogWidgetModel {
  CatalogWidgetModel({required ICatalogModel model}) : super(model);

  @override
  Future<void> addToCart({required ProductEntity product}) async =>
      await model.addToCart(product: product);
  @override
  EntityStateNotifier<CartEntity?> get cartState => model.cartState;

  @override
  Future<void> deleteFromCart({required ProductEntity product}) async =>
      await model.deleteFromCart(product: product);

  @override
  Future<void> getAllProducts() async => await model.getAllProducts();
  @override
  Future<void> getCart() async => await model.getCart();

  @override
  EntityStateNotifier<List<ProductEntity>> get productsState =>
      model.productsState;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    model.init();
  }

  @override
  void dispose() {
    productsState.dispose();
    cartState.dispose();
    model.dispose();
    super.dispose();
  }
}
