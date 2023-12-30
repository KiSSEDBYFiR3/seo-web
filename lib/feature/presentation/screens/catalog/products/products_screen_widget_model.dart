import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:seo_web/core/common/consts/consts.dart';
import 'package:seo_web/core/di/dependencies.dart';
import 'package:seo_web/core/navigation/app_router.dart';
import 'package:seo_web/feature/domain/entity/cart_entity.dart';
import 'package:seo_web/feature/domain/entity/products_entity.dart';
import 'package:seo_web/feature/presentation/screens/catalog/products/products_screen_model.dart';
import 'package:seo_web/feature/presentation/screens/catalog/products/products_screen.dart';
import 'package:seo_web/generated/l10n.dart';

import 'dart:developer' as dev;

abstract interface class IProductsWidgetModel
    extends WidgetModel<ProductsWidget, IProductsModel> {
  String? get category;

  IProductsWidgetModel({required IProductsModel model}) : super(model);
  Future<void> getCart();
  EntityStateNotifier<CartEntity?> get cartState;
  EntityStateNotifier<List<ProductEntity>> get productsState;
  Future<void> getAllProducts();

  Future<void> onCartTap(ProductEntity product);

  Future<void> onFavoriteTap(ProductEntity product);

  EntityStateNotifier<List<ProductEntity>> get favoritesState;

  S get locale;

  void goToCart();

  void goBack();

  BehaviorSubject<String> get selectedCategoryName;

  bool isInFavorites(ProductEntity product);
  bool isInCart(ProductEntity product);

  Future<void> onProductTap(int id);

  void unfocus();

  TextEditingController get searchController;
}

IProductsWidgetModel catalogWMFactory(
  BuildContext context, {
  String? category,
}) =>
    ProductsWidgetModel(
      model: context.read<Dependencies>().catalogModel,
      category: category,
    );

final class ProductsWidgetModel
    extends WidgetModel<ProductsWidget, IProductsModel>
    implements IProductsWidgetModel {
  ProductsWidgetModel({
    required IProductsModel model,
    required this.category,
  }) : super(model);

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
  EntityStateNotifier<List<ProductEntity>> get productsState => _productsState;

  final EntityStateNotifier<List<ProductEntity>> _productsState =
      EntityStateNotifier();

  StackRouter get _router => AutoRouter.of(context);

  @override
  void unfocus() {
    FocusScope.of(context).unfocus();
  }

  @override
  void initWidgetModel() async {
    super.initWidgetModel();
    _addState();
    if (kIsWeb) {
      await Future.microtask(_ensurePageHasData);
    }
    model.productsState.addListener(_productsStateListner);
    searchController.addListener(_searchListner);
  }

  Future<void> _ensurePageHasData() async {
    final currentRoute = _router.currentChild?.route.fullPath;
    if (currentRoute == 'products' && _productsState.value.data == null) {
      final uri = Uri.parse(_router.currentUrl);
      final params = uri.queryParameters['category'];

      await model.selectCategoryOnUpdate(
        category: params ?? Consts.allProductsCategoryName,
      );
      _addState();
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    model.productsState.removeListener(_productsStateListner);
    searchController.removeListener(_searchListner);

    super.dispose();
  }

  void _addState() {
    final modelProducts = model.productsState.value.data;

    if (_productsState.value.data == null &&
        modelProducts?.isNotEmpty == true) {
      _productsState.content(modelProducts ?? []);
    }
  }

  void _productsStateListner() {
    _productsState.content(model.productsState.value.data ?? []);
  }

  void _searchListner() {
    final text = searchController.text;

    final products = model.productsState.value.data ?? [];

    if (text.isEmpty) {
      _productsState.content(products);
      return;
    }
    _productsState.loading(products);

    final foundProducts = products
        .where(
          (element) =>
              element.title.toLowerCase().contains(text) ||
              element.description.toLowerCase().contains(text),
        )
        .toList();
    _productsState.content(foundProducts);
  }

  @override
  bool isInFavorites(ProductEntity product) {
    return _favorites?.contains(product) ?? false;
  }

  @override
  S get locale => S.of(context);

  @override
  bool isInCart(ProductEntity product) {
    return _cart?.offers.any((element) => element.id == product.id) ?? false;
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

  @override
  BehaviorSubject<String> get selectedCategoryName =>
      model.selectedCategoryName;

  @override
  void goBack() => _router.pop();

  @override
  final TextEditingController searchController = TextEditingController();

  @override
  final String? category;

  @override
  Future<void> onProductTap(int id) async {
    model.onProductTap(id);
    await _router.push(ProductCardRoute(
      id: id,
    ));
  }
}
