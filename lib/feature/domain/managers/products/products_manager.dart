import 'package:elementary_helper/elementary_helper.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';
import 'package:seo_web/core/common/errors_bus/errors_bus.dart';
import 'package:seo_web/core/exception/exceptions.dart';
import 'package:seo_web/feature/domain/entity/products_entity.dart';
import 'package:seo_web/feature/domain/managers/products/i_products_manager.dart';
import 'package:seo_web/feature/domain/repository/products/i_products_repository.dart';

class ProductsManager implements IProductsManager {
  final IProductsRepository _productsRepository;
  final IErrorsBus _errorsBus;
  final String _allProductCategoryName;

  Logger get _logger => Logger('Catalog');

  ProductsManager({
    required IProductsRepository productsRepository,
    required IErrorsBus errorsBus,
    required String allProductsCategoryName,
  })  : _productsRepository = productsRepository,
        _errorsBus = errorsBus,
        _allProductCategoryName = allProductsCategoryName;

  @override
  EntityStateNotifier<List<ProductEntity>> get productsState =>
      _selectedCategoryProductsState;

  final EntityStateNotifier<List<ProductEntity>>
      _selectedCategoryProductsState = EntityStateNotifier();

  @override
  EntityStateNotifier<List<String>> get categoriesState => _categoriesState;

  final EntityStateNotifier<List<String>> _categoriesState =
      EntityStateNotifier();

  final BehaviorSubject<List<ProductEntity>> _productsState = BehaviorSubject();

  @override
  BehaviorSubject<ProductEntity> get selectedProductController =>
      _selectedProductController;

  final BehaviorSubject<ProductEntity> _selectedProductController =
      BehaviorSubject();

  @override
  Future<void> getAllProducts() async {
    try {
      final products = await _productsRepository.getAllProducts();

      _productsState.add(products);
      getCategories();
    } catch (e) {
      _logger.shout(e);
      _errorsBus.addException(Exceptions.getCatalogException);
      throw Exceptions.getCatalogException;
    }
  }

  @override
  void getCategories() {
    final products = _productsState.valueOrNull;

    if (products == null) {
      return;
    }

    List<String> categories = [];

    categoriesState.loading(categories);

    categories.add(_allProductCategoryName);

    final foundCategories = products.map((e) => e.category).toSet().toList();

    categories.addAll(foundCategories);

    categoriesState.content(categories);
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

    _selectedProductController.add(product);
  }

  @override
  void findProductsByCategory(String category) {
    final products = _productsState.valueOrNull;
    if (products == null) {
      return;
    }

    _selectedCategoryProductsState.loading([]);

    _selectedCategoryName.add(category);

    if (category == _allProductCategoryName) {
      _selectedCategoryProductsState.content(products);
      return;
    }

    final foundProducts =
        products.where((e) => e.category == category).toList();

    _selectedCategoryProductsState.content(foundProducts);
  }

  @override
  void dispose() {
    _productsState.close();
    _selectedProductController.close();
    selectedProductController.close();
    selectedCategoryName.close();
    selectedCategoryName.close();

    _categoriesState.dispose();
    categoriesState.dispose();

    productsState.dispose();
  }

  @override
  void init() async {
    await getAllProducts();
  }

  @override
  BehaviorSubject<String> get selectedCategoryName => _selectedCategoryName;

  final BehaviorSubject<String> _selectedCategoryName = BehaviorSubject();
}
