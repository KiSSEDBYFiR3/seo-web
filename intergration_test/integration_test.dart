import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:seo_web/feature/data/data_source/remote_data_source/auth/auth_data_source.dart';
import 'package:seo_web/feature/data/data_source/remote_data_source/cart/cart_data_source.dart';
import 'package:seo_web/feature/data/data_source/remote_data_source/favorites/favorites_data_source.dart';
import 'package:seo_web/feature/data/data_source/remote_data_source/order/order_data_source.dart';
import 'package:seo_web/feature/data/data_source/remote_data_source/products/products_data_source.dart';
import 'package:seo_web/feature/data/model/auth/auth_response_dto.dart';
import 'package:seo_web/feature/data/model/auth/free_token_response_dto.dart';
import 'package:seo_web/feature/data/model/cart/cart_dto.dart';
import 'package:seo_web/feature/data/model/cart/mapper/cart_mapper.dart';
import 'package:seo_web/feature/data/model/product/mapper/mapper.dart';
import 'package:seo_web/feature/data/model/product/product_dto.dart';
import 'package:seo_web/feature/data/repository/auth/auth_repository.dart';
import 'package:seo_web/feature/data/repository/cart/cart_repository.dart';
import 'package:seo_web/feature/data/repository/favorites/favorites_repository.dart';
import 'package:seo_web/feature/data/repository/order/order_repository.dart';
import 'package:seo_web/feature/data/repository/products/products_repository.dart';
import 'package:seo_web/feature/data/services/auth/auth_service.dart';
import 'package:seo_web/feature/data/services/cart/cart_service.dart';
import 'package:seo_web/feature/data/services/favorites/favorites_service.dart';
import 'package:seo_web/feature/data/services/order/order_service.dart';
import 'package:seo_web/feature/data/services/products/products_service.dart';
import 'package:seo_web/feature/domain/managers/cart/i_cart_manager.dart';
import 'package:seo_web/feature/domain/managers/favorites/i_favorites_manager.dart';
import 'package:seo_web/feature/domain/managers/products/i_products_manager.dart';
import 'package:seo_web/main.dart';

import '../test/mocks/data.dart';
import '../test/mocks/data_sources.mocks.dart';
import '../test/mocks/managers_mocks.dart';
import '../test/mocks/mock_di_builder.dart';
import '../test/mocks/repositories.mocks.dart';
import '../test/mocks/services.mocks.dart';

