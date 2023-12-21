import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seo_web/feature/domain/entity/products_entity.dart';

part 'cart_entity.freezed.dart';

@freezed
class CartEntity with _CartEntity {
  factory CartEntity({
    required Decimal price,
    required List<ProductEntity> products,
  }) = _$CartEntity;
}
