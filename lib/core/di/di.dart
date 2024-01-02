import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:seo_web/core/common/app/dependencies_provider.dart';
import 'package:seo_web/core/common/consts/consts.dart';
import 'package:seo_web/core/common/errors_bus/errors_bus.dart';
import 'package:seo_web/core/common/utils/configure_uuid.dart';
import 'package:seo_web/core/di/configure_dio.dart';
import 'package:seo_web/core/di/dependencies.dart';
import 'package:seo_web/core/interceptors/uuid_interceptor.dart';
import 'package:seo_web/core/navigation/app_router.dart';
import 'package:seo_web/feature/data/data_source/local_data_source/i_local_data_source.dart';
import 'package:seo_web/feature/data/data_source/local_data_source/local_data_source.dart';
import 'package:seo_web/feature/data/data_source/remote_data_source/auth/i_auth_data_source.dart';
import 'package:seo_web/feature/data/data_source/remote_data_source/auth/auth_data_source.dart';
import 'package:seo_web/feature/data/data_source/remote_data_source/cart/cart_data_source.dart';
import 'package:seo_web/feature/data/data_source/remote_data_source/cart/i_cart_data_source.dart';
import 'package:seo_web/feature/data/data_source/remote_data_source/favorites/favorites_data_source.dart';
import 'package:seo_web/feature/data/data_source/remote_data_source/favorites/i_favorites_data_source.dart';
import 'package:seo_web/feature/data/data_source/remote_data_source/order/i_order_data_source.dart';
import 'package:seo_web/feature/data/data_source/remote_data_source/order/order_data_source.dart';
import 'package:seo_web/feature/data/data_source/remote_data_source/products/i_products_data_source.dart';
import 'package:seo_web/feature/data/data_source/remote_data_source/products/products_data_source.dart';
import 'package:seo_web/feature/data/repository/cart/cart_repository.dart';
import 'package:seo_web/feature/data/repository/favorites/favorites_repository.dart';
import 'package:seo_web/feature/data/repository/local_repository.dart';
import 'package:seo_web/feature/data/repository/auth/auth_repository.dart';
import 'package:seo_web/feature/data/repository/order/order_repository.dart';
import 'package:seo_web/feature/data/repository/products/products_repository.dart';
import 'package:seo_web/feature/data/services/auth/auth_service.dart';
import 'package:seo_web/feature/data/services/cart/cart_service.dart';
import 'package:seo_web/feature/data/services/favorites/favorites_service.dart';
import 'package:seo_web/feature/data/services/order/order_service.dart';
import 'package:seo_web/feature/data/services/products/products_service.dart';
import 'package:seo_web/feature/domain/managers/cart/cart_manager.dart';
import 'package:seo_web/feature/domain/managers/cart/i_cart_manager.dart';
import 'package:seo_web/feature/domain/managers/favorites/favorites_manager.dart';
import 'package:seo_web/feature/domain/managers/favorites/i_favorites_manager.dart';
import 'package:seo_web/feature/domain/managers/products/i_products_manager.dart';
import 'package:seo_web/feature/domain/managers/products/products_manager.dart';
import 'package:seo_web/feature/domain/repository/cart/i_cart_repository.dart';
import 'package:seo_web/feature/domain/repository/favorites/i_favorites_repository.dart';
import 'package:seo_web/feature/domain/repository/i_local_repository.dart';
import 'package:seo_web/feature/domain/repository/auth/i_auth_repository.dart';
import 'package:seo_web/feature/domain/repository/order/i_order_repository.dart';
import 'package:seo_web/feature/domain/repository/products/i_products_repository.dart';
import 'package:seo_web/feature/presentation/bloc/cart/cart_bloc.dart';
import 'package:seo_web/feature/presentation/bloc/favorites/favorites_bloc.dart';
import 'package:seo_web/feature/presentation/screens/cart/cart_screen_model.dart';
import 'package:seo_web/feature/presentation/screens/catalog/categories/categories_screen_model.dart';
import 'package:seo_web/feature/presentation/screens/catalog/product_card/product_card_screen_model.dart';
import 'package:seo_web/feature/presentation/screens/catalog/products/products_screen_model.dart';
import 'package:seo_web/feature/presentation/screens/favorites/favorites_screen_model.dart';
import 'package:seo_web/feature/presentation/screens/home/home_screen_model.dart';
import 'package:seo_web/main.dart';

