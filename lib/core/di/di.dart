import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
import 'package:seo_web/main.dart';

final IDiContainer diContainer = DiContainer();

abstract class IDiContainer {
  MyApp createMyApp();
  IAuthRepository createAuthRepository();
}

class DiContainer implements IDiContainer {
  @override
  MyApp createMyApp() => MyApp(
        appRouter: _createAppRouter(),
      );
  @override
  IAuthRepository createAuthRepository() => AuthRepository(
        _createAuthDataSource(),
      );

  AppRouter _createAppRouter() => AppRouter();

  ILocalAuthRepository _createLocalRepository() =>
      LocalRepository(_createLocalDataSource());

  late final ICartManager _cartManager = CartManager(
    cartRepository: _buildCartRepository(),
    orderRepository: _buildOrderRepository(),
  );

  late final IProductsManager _productsManager =
      ProductsManager(productsRepository: _createProductsRepository());

  late final IFavoritesManager _favoritesManager =
      FavoritesManager(favoritesRepository: _createFavoritesRepository());

  IFavoritesRepository _createFavoritesRepository() =>
      FavoritesRepository(dataSource: _createFavoritesDataSource());

  IFavoritesDataSource _createFavoritesDataSource() =>
      FavoritesDataSource(favoritesService: FavoritesService(_dio()));

  IProductsRepository _createProductsRepository() =>
      ProductsRepository(dataSource: _createProductsDataSource());

  IProductDataSource _createProductsDataSource() => ProductsDataSource(
        productsService: ProductsService(
          _dio(),
        ),
      );

  IOrderRepository _buildOrderRepository() =>
      OrderRepository(dataSource: _buildOrderDataSource());

  IOrderDataSource _buildOrderDataSource() =>
      OrderDataSource(orderService: OrderService(_dio()));

  ICartRepository _buildCartRepository() =>
      CartRepository(dataSource: _buildCartDataSource());

  ICartDataSource _buildCartDataSource() => CartDataSource(
        cartService: CartService(_dio()),
      );

  ILocalAuthDataSource _createLocalDataSource() => LocalAuthDataSource(
        secureStorage: _secureStorage,
      );

  IAuthDataSource _createAuthDataSource() => AuthDataSource(
        authService: AuthService(_dio()),
        localRepository: _createLocalRepository(),
      );

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  Dio _dio() => Dio();
}
