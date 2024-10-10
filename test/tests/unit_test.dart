import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:seo_web/core/common/consts/consts.dart';
import 'package:seo_web/core/common/errors_bus/errors_bus.dart';
import 'package:seo_web/feature/data/data_source/remote_data_source/auth/auth_data_source.dart';
import 'package:seo_web/feature/data/data_source/remote_data_source/cart/cart_data_source.dart';
import 'package:seo_web/feature/data/data_source/remote_data_source/favorites/favorites_data_source.dart';
import 'package:seo_web/feature/data/data_source/remote_data_source/order/order_data_source.dart';
import 'package:seo_web/feature/data/data_source/remote_data_source/products/products_data_source.dart';
import 'package:seo_web/feature/data/model/auth/auth_response_dto.dart';
import 'package:seo_web/feature/data/model/auth/free_token_response_dto.dart';
import 'package:seo_web/feature/data/model/cart/cart_dto.dart';
import 'package:seo_web/feature/data/model/cart/mapper/cart_mapper.dart';
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
import 'package:seo_web/feature/domain/entity/cart_entity.dart';
import 'package:seo_web/feature/domain/entity/products_entity.dart';
import 'package:seo_web/feature/domain/managers/cart/cart_manager.dart';
import 'package:seo_web/feature/domain/managers/cart/i_cart_manager.dart';
import 'package:seo_web/feature/domain/managers/favorites/favorites_manager.dart';
import 'package:seo_web/feature/domain/managers/favorites/i_favorites_manager.dart';
import 'package:seo_web/feature/domain/managers/products/i_products_manager.dart';
import 'package:seo_web/feature/domain/managers/products/products_manager.dart';

