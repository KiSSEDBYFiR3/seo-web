import 'package:seo_web/feature/data/data_source/remote_data_source/products/i_products_data_source.dart';
import 'package:seo_web/feature/data/model/product/mapper/mapper.dart';
import 'package:seo_web/feature/domain/entity/products_entity.dart';
import 'package:seo_web/feature/domain/repository/products/i_products_repository.dart';

class ProductsRepository implements IProductsRepository {
  final IProductDataSource _dataSource;

  const ProductsRepository({
    required IProductDataSource dataSource,
  }) : _dataSource = dataSource;

  @override
  Future<List<ProductEntity>> getAllProducts() async =>
      (await _dataSource.getAllProducts()).map(dtoToProductMapper).toList();
}
