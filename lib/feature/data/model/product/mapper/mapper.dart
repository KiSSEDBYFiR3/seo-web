import 'package:seo_web/feature/data/model/product/product_dto.dart';
import 'package:seo_web/feature/domain/entity/products_entity.dart';

ProductEntity dtoToProductMapper(ProductDto dto) {
  return ProductEntity(
    id: dto.id,
    price: dto.price,
    title: dto.title,
    description: dto.description,
    category: dto.category,
    image: dto.image,
  );
}
