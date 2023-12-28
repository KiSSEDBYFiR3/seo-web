import 'dart:async';

import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:seo_web/core/common/utils/json.dart';
import 'package:seo_web/feature/data/model/product/product_dto.dart';

part 'cart_dto.g.dart';

@JsonSerializable(
  createFactory: true,
  createToJson: false,
  fieldRename: FieldRename.snake,
)
class CartDto extends Equatable {
  final Decimal price;

  final List<ProductDto> products;

  const CartDto({
    required this.price,
    required this.products,
  });

  factory CartDto.fromJson(Json json) => _$CartDtoFromJson(json);

  @override
  List<Object?> get props => [price, products];
}

FutureOr<CartDto> deserializeCartDto(Json json) => CartDto.fromJson(json);
