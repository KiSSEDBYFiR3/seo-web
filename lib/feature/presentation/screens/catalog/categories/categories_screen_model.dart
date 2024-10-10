import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:seo_web/feature/domain/managers/products/i_products_manager.dart';

abstract interface class ICategoriesModel extends ElementaryModel {
  void getCategories();

  void selectCategory(String category);

  EntityStateNotifier<List<String>> get categoriesState;
}

final class CategoriesModel extends ElementaryModel
    implements ICategoriesModel {
  final IProductsManager productsManager;

  CategoriesModel({super.errorHandler, required this.productsManager});

  @override
  EntityStateNotifier<List<String>> get categoriesState =>
      productsManager.categoriesState;

  @override
  void getCategories() => productsManager.getCategories();

  @override
  void selectCategory(String category) =>
      productsManager.findProductsByCategory(category);
  @override
  void init() {
    productsManager.getAllProducts();
    super.init();
  }
}
