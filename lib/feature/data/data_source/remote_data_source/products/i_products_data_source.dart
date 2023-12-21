import 'package:seo_web/feature/data/model/product/product_dto.dart';

abstract interface class IProductDataSource {
  Future<List<ProductDto>> getAllProducts();
}
