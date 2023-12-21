import 'package:seo_web/feature/domain/entity/products_entity.dart';

abstract interface class IProductsRepository {
  Future<List<ProductEntity>> getAllProducts();
}
