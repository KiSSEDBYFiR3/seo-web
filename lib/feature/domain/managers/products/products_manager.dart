import 'package:elementary_helper/elementary_helper.dart';
import 'package:seo_web/feature/domain/entity/products_entity.dart';
import 'package:seo_web/feature/domain/managers/products/i_products_manager.dart';
import 'package:seo_web/feature/domain/repository/products/i_products_repository.dart';

class ProductsManager implements IProductsManager {
  final IProductsRepository _productsRepository;

  ProductsManager({required IProductsRepository productsRepository})
      : _productsRepository = productsRepository;

  @override
  EntityStateNotifier<List<ProductEntity>> get productsState =>
      throw UnimplementedError();

  final EntityStateNotifier<List<ProductEntity>> _productsState =
      EntityStateNotifier();

  @override
  Future<void> getAllProducts() async {
    final oldProducts = _productsState.value.data ?? [];

    _productsState.loading(oldProducts);

    final products = await _productsRepository.getAllProducts();

    _productsState.content(products);
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
