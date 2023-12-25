import 'package:elementary_helper/elementary_helper.dart';
import 'package:logging/logging.dart';
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
  EntityStateNotifier<List<ProductEntity>> get productsState => _productsState;

  final EntityStateNotifier<List<ProductEntity>> _productsState =
      EntityStateNotifier();

  @override
  Future<void> getAllProducts() async {
    try {
      final oldProducts = _productsState.value.data ?? [];

      _productsState.loading(oldProducts);

      final products = await _productsRepository.getAllProducts();

      _productsState.content(products);
    } catch (e) {
      _logger.shout(e);
      _errorsBus.addException(Exceptions.getCatalogException);
      throw Exceptions.getCatalogException;
    }
  }

  @override
  List<String> getCategories() {
    final products = _productsState.value.data;
    if (products == null) {
      return [];
    }

    List<String> categories = [];

    categories.add(_allProductCategoryName);

    final foundCategories = products.map((e) => e.category).toSet().toList();

    categories.addAll(foundCategories);

    return categories;
  }

  @override
  ProductEntity? findProductById(int id) {
    final products = _productsState.value.data;
    if (products == null) {
      return null;
    }

    return products.firstWhere((element) => element.id == id);
  }

  @override
  List<ProductEntity> findProductsByCategory(String category) {
    final products = _productsState.value.data;
    if (products == null) {
      return [];
    }

    if (category == _allProductCategoryName) {
      return products;
    }

    return products.where((e) => e.category == category).toList();
  }

  @override
  void dispose() {
    _productsState.dispose();

    productsState.dispose();
  }

  @override
  void init() async {
    await getAllProducts();
  }
}
