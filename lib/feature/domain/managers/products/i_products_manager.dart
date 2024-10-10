import 'package:elementary_helper/elementary_helper.dart';
import 'package:rxdart/rxdart.dart';
import 'package:seo_web/feature/domain/entity/products_entity.dart';

abstract interface class IProductsManager {
  EntityStateNotifier<List<ProductEntity>> get productsState;

  EntityStateNotifier<List<ProductEntity>> get selectedCategoryProductsState;

  EntityStateNotifier<List<String>> get categoriesState;

  BehaviorSubject<ProductEntity> get selectedProductController;

  BehaviorSubject<String> get selectedCategoryName;

  Future<void> getAllProducts();

  void getCategories();

  void findProductById(int id);

  void findProductsByCategory(String category);

  void init();

  void dispose();
}
