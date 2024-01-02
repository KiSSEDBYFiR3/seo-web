import 'package:elementary_helper/src/relations/notifier/entity_state_notifier.dart';
import 'package:rxdart/src/subjects/behavior_subject.dart';
import 'package:seo_web/core/exception/app_exceptions.dart';
import 'package:seo_web/feature/data/repository/favorites/favorites_repository.dart';
import 'package:seo_web/feature/domain/entity/cart_entity.dart';
import 'package:seo_web/feature/domain/entity/products_entity.dart';
import 'package:seo_web/feature/domain/managers/cart/i_cart_manager.dart';
import 'package:seo_web/feature/domain/managers/favorites/i_favorites_manager.dart';
import 'package:seo_web/feature/domain/managers/products/i_products_manager.dart';
import 'package:seo_web/feature/domain/repository/cart/i_cart_repository.dart';
import 'package:seo_web/feature/domain/repository/order/i_order_repository.dart';
import 'package:seo_web/feature/domain/repository/products/i_products_repository.dart';

class MockFavoritesManager implements IFavoritesManager {
  final FavoritesRepository repository;

  MockFavoritesManager({required this.repository});

  @override
  Future<void> addToFavorites({required ProductEntity product}) async {
    final products = await repository.addToFavorites(id: product.id);

    favoritesState.content(products);
    favoritesChangedController.add(products);
  }

  @override
  Future<void> deleteFromFavorites({required ProductEntity product}) async {
    final products = await repository.deleteFromFavorites(id: product.id);

    favoritesState.content(products);
    favoritesChangedController.add(products);
  }

  @override
  void dispose() {
    favoritesState.dispose();
    favoritesChangedController.close();
  }

  @override
  final BehaviorSubject<List<ProductEntity>> favoritesChangedController =
      BehaviorSubject();

  @override
  final EntityStateNotifier<List<ProductEntity>> favoritesState =
      EntityStateNotifier();

  @override
  Future<void> getFavorites() async {
    final products = await repository.getFavorites();

    favoritesState.content(products);
    favoritesChangedController.add(products);
  }

  @override
  void init() async {
    await getFavorites();
  }
}

class MockCartManager implements ICartManager {
  final ICartRepository repository;
  final IOrderRepository orderRepository;

  MockCartManager({
    required this.repository,
    required this.orderRepository,
  });

  @override
  Future<void> addToCart({required ProductEntity product}) async {
    final cart = await repository.addToCart(id: product.id);

    cartState.content(cart);
    cartChangedController.add(cart);
  }

  @override
  final BehaviorSubject<CartEntity> cartChangedController = BehaviorSubject();

  @override
  final EntityStateNotifier<CartEntity?> cartState = EntityStateNotifier();

  @override
  Future<void> createOrder() async {
    final result = await orderRepository.createOrder();

    if (result == 'success') {
      final oldCart = cartState.value.data;
      if (oldCart != null) {
        final newCart = oldCart.copyWith(offers: []);
        cartState.loading(newCart);

        cartState.content(newCart);
        cartChangedController.add(newCart);
      }
      return;
    } else {
      throw const OrderException('message');
    }
  }

  @override
  Future<void> deleteFromCart({required ProductEntity product}) async {
    final products = await repository.deleteFromCart(id: product.id);

    cartState.content(products);
    cartChangedController.add(products);
  }

  @override
  void dispose() {
    cartState.dispose();
    cartChangedController.close();
  }

  @override
  Future<void> getCart() async {
    final products = await repository.getCart();

    cartState.content(products);
    cartChangedController.add(products);
  }

  @override
  void init() async {
    getCart();
  }
}

class MockProductsManager implements IProductsManager {
  final IProductsRepository repository;

  MockProductsManager({required this.repository});

  @override
  final EntityStateNotifier<List<String>> categoriesState =
      EntityStateNotifier();

  final BehaviorSubject<List<ProductEntity>> _productsState = BehaviorSubject();

  @override
  void dispose() {
    categoriesState.dispose();
    productsState.dispose();

    selectedProductController.close();
    selectedCategoryName.close();
    _productsState.close();
  }

  @override
  void findProductById(int id) {
    final products = _productsState.valueOrNull;
    if (products == null) {
      return;
    }

    final product = products
        .where(
          (element) => element.id == id,
        )
        .firstOrNull;

    if (product == null) {
      return;
    }

    selectedProductController.add(product);
  }

  @override
  void findProductsByCategory(String category) {
    final products = _productsState.valueOrNull;
    if (products == null) {
      return;
    }

    selectedCategoryName.add(category);

    final foundProducts =
        products.where((e) => e.category == category).toList();

    productsState.content(foundProducts);
  }

  @override
  Future<void> getAllProducts() async {
    final products = await repository.getAllProducts();
    _productsState.add(products);
    productsState.content(products);
  }

  @override
  void getCategories() {
    final products = _productsState.valueOrNull;

    if (products == null) {
      return;
    }

    List<String> categories = [];

    categoriesState.loading(categories);

    final foundCategories = products.map((e) => e.category).toSet().toList();

    categories.addAll(foundCategories);

    categoriesState.content(categories);
  }

  @override
  void init() async {
    await getAllProducts();
    getCategories();
  }

  @override
  final EntityStateNotifier<List<ProductEntity>> productsState =
      EntityStateNotifier();

  @override
  final BehaviorSubject<String> selectedCategoryName = BehaviorSubject();

  @override
  final BehaviorSubject<ProductEntity> selectedProductController =
      BehaviorSubject();
}
