// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:seo_web/core/icons/custom_icons.dart';
import 'package:seo_web/feature/data/data_source/remote_data_source/cart/cart_data_source.dart';
import 'package:seo_web/feature/data/data_source/remote_data_source/favorites/favorites_data_source.dart';
import 'package:seo_web/feature/data/data_source/remote_data_source/order/order_data_source.dart';
import 'package:seo_web/feature/data/data_source/remote_data_source/products/products_data_source.dart';
import 'package:seo_web/feature/data/model/cart/cart_dto.dart';
import 'package:seo_web/feature/data/model/cart/mapper/cart_mapper.dart';
import 'package:seo_web/feature/data/model/product/mapper/mapper.dart';
import 'package:seo_web/feature/data/model/product/product_dto.dart';
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
import 'package:seo_web/generated/l10n.dart';

import '../test/mocks/data.dart';
import '../test/mocks/data_sources.mocks.dart';
import '../test/mocks/managers_mocks.dart';
import '../test/mocks/mock_di_builder.dart';
import '../test/mocks/repositories.mocks.dart';
import '../test/mocks/services.mocks.dart';

void main() {
  late OrderService orderMock;
  late ProductsService productsMock;
  late CartService cartMock;
  late FavoritesService favoritesMock;

  late OrderDataSource orderDataSource;
  late FavoritesDataSource favoritesDataSource;
  late CartDataSource cartDataSource;
  late ProductsDataSource productsDataSource;

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

    orderMock = MockOrderService();
    productsMock = MockProductsService();
    cartMock = MockCartService();
    favoritesMock = MockFavoritesService();

    /// Data Sources init

    orderDataSource = MockOrderDataSource();
    favoritesDataSource = MockFavoritesDataSource();
    cartDataSource = MockCartDataSource();
    productsDataSource = MockProductsDataSource();

    /// Repositories init
    orderRepository = MockOrderRepository();
    favoritesRepository = MockFavoritesRepository();
    cartRepository = MockCartRepository();
    productsRepository = MockProductsRepository();

    /// Services stubs
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
      (_) async => productAddedStub.map(ProductDto.fromJson).toList(),
    );

    when(orderMock.createOrder()).thenAnswer(
      (_) async => 'success',
    );

    /// Data Sources stubs

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

    /// Managers init
    cartManager = MockCartManager(
      repository: cartRepository,
      orderRepository: orderRepository,
    )..init();

    favoritesManager = MockFavoritesManager(repository: favoritesRepository)
      ..init();

    productsManager = MockProductsManager(repository: productsRepository)
      ..init();

    app = await MockDiContainer(
      orderMock: orderMock,
      productsMock: productsMock,
      cartMock: cartMock,
      favoritesMock: favoritesMock,
      orderDataSource: orderDataSource,
      favoritesDataSource: favoritesDataSource,
      cartDataSource: cartDataSource,
      productsDataSource: productsDataSource,
      orderRepository: orderRepository,
      favoritesRepository: favoritesRepository,
      cartRepository: cartRepository,
      productsRepository: productsRepository,
      cartManager: cartManager,
      favoritesManager: favoritesManager,
      productsManager: productsManager,
    ).configureDependencies();
  });

  testWidgets('Integration Test', (widgetTester) async {
    await widgetTester.pumpWidget(app);
    await widgetTester.pumpAndSettle();

    // finds one unique category
    final category = find.text("Men's Clothing");

    expect(category, findsOneWidget);

    // opens Products Screen which has three unique products
    await widgetTester.tap(category);

    await Future.delayed(const Duration(seconds: 2));

    final widgetOne = find.byKey(const ValueKey('product-1'));
    final widgetTwo = find.byKey(const ValueKey('product-2'));
    final widgetThree = find.byKey(const ValueKey('product-3'));

    expect(widgetOne, findsOneWidget);
    expect(widgetTwo, findsOneWidget);
    expect(widgetThree, findsOneWidget);

    // finds favorites button and adds product to favorites
    final toFavoritesButton = find.byKey(const ValueKey('favorite-button-1'));

    expect(toFavoritesButton, findsOneWidget);

    await widgetTester.tap(toFavoritesButton);

    // finds favorites tab bar button and opens favorites tab with three unique products
    final favoritesTabButton = find.byIcon(CustomIcons.favorites);

    expect(favoritesTabButton, findsOneWidget);

    await widgetTester.tap(favoritesTabButton);

    await widgetTester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2));

    final favoriteOne = find.byKey(const ValueKey('product-1'));
    final favoriteTwo = find.byKey(const ValueKey('product-2'));
    final favoriteThree = find.byKey(const ValueKey('product-3'));

    expect(favoriteOne, findsOneWidget);
    expect(favoriteTwo, findsOneWidget);
    expect(favoriteThree, findsOneWidget);

    // finds one add to cart button and ands one product to cart
    final context = widgetTester.element(favoriteOne);
    final locale = S.of(context);
    final addToCart = find.text(locale.addToCart);

    expect(addToCart, findsOneWidget);

    await widgetTester.tap(addToCart);

    // finds one cart tab button and opens cart tab which has three offers
    final cartTabButton = find.byIcon(CustomIcons.cart);
    expect(cartTabButton, findsOneWidget);

    await widgetTester.tap(cartTabButton);

    await widgetTester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2));

    final cartOfferOne = find.byKey(const ValueKey('offer-${1}'));
    final cartOfferTwo = find.byKey(const ValueKey('offer-${2}'));
    final cartOfferThree = find.byKey(const ValueKey('offer-${3}'));

    expect(cartOfferOne, findsOneWidget);
    expect(cartOfferTwo, findsOneWidget);
    expect(cartOfferThree, findsOneWidget);

    // opens Product Card Screen
    await widgetTester.tap(cartOfferOne);

    await widgetTester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2));

    final descriprion = find.text(
        '''Your perfect pack for everyday use and walks in the forest. Stash your laptop
              (up to 15 inches) in the padded sleeve, your everyday
''');

    expect(descriprion, findsOneWidget);
  });
}
