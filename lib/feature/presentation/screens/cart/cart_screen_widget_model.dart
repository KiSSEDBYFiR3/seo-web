import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:meta_seo/meta_seo.dart';
import 'package:provider/provider.dart';
import 'package:seo_web/core/di/dependencies.dart';
import 'package:seo_web/core/navigation/app_router.dart';
import 'package:seo_web/feature/data/model/cart/mapper/cart_mapper.dart';
import 'package:seo_web/feature/domain/entity/cart_entity.dart';
import 'package:seo_web/feature/domain/entity/products_entity.dart';
import 'package:seo_web/feature/presentation/screens/cart/cart_screen.dart';
import 'package:seo_web/feature/presentation/screens/cart/cart_screen_model.dart';
import 'package:seo_web/generated/l10n.dart';

abstract interface class ICartWidgetModel
    extends WidgetModel<CartWidget, ICartModel> {
  ICartWidgetModel(super.model);

  void deleteFromCart({required ProductEntity product});
  void getCart();
  void addToCart({required ProductEntity product});
  void orderCreate();

  Future<void> onFavoriteTap(ProductEntity product);
  Future<void> deleteFromFavorites({required ProductEntity product});
  Future<void> getFavorites();
  Future<void> addToFavorites({required ProductEntity product});

  void goToCatalog();

  S get locale;

  int get offersCount;

  EntityStateNotifier<CartEntity?> get cartState;
  EntityStateNotifier<List<ProductEntity>> get favoritesState;

  bool isInFavorites(ProductEntity product);

  Future<void> onProductTap(int id);

  MetaSEO? get meta;
}

WidgetModel cartWMFactory(BuildContext context) => CartWidgetModel(
      model: context.read<Dependencies>().cartModel,
    );

class CartWidgetModel extends WidgetModel<CartWidget, ICartModel>
    implements ICartWidgetModel {
  CartWidgetModel({required ICartModel model}) : super(model);

  List<ProductEntity>? get _favorites => model.favoritesState.value.data;

  StackRouter get _router => AutoRouter.of(context);

  CartEntity? get _cart => model.cartState.value.data;

  @override
  void addToCart({required ProductEntity product}) =>
      model.addToCart(product: product);

  @override
  EntityStateNotifier<CartEntity?> get cartState => model.cartState;

  @override
  bool isInFavorites(ProductEntity product) {
    return _favorites?.contains(product) ?? false;
  }

  @override
  Future<void> onProductTap(int id) async {
    model.onProductTap(id);
    await _router.push(
      ProductCardRoute(
        id: id,
      ),
    );
  }

  @override
  void deleteFromCart({required ProductEntity product}) =>
      model.deleteFromCart(product: product);

  @override
  void getCart() => model.getCart();

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

  @override
  S get locale => S.of(context);

  @override
  void goToCatalog() async {
    _router.navigate(const CatalogTab());
  }

  @override
  Future<void> onFavoriteTap(ProductEntity product) {
    final isFavorite = isInFavorites(product);
    return isFavorite
        ? model.deleteFromFavorites(product: product)
        : model.addToFavorites(product: product);
  }

  @override
  void orderCreate() async => model.createOrder();

  @override
  int get offersCount => calcOffersCount(_cart?.offers ?? []);

  @override
  MetaSEO? get meta => context.read<Dependencies>().meta;
}
