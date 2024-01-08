import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meta_seo/meta_seo.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:seo_web/core/di/dependencies.dart';
import 'package:seo_web/core/navigation/app_router.dart';
import 'package:seo_web/feature/domain/entity/cart_entity.dart';
import 'package:seo_web/feature/domain/entity/products_entity.dart';
import 'package:seo_web/feature/presentation/screens/catalog/product_card/product_card_screen.dart';
import 'package:seo_web/feature/presentation/screens/catalog/product_card/product_card_screen_model.dart';
import 'package:seo_web/generated/l10n.dart';

abstract interface class IProductWidgetModel
    extends WidgetModel<ProductCardWidget, IProductModel> {
  IProductWidgetModel({required IProductModel model}) : super(model);
  BehaviorSubject<ProductEntity> get selectedProductController;

  S get locale;

  void goBack();

  EntityStateNotifier<List<ProductEntity>> get favoritesState;
  EntityStateNotifier<CartEntity?> get cartState;

  Future<void> addToCart({required ProductEntity product});

  Future<void> onFavoritesTap({required ProductEntity product});

  bool isInFavorites(ProductEntity product);
  bool isInCart(ProductEntity product);

  MetaSEO get meta;
}

IProductWidgetModel productWMFactory(BuildContext context, int id) =>
    ProductWidgetModel(
      model: context.read<Dependencies>().productModel,
      id: id,
    );

final class ProductWidgetModel
    extends WidgetModel<ProductCardWidget, IProductModel>
    implements IProductWidgetModel {
  final int id;
  final IProductModel _model;
  ProductWidgetModel({
    required IProductModel model,
    required this.id,
  })  : _model = model,
        super(model);

  StackRouter get _router => AutoRouter.of(context);

  List<ProductEntity>? get _favorites => favoritesState.value.data;
  CartEntity? get _cart => cartState.value.data;

  @override
  BehaviorSubject<ProductEntity> get selectedProductController =>
      _model.selectedProductController;

  @override
  S get locale => S.of(context);

  @override
  void goBack() => _router.back();

  @override
  void initWidgetModel() async {
    if (kIsWeb) {
      updateState();
    }
    super.initWidgetModel();
  }

  Future<void> updateState() async {
    final productEmpty = selectedProductController.valueOrNull == null;
    if (productEmpty) {
      await model.getAllProducts();
      model.findProductById(id);
    }
  }

  @override
  EntityStateNotifier<CartEntity?> get cartState => _model.cartState;

  @override
  EntityStateNotifier<List<ProductEntity>> get favoritesState =>
      _model.favoritesState;

  @override
  Future<void> addToCart({required ProductEntity product}) async {
    if (isInCart(product)) {
      await _router.navigate(const CartTab());
      return;
    }
    await _model.addToCart(product: product);
  }

  @override
  Future<void> onFavoritesTap({required ProductEntity product}) async {
    final isFavorite = isInFavorites(product);
    return isFavorite
        ? model.deleteFromFavorites(product: product)
        : model.addToFavorites(product: product);
  }

  @override
  bool isInFavorites(ProductEntity product) {
    return _favorites?.contains(product) ?? false;
  }

  @override
  bool isInCart(ProductEntity product) {
    return _cart?.offers.any((element) => element.id == product.id) ?? false;
  }

  @override
  MetaSEO get meta => context.read<Dependencies>().meta;
}
