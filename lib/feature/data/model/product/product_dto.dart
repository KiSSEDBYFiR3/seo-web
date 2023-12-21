import 'dart:async';

import 'package:decimal/decimal.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:seo_web/core/common/utils/json.dart';

part 'product_dto.g.dart';

@JsonSerializable(
  createFactory: true,
  createToJson: false,
  fieldRename: FieldRename.snake,
)
class ProductDto {
  final int id;
  final Decimal price;
  final String title;
  final String description;
  final String category;
  final String image;

  const ProductDto({
    required this.id,
    required this.price,
    required this.category,
    required this.description,
    required this.image,
    required this.title,
  });

  factory ProductDto.fromJson(Json json) => _$ProductDtoFromJson(json);
}

FutureOr<List<ProductDto>> deserializeProductDtoList(List<Json> json) =>
    json.map(ProductDto.fromJson).toList();
