// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart_offer_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CartOfferEntity {
  int get id => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  ProductEntity get product => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CartOfferEntityCopyWith<CartOfferEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartOfferEntityCopyWith<$Res> {
  factory $CartOfferEntityCopyWith(
          CartOfferEntity value, $Res Function(CartOfferEntity) then) =
      _$CartOfferEntityCopyWithImpl<$Res, CartOfferEntity>;
  @useResult
  $Res call({int id, int count, ProductEntity product});

  $ProductEntityCopyWith<$Res> get product;
}

/// @nodoc
class _$CartOfferEntityCopyWithImpl<$Res, $Val extends CartOfferEntity>
    implements $CartOfferEntityCopyWith<$Res> {
  _$CartOfferEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? count = null,
    Object? product = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      product: null == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as ProductEntity,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ProductEntityCopyWith<$Res> get product {
    return $ProductEntityCopyWith<$Res>(_value.product, (value) {
      return _then(_value.copyWith(product: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$$$CartOfferEntityImplCopyWith<$Res>
    implements $CartOfferEntityCopyWith<$Res> {
  factory _$$$$CartOfferEntityImplCopyWith(_$$$CartOfferEntityImpl value,
          $Res Function(_$$$CartOfferEntityImpl) then) =
      __$$$$CartOfferEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, int count, ProductEntity product});

  @override
  $ProductEntityCopyWith<$Res> get product;
}

/// @nodoc
class __$$$$CartOfferEntityImplCopyWithImpl<$Res>
    extends _$CartOfferEntityCopyWithImpl<$Res, _$$$CartOfferEntityImpl>
    implements _$$$$CartOfferEntityImplCopyWith<$Res> {
  __$$$$CartOfferEntityImplCopyWithImpl(_$$$CartOfferEntityImpl _value,
      $Res Function(_$$$CartOfferEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? count = null,
    Object? product = null,
  }) {
    return _then(_$$$CartOfferEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      product: null == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as ProductEntity,
    ));
  }
}

/// @nodoc

class _$$$CartOfferEntityImpl implements _$$CartOfferEntity {
  _$$$CartOfferEntityImpl(
      {required this.id, required this.count, required this.product});

  @override
  final int id;
  @override
  final int count;
  @override
  final ProductEntity product;

  @override
  String toString() {
    return 'CartOfferEntity(id: $id, count: $count, product: $product)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$$$CartOfferEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.product, product) || other.product == product));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, count, product);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$$$CartOfferEntityImplCopyWith<_$$$CartOfferEntityImpl> get copyWith =>
      __$$$$CartOfferEntityImplCopyWithImpl<_$$$CartOfferEntityImpl>(
          this, _$identity);
}

abstract class _$$CartOfferEntity implements CartOfferEntity {
  factory _$$CartOfferEntity(
      {required final int id,
      required final int count,
      required final ProductEntity product}) = _$$$CartOfferEntityImpl;

  @override
  int get id;
  @override
  int get count;
  @override
  ProductEntity get product;
  @override
  @JsonKey(ignore: true)
  _$$$$CartOfferEntityImplCopyWith<_$$$CartOfferEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
