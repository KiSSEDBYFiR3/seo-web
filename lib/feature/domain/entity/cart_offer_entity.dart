import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seo_web/feature/domain/entity/products_entity.dart';

part 'cart_offer_entity.freezed.dart';

@freezed
class CartOfferEntity with _$CartOfferEntity {
  factory CartOfferEntity({
    required int id,
    required int count,
    required ProductEntity product,
  }) = _$$CartOfferEntity;
}