import '../mocks/data.dart';
import '../mocks/data_sources.mocks.dart';
import '../mocks/services.mocks.dart';

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
  late final IErrorsBus errorsBus;

  setUpAll(
    () {
      errorsBus = ErrorsBus();

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
      authRepository = AuthRepository(authDataSource);
      orderRepository = OrderRepository(dataSource: orderDataSource);
      favoritesRepository =
          FavoritesRepository(dataSource: favoritesDataSource);
      cartRepository = CartRepository(dataSource: cartDataSource);
      productsRepository = ProductsRepository(dataSource: productsDataSource);

      /// Managers init
      cartManager = CartManager(
        cartRepository: cartRepository,
        errorsBus: errorsBus,
        orderRepository: orderRepository,
      );

      favoritesManager = FavoritesManager(
        favoritesRepository: favoritesRepository,
        errorsBus: errorsBus,
      );

      productsManager = ProductsManager(
        productsRepository: productsRepository,
        errorsBus: errorsBus,
        allProductsCategoryName: Consts.allProductsCategoryName,
      );

      /// Services stubs
      when(authMock.authorize()).thenAnswer(
        (_) => Future(
          () => const AuthResponseDto(
            accessToken: 'accessToken',
            refreshToken: 'refreshToken',
          ),
        ),
      );

      when(authMock.refresh()).thenAnswer(
        (_) async => const FreeTokenResponseDto(
          accessToken: 'accessToken',
          refreshToken: 'refreshToken',
        ),
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

      when(cartDataSource.addToCart(id: 1)).thenAnswer(
          (realInvocation) async => await cartMock.addToCart(id: 1));

      when(cartDataSource.deleteFromCart(id: 1)).thenAnswer(
          (realInvocation) async => await cartMock.deleteFromCart(id: 1));

      when(favoritesDataSource.getFavorites()).thenAnswer(
          (realInvocation) async => await favoritesMock.getFavorites());

      when(favoritesDataSource.addToFavorites(id: 1)).thenAnswer(
          (realInvocation) async => await favoritesMock.addToFavorites(id: 1));

      when(favoritesDataSource.deleteFromFavorites(id: 1)).thenAnswer(
          (realInvocation) async =>
              await favoritesMock.deleteFromFavorites(id: 1));
    },
  );

  group(
    'Test Data Sources',
    () {
      test('Order Data Source returns success ', () async {
        final orderResponse = await orderDataSource.createOrder();

        expect(orderResponse, 'success');
      });

      test('Product Data Source returns List<ProductDto> ', () async {
        final productResponse = await productsDataSource.getAllProducts();

        expect(productResponse, const TypeMatcher<List<ProductDto>>());
      });

      test(
        'Cart Data Source returns CartDto and expected number of products ',
        () async {
          final cartGetResponse = await cartDataSource.getCart();
          final cartAddResponse = await cartDataSource.addToCart(id: 1);
          final cartDeleteResponse = await cartDataSource.deleteFromCart(id: 1);

          expect(cartGetResponse, const TypeMatcher<CartDto>());
          expect(cartAddResponse.products.length, equals(3));
          expect(cartDeleteResponse.products.length, equals(2));
        },
      );

      test(
          'Favorites Data Source returns List<ProductDto> and expected number of products ',
          () async {
        final favoritesGetResponse = await favoritesDataSource.getFavorites();
        final favoritesAddResponse =
            await favoritesDataSource.addToFavorites(id: 1);
        final favoritesDeleteResponse =
            await favoritesDataSource.deleteFromFavorites(id: 1);

        expect(favoritesGetResponse, const TypeMatcher<List<ProductDto>>());
        expect(favoritesAddResponse.length, equals(3));
        expect(favoritesDeleteResponse.length, equals(2));
      });
    },
  );

  group('Test Repositories', () {
    test(
      'Auth Repository methods return (String, String) records',
      () async {
        final authResponse = await authRepository.authorize();
        final updateTokenResponse = await authRepository.updateToken();

        expect(authResponse, const TypeMatcher<(String, String)>());
        expect(updateTokenResponse, const TypeMatcher<(String, String)>());
      },
    );

    test('Order Repository returns success ', () async {
      final orderResponse = await orderRepository.createOrder();

      expect(orderResponse, 'success');
    });

    test(
        'Product Repository returns List<ProductEntity> with same number of products as dto ',
        () async {
      final productDtoResponse = await productsDataSource.getAllProducts();

      final productEntityResponse = await productsRepository.getAllProducts();

      expect(productEntityResponse, const TypeMatcher<List<ProductEntity>>());
      expect(productEntityResponse.length, equals(productDtoResponse.length));
    });

    test(
        'Cart Repository returns CartEntityt with same number of products as dto',
        () async {
      final cartDtoGetResponse = await cartDataSource.getCart();
      final cartDtoAddResponse = await cartDataSource.addToCart(id: 1);
      final cartDtoDeleteResponse = await cartDataSource.deleteFromCart(id: 1);

      final cartGetEntityResponse = await cartRepository.getCart();
      final cartAddEntityResponse = await cartRepository.addToCart(id: 1);
      final cartDeleteEntityResponse =
          await cartRepository.deleteFromCart(id: 1);

      expect(cartGetEntityResponse, const TypeMatcher<CartEntity>());

      expect(calcOffersCount(cartGetEntityResponse.offers),
          equals(cartDtoGetResponse.products.length));

      expect(cartAddEntityResponse, const TypeMatcher<CartEntity>());

      expect(calcOffersCount(cartAddEntityResponse.offers),
          equals(cartDtoAddResponse.products.length));

      expect(cartDeleteEntityResponse, const TypeMatcher<CartEntity>());

      expect(calcOffersCount(cartDeleteEntityResponse.offers),
          equals(cartDtoDeleteResponse.products.length));
    });

    test(
        'Favorites Repository returns List<ProductEntity>  with same number of products as dto',
        () async {
      final favoritesGetDtoResponse = await favoritesDataSource.getFavorites();
      final favoritesAddDtoResponse =
          await favoritesDataSource.addToFavorites(id: 1);
      final favoritesDeleteDtoResponse =
          await favoritesDataSource.deleteFromFavorites(id: 1);

      final favoritesGetResponse = await favoritesRepository.getFavorites();
      final favoritesAddResponse =
          await favoritesRepository.addToFavorites(id: 1);
      final favoritesDeleteResponse =
          await favoritesRepository.deleteFromFavorites(id: 1);

      expect(favoritesGetResponse, const TypeMatcher<List<ProductEntity>>());
      expect(
          favoritesGetResponse.length, equals(favoritesGetDtoResponse.length));

      expect(favoritesAddResponse, const TypeMatcher<List<ProductEntity>>());
      expect(
          favoritesAddResponse.length, equals(favoritesAddDtoResponse.length));

      expect(favoritesDeleteResponse, const TypeMatcher<List<ProductEntity>>());
      expect(favoritesDeleteResponse.length,
          equals(favoritesDeleteDtoResponse.length));
    });
  });
  group('Managers tests', () {
    test('Test getProducts adds products to productsState', () async {
      final products = await productsRepository.getAllProducts();

      await productsManager.getAllProducts();

      final managerProducts = productsManager.productsState.value.data;

      expect(managerProducts, products);
    });

    test('Test findPoductById adds nothing to selectedProductId', () async {
      await productsManager.getAllProducts();

      productsManager.findProductById(1);

      final selectedProductId =
          productsManager.selectedProductController.valueOrNull?.id;

      expect(selectedProductId, equals(null));
    });

    test('Test findProductById adds product to selectedProductId', () async {
      await productsManager.getAllProducts();

      productsManager.findProductById(2);

      final selectedProductId =
          productsManager.selectedProductController.valueOrNull?.id;

      expect(selectedProductId, equals(2));
    });

    test('Test findProductsByCategory returns list of products', () async {
      await productsManager.getAllProducts();

      productsManager.findProductsByCategory("men's clothing");

      final products = productsManager.productsState.value.data ?? [];

      expect(products.length, equals(2));
    });

    test('Test findProductsByCategory returns empty list', () async {
      await productsManager.getAllProducts();

      productsManager.findProductsByCategory("wrong category");

      final products =
          productsManager.selectedCategoryProductsState.value.data ?? [];

      expect(products.isEmpty, isTrue);
    });

    test('Test getCategories returns list of unique categories', () async {
      await productsManager.getAllProducts();

      productsManager.getCategories();

      final categories = productsManager.categoriesState.value.data ?? [];

      expect(categories.length, equals(2));
    });

    test('Test getCart adds to cartState', () async {
      final cart = await cartRepository.getCart();

      await cartManager.getCart();

      final managerCart = cartManager.cartState.value.data;
      final cartChanged = cartManager.cartChangedController.valueOrNull;

      expect(managerCart, cart);
      expect(cartChanged, cart);
    });

    test('Test addToCart adds products to cartState', () async {
      final cart = await cartRepository.addToCart(id: 1);

      await cartManager.addToCart(
        product: ProductEntity(
          id: 1,
          price: Decimal.zero,
          title: 'title',
          description: 'description',
          category: 'category',
          image: '',
        ),
      );

      final managerCart = cartManager.cartState.value.data;
      final cartChanged = cartManager.cartChangedController.valueOrNull;

      expect(managerCart, cart);
      expect(cartChanged, cart);
    });

    test('Test deleteFromCart removes products from cartState', () async {
      final cart = await cartRepository.deleteFromCart(id: 1);

      await cartManager.deleteFromCart(
        product: ProductEntity(
          id: 1,
          price: Decimal.zero,
          title: 'title',
          description: 'description',
          category: 'category',
          image: '',
        ),
      );

      final managerCart = cartManager.cartState.value.data;
      final cartChanged = cartManager.cartChangedController.valueOrNull;

      expect(managerCart, cart);
      expect(cartChanged, cart);
    });

    test('Test getFavorites adds to favoritesState', () async {
      final favorites = await favoritesRepository.getFavorites();

      await favoritesManager.getFavorites();

      final managerFavorites = favoritesManager.favoritesState.value.data;
      final favoritesChanged =
          favoritesManager.favoritesChangedController.valueOrNull;

      expect(managerFavorites, favorites);
      expect(favoritesChanged, favorites);
    });

    test('Test addToFavorites adds product to favoritesState', () async {
      final favorites = await favoritesRepository.addToFavorites(id: 1);

      await favoritesManager.addToFavorites(
        product: ProductEntity(
          id: 1,
          price: Decimal.zero,
          title: 'title',
          description: 'description',
          category: 'category',
          image: 'image',
        ),
      );

      final managerFavorites = favoritesManager.favoritesState.value.data;
      final favoritesChanged =
          favoritesManager.favoritesChangedController.valueOrNull;

      expect(managerFavorites, favorites);
      expect(favoritesChanged, favorites);
    });

    test('Test deleteFromFavorites removes product from favoritesState',
        () async {
      final favorites = await favoritesRepository.deleteFromFavorites(id: 1);

      await favoritesManager.deleteFromFavorites(
        product: ProductEntity(
          id: 1,
          price: Decimal.zero,
          title: 'title',
          description: 'description',
          category: 'category',
          image: 'image',
        ),
      );

      final managerFavorites = favoritesManager.favoritesState.value.data;
      final favoritesChanged =
          favoritesManager.favoritesChangedController.valueOrNull;

      expect(managerFavorites, favorites);
      expect(favoritesChanged, favorites);
    });
  });
}
