import 'package:seo_web/feature/data/data_source/remote_data_source/products/i_products_data_source.dart';
import 'package:seo_web/feature/data/model/product/product_dto.dart';
import 'package:seo_web/feature/data/services/products/products_service.dart';

class ProductsDataSource implements IProductDataSource {
  final ProductsService _productsService;

  const ProductsDataSource({required ProductsService productsService})
      : _productsService = productsService;
  @override
  Future<List<ProductDto>> getAllProducts() async =>
      await _productsService.getAllProducts();
}
