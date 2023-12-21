// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDto _$ProductDtoFromJson(Map<String, dynamic> json) => ProductDto(
      id: json['id'] as int,
      price: Decimal.fromJson(json['price'] as String),
      category: json['category'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      title: json['title'] as String,
    );
