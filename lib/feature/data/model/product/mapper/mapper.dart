import 'package:decimal/decimal.dart';
import 'package:seo_web/feature/data/model/product/product_dto.dart';
import 'package:seo_web/feature/domain/entity/products_entity.dart';

ProductEntity dtoToProductMapper(ProductDto dto) {
  return ProductEntity(
    id: dto.id,
    price: Decimal.fromInt(dto.price.round()),
    title: dto.title,
    description: dto.description,
    category: dto.category,
    image: dto.image,
  );
}
