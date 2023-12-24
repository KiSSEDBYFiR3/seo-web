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

  Logger get _logger => Logger('Catalog');

  ProductsManager({
    required IProductsRepository productsRepository,
    required IErrorsBus errorsBus,
  })  : _productsRepository = productsRepository,
        _errorsBus = errorsBus;

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
      _errorsBus.addException(Exceptions.getCatalogException);
      throw Exceptions.getCatalogException;
    }
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
