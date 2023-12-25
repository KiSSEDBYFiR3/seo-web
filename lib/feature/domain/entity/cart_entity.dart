import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seo_web/feature/domain/entity/cart_offer_entity.dart';

part 'cart_entity.freezed.dart';

@freezed
class CartEntity with _$CartEntity {
  factory CartEntity({
    required Decimal price,
    required List<CartOfferEntity> offers,
  }) = _$$CartEntity;
}
