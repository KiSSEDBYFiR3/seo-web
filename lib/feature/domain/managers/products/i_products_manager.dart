import 'package:elementary_helper/elementary_helper.dart';
import 'package:seo_web/feature/domain/entity/products_entity.dart';

abstract interface class IProductsManager {
  EntityStateNotifier<List<ProductEntity>> get productsState;

  Future<void> getAllProducts();

  List<String> getCategories();

  ProductEntity? findProductById(int id);

  List<ProductEntity> findProductsByCategory(String category);

  void init();

  void dispose();
}