void main() {
  late AuthService authMock;
  late OrderService orderMock;
  late ProductsService productsMock;
  late CartService cartMock;
  late FavoritesService favoritesMock;

  late AuthDataSource authDataSource;
  late OrderDataSource orderDataSource;
  late FavoritesDataSource favoritesDataSource;
  late CartDataSource cartDataSource;
  late ProductsDataSource productsDataSource;

  late AuthRepository authRepository;
  late OrderRepository orderRepository;
  late FavoritesRepository favoritesRepository;
  late CartRepository cartRepository;
  late ProductsRepository productsRepository;

  late ICartManager cartManager;
  late IFavoritesManager favoritesManager;
  late IProductsManager productsManager;
  late Widget app;

  setUpAll(() async {
    /// Services init
    authMock = MockAuthService();
    orderMock = MockOrderService();
    productsMock = MockProductsService();
    cartMock = MockCartService();
    favoritesMock = MockFavoritesService();

    /// Data Sources init
    authDataSource = MockAuthDataSource();
    orderDataSource = MockOrderDataSource();
    favoritesDataSource = MockFavoritesDataSource();
    cartDataSource = MockCartDataSource();
    productsDataSource = MockProductsDataSource();

    /// Repositories init
    authRepository = MockAuthRepository();
    orderRepository = MockOrderRepository();
    favoritesRepository = MockFavoritesRepository();
    cartRepository = MockCartRepository();
    productsRepository = MockProductsRepository();

    /// Managers init
    cartManager = MockCartManager(
      repository: cartRepository,
      orderRepository: orderRepository,
    );

    favoritesManager = MockFavoritesManager(repository: favoritesRepository);

    productsManager = MockProductsManager(repository: productsRepository);

    /// Services stubs
    when(authMock.authorize()).thenAnswer((_) => Future(
          () => const AuthResponseDto(
              accessToken: 'accessToken', refreshToken: 'refreshToken'),
        ));
    when(authMock.refresh()).thenAnswer(
      (_) async => const FreeTokenResponseDto(
          accessToken: 'accessToken', refreshToken: 'refreshToken'),
    );

    when(cartMock.getCart()).thenAnswer(
      (_) async => CartDto.fromJson(cartStub),
    );

    when(cartMock.addToCart(id: 1)).thenAnswer(
      (_) => Future(() => CartDto.fromJson(cartAddStub)),
    );

    when(cartMock.deleteFromCart(id: 1)).thenAnswer(
      (_) => Future(() => CartDto.fromJson(cartStub)),
    );

    when(favoritesMock.getFavorites()).thenAnswer(
      (_) async => productStub.map(ProductDto.fromJson).toList(),
    );

    when(favoritesMock.addToFavorites(id: 1)).thenAnswer(
      (_) => Future(
        () => productAddedStub.map(ProductDto.fromJson).toList(),
      ),
    );

    when(favoritesMock.deleteFromFavorites(id: 1)).thenAnswer(
      (_) => Future(
        () => productStub.map(ProductDto.fromJson).toList(),
      ),
    );

    when(productsMock.getAllProducts()).thenAnswer(
      (_) async => productStub.map(ProductDto.fromJson).toList(),
    );

    when(orderMock.createOrder()).thenAnswer(
      (_) async => 'success',
    );

    /// Data Sources stubs
    when(authDataSource.authorize()).thenAnswer((realInvocation) async {
      final dto = await authMock.authorize();
      return (dto.accessToken, dto.refreshToken);
    });

    when(authDataSource.updateToken()).thenAnswer((realInvocation) async {
      final dto = await authMock.refresh();
      return (dto.accessToken, dto.refreshToken);
    });

    when(orderDataSource.createOrder())
        .thenAnswer((realInvocation) async => await orderMock.createOrder());

    when(productsDataSource.getAllProducts()).thenAnswer(
        (realInvocation) async => await productsMock.getAllProducts());

    when(cartDataSource.getCart())
        .thenAnswer((realInvocation) async => cartMock.getCart());

    when(cartDataSource.addToCart(id: 1))
        .thenAnswer((realInvocation) async => await cartMock.addToCart(id: 1));

    when(cartDataSource.deleteFromCart(id: 1)).thenAnswer(
        (realInvocation) async => await cartMock.deleteFromCart(id: 1));

    when(favoritesDataSource.getFavorites()).thenAnswer(
        (realInvocation) async => await favoritesMock.getFavorites());

    when(favoritesDataSource.addToFavorites(id: 1)).thenAnswer(
        (realInvocation) async => await favoritesMock.addToFavorites(id: 1));

    when(favoritesDataSource.deleteFromFavorites(id: 1)).thenAnswer(
        (realInvocation) async =>
            await favoritesMock.deleteFromFavorites(id: 1));

    /// Repositories Stubs
    when(authRepository.authorize())
        .thenAnswer((realInvocation) async => await authDataSource.authorize());

    when(authRepository.updateToken()).thenAnswer(
        (realInvocation) async => await authDataSource.updateToken());

    when(orderRepository.createOrder()).thenAnswer(
        (realInvocation) async => await orderDataSource.createOrder());

    when(productsRepository.getAllProducts())
        .thenAnswer((realInvocation) async {
      final dtoProducts = await productsDataSource.getAllProducts();

      return dtoProducts.map(dtoToProductMapper).toList();
    });

    when(favoritesRepository.getFavorites()).thenAnswer((realInvocation) async {
      final dtoProducts = await favoritesDataSource.getFavorites();

      return dtoProducts.map(dtoToProductMapper).toList();
    });

    when(favoritesRepository.addToFavorites(id: 1))
        .thenAnswer((realInvocation) async {
      final dtoProducts = await favoritesDataSource.addToFavorites(id: 1);

      return dtoProducts.map(dtoToProductMapper).toList();
    });

    when(favoritesRepository.deleteFromFavorites(id: 1))
        .thenAnswer((realInvocation) async {
      final dtoProducts = await favoritesDataSource.deleteFromFavorites(id: 1);

      return dtoProducts.map(dtoToProductMapper).toList();
    });

    when(cartRepository.getCart()).thenAnswer((realInvocation) async {
      final dto = await cartDataSource.getCart();

      return dtoToCartMapper(dto);
    });

    when(cartRepository.addToCart(id: 1)).thenAnswer((realInvocation) async {
      final dto = await cartDataSource.addToCart(id: 1);

      return dtoToCartMapper(dto);
    });

    when(cartRepository.deleteFromCart(id: 1))
        .thenAnswer((realInvocation) async {
      final dto = await cartDataSource.deleteFromCart(id: 1);

      return dtoToCartMapper(dto);
    });

    app = await MockDiContainer(
      authMock: authMock,
      orderMock: orderMock,
      productsMock: productsMock,
      cartMock: cartMock,
      favoritesMock: favoritesMock,
      authDataSource: authDataSource,
      orderDataSource: orderDataSource,
      favoritesDataSource: favoritesDataSource,
      cartDataSource: cartDataSource,
      productsDataSource: productsDataSource,
      authRepository: authRepository,
      orderRepository: orderRepository,
      favoritesRepository: favoritesRepository,
      cartRepository: cartRepository,
      productsRepository: productsRepository,
      cartManager: cartManager,
      favoritesManager: favoritesManager,
      productsManager: productsManager,
    ).configureDependencies();
  });

  testWidgets('Integration Test', (widgetTester) async {});
}
