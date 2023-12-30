import 'package:seo_web/feature/domain/managers/products/i_products_manager.dart';

abstract interface class IProductSelectorProvider {
  IProductsManager get productsManager;

  void selectProduct(int id);
}

mixin ProductSelectorProvider implements IProductSelectorProvider {
  @override
  void selectProduct(int id) => productsManager.findProductById(id);
}
