import 'package:seo_web/feature/data/model/cart/cart_dto.dart';
import 'package:seo_web/feature/data/model/product/mapper/mapper.dart';
import 'package:seo_web/feature/domain/entity/cart_entity.dart';

CartEntity dtoToCartMapper(CartDto dto) {
  return CartEntity(
    price: dto.price,
    products: dto.products.map(dtoToProductMapper).toList(),
  );
}