final IDiContainer diContainer = DiContainer();

abstract class IDiContainer {
  Future<Widget> configureDependencies();
}

class DiContainer implements IDiContainer {
  late final Dio _dio;
  DiContainer();

  @override
  Future<Widget> configureDependencies() async {
    final localRepository = _createLocalRepository();

    final uuid = await configureUuid(localRepository);
    final uuidInterceptor = UUIDInterceptor(uuid);

    _dio = await configureDio(
      [uuidInterceptor],
      _createAuthRepository,
      localRepository,
    );
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
          appRouter: _appRouter,
        ),
      );

  IAuthRepository _createAuthRepository(Dio dio) => AuthRepository(
        _createAuthDataSource(dio),
      );

  late final AppRouter _appRouter = AppRouter();

  ILocalAuthRepository _createLocalRepository() =>
      LocalRepository(_createLocalDataSource());

  late final IErrorsBus _errorsBus = ErrorsBus();

  late final ICartManager _cartManager = CartManager(
    cartRepository: _buildCartRepository(),
    orderRepository: _buildOrderRepository(),
    errorsBus: _errorsBus,
  )..init();

  late final IProductsManager _productsManager = ProductsManager(
    productsRepository: _createProductsRepository(),
    errorsBus: _errorsBus,
    allProductsCategoryName: Consts.allProductsCategoryName,
  );

  late final IFavoritesManager _favoritesManager = FavoritesManager(
    favoritesRepository: _createFavoritesRepository(),
    errorsBus: _errorsBus,
  );

  late final CartBloc _cartBloc = CartBloc(
    cartManager: _cartManager,
    favoritesManager: _favoritesManager,
  );

  late final FavoritesBloc _favoritesBloc = FavoritesBloc(
    cartManager: _cartManager,
    favoritesManager: _favoritesManager,
  );

  IProductsModel _catalogModel() => ProductsModel(
        cartManager: _cartManager,
        favoritesManager: _favoritesManager,
        productsManager: _productsManager,
      );

  IProductModel _productModel() => ProductModel(
        productsManager: _productsManager,
        cartManager: _cartManager,
        favoritesManager: _favoritesManager,
      );

  late final IHomeModel _homeModel = HomeModel(errorsBus: _errorsBus);

  late final ICategoriesModel _categoriesModel = CategoriesModel(
    productsManager: _productsManager,
  );

  late final IFavoritesModel _favoritesModel = FavoritesModel(
    productsManager: _productsManager,
    bloc: _favoritesBloc,
  );

  late final ICartModel _cartModel = CartModel(
    productsManager: _productsManager,
    bloc: _cartBloc,
    favoritesManager: _favoritesManager,
  );

  IFavoritesRepository _createFavoritesRepository() =>
      FavoritesRepository(dataSource: _createFavoritesDataSource());

  IFavoritesDataSource _createFavoritesDataSource() =>
      FavoritesDataSource(favoritesService: FavoritesService(_dio));

  IProductsRepository _createProductsRepository() =>
      ProductsRepository(dataSource: _createProductsDataSource());

  IProductDataSource _createProductsDataSource() => ProductsDataSource(
        productsService: ProductsService(
          _dio,
        ),
      );

  IOrderRepository _buildOrderRepository() =>
      OrderRepository(dataSource: _buildOrderDataSource());

  IOrderDataSource _buildOrderDataSource() =>
      OrderDataSource(orderService: OrderService(_dio));

  ICartRepository _buildCartRepository() =>
      CartRepository(dataSource: _buildCartDataSource());

  ICartDataSource _buildCartDataSource() => CartDataSource(
        cartService: CartService(_dio),
      );

  ILocalAuthDataSource _createLocalDataSource() => LocalAuthDataSource(
        secureStorage: _secureStorage,
      );

  IAuthDataSource _createAuthDataSource(Dio dio) => AuthDataSource(
        authService: AuthService(dio),
        localRepository: _createLocalRepository(),
      );
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );
}
