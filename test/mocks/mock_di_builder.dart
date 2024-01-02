import 'package:flutter/src/widgets/framework.dart';
import 'package:seo_web/core/common/app/dependencies_provider.dart';
import 'package:seo_web/core/common/errors_bus/errors_bus.dart';
import 'package:seo_web/core/di/dependencies.dart';
import 'package:seo_web/core/di/di.dart';
import 'package:seo_web/core/navigation/app_router.dart';
import 'package:seo_web/feature/data/data_source/remote_data_source/cart/cart_data_source.dart';
import 'package:seo_web/feature/data/data_source/remote_data_source/favorites/favorites_data_source.dart';
import 'package:seo_web/feature/data/data_source/remote_data_source/order/order_data_source.dart';
import 'package:seo_web/feature/data/data_source/remote_data_source/products/products_data_source.dart';
import 'package:seo_web/feature/data/repository/cart/cart_repository.dart';
import 'package:seo_web/feature/data/repository/favorites/favorites_repository.dart';
import 'package:seo_web/feature/data/repository/order/order_repository.dart';
import 'package:seo_web/feature/data/repository/products/products_repository.dart';
import 'package:seo_web/feature/data/services/cart/cart_service.dart';
import 'package:seo_web/feature/data/services/favorites/favorites_service.dart';
import 'package:seo_web/feature/data/services/order/order_service.dart';
import 'package:seo_web/feature/data/services/products/products_service.dart';
import 'package:seo_web/feature/domain/managers/cart/i_cart_manager.dart';
import 'package:seo_web/feature/domain/managers/favorites/i_favorites_manager.dart';
import 'package:seo_web/feature/domain/managers/products/i_products_manager.dart';
import 'package:seo_web/feature/presentation/bloc/cart/cart_bloc.dart';
import 'package:seo_web/feature/presentation/bloc/favorites/favorites_bloc.dart';
import 'package:seo_web/feature/presentation/screens/cart/cart_screen_model.dart';
import 'package:seo_web/feature/presentation/screens/catalog/categories/categories_screen_model.dart';
import 'package:seo_web/feature/presentation/screens/catalog/product_card/product_card_screen_model.dart';
import 'package:seo_web/feature/presentation/screens/catalog/products/products_screen_model.dart';
import 'package:seo_web/feature/presentation/screens/favorites/favorites_screen_model.dart';
import 'package:seo_web/feature/presentation/screens/home/home_screen_model.dart';
import 'package:seo_web/main.dart';

class MockDiContainer implements IDiContainer {
  MockDiContainer({
    required this.orderMock,
    required this.productsMock,
    required this.cartMock,
    required this.favoritesMock,
    required this.orderDataSource,
    required this.favoritesDataSource,
    required this.cartDataSource,
    required this.productsDataSource,
    required this.orderRepository,
    required this.favoritesRepository,
    required this.cartRepository,
    required this.productsRepository,
    required this.cartManager,
    required this.favoritesManager,
    required this.productsManager,
  });

  final OrderService orderMock;
  final ProductsService productsMock;
  final CartService cartMock;
  final FavoritesService favoritesMock;

  final OrderDataSource orderDataSource;
  final FavoritesDataSource favoritesDataSource;
  final CartDataSource cartDataSource;
  final ProductsDataSource productsDataSource;

  final OrderRepository orderRepository;
  final FavoritesRepository favoritesRepository;
  final CartRepository cartRepository;
  final ProductsRepository productsRepository;

  final ICartManager cartManager;
  final IFavoritesManager favoritesManager;
  final IProductsManager productsManager;

  @override
  Future<Widget> configureDependencies() async {
    return _createApp();
  }

  Widget _createApp() => DependenciesProvider(
        dependencies: Dependencies(
          homeModel: _homeModel,
          cartModel: _cartModel,
          catalogModel: _catalogModel(),
          favoritesModel: _favoritesModel,
          categoriesModel: _categoriesModel,
          productModel: _productModel(),
        ),
        child: App(
          appRouter: _createAppRouter,
        ),
      );

  late final AppRouter _createAppRouter = AppRouter();

  late final IErrorsBus _errorsBus = ErrorsBus();

  late final CartBloc _cartBloc = CartBloc(
    cartManager: cartManager,
    favoritesManager: favoritesManager,
  );

  late final FavoritesBloc _favoritesBloc = FavoritesBloc(
    cartManager: cartManager,
    favoritesManager: favoritesManager,
  );

  IProductsModel _catalogModel() => ProductsModel(
        cartManager: cartManager,
        favoritesManager: favoritesManager,
        productsManager: productsManager,
      );

  IProductModel _productModel() => ProductModel(
        productsManager: productsManager,
        cartManager: cartManager,
        favoritesManager: favoritesManager,
      );

  late final IHomeModel _homeModel = HomeModel(errorsBus: _errorsBus);

  late final ICategoriesModel _categoriesModel = CategoriesModel(
    productsManager: productsManager,
  );

  late final IFavoritesModel _favoritesModel = FavoritesModel(
    productsManager: productsManager,
    bloc: _favoritesBloc,
  );

  late final ICartModel _cartModel = CartModel(
    productsManager: productsManager,
    bloc: _cartBloc,
    favoritesManager: favoritesManager,
  );
}
