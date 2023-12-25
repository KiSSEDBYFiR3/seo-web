import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'products_entity.freezed.dart';

@freezed
class ProductEntity with _$ProductEntity {
  factory ProductEntity({
    required int id,
    required Decimal price,
    required String title,
    required String description,
    required String category,
    required String image,
  }) = _$$ProductEntity;
}
