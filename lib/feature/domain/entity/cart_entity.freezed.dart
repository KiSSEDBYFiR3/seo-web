// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _CartEntity {
  Decimal get price => throw _privateConstructorUsedError;
  List<ProductEntity> get products => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CartEntityCopyWith<CartEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartEntityCopyWith<$Res> {
  factory $CartEntityCopyWith(
          CartEntity value, $Res Function(CartEntity) then) =
      _$CartEntityCopyWithImpl<$Res, CartEntity>;
  @useResult
  $Res call({Decimal price, List<ProductEntity> products});
}

/// @nodoc
class _$CartEntityCopyWithImpl<$Res, $Val extends CartEntity>
    implements $CartEntityCopyWith<$Res> {
  _$CartEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? price = null,
    Object? products = null,
  }) {
    return _then(_value.copyWith(
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as Decimal,
      products: null == products
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<ProductEntity>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$$CartEntityImplCopyWith<$Res>
    implements $CartEntityCopyWith<$Res> {
  factory _$$$CartEntityImplCopyWith(
          _$$CartEntityImpl value, $Res Function(_$$CartEntityImpl) then) =
      __$$$CartEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Decimal price, List<ProductEntity> products});
}

/// @nodoc
class __$$$CartEntityImplCopyWithImpl<$Res>
    extends _$CartEntityCopyWithImpl<$Res, _$$CartEntityImpl>
    implements _$$$CartEntityImplCopyWith<$Res> {
  __$$$CartEntityImplCopyWithImpl(
      _$$CartEntityImpl _value, $Res Function(_$$CartEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? price = null,
    Object? products = null,
  }) {
    return _then(_$$CartEntityImpl(
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as Decimal,
      products: null == products
          ? _value._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<ProductEntity>,
    ));
  }
}

/// @nodoc

class _$$CartEntityImpl implements _$CartEntity {
  _$$CartEntityImpl(
      {required this.price, required final List<ProductEntity> products})
      : _products = products;

  @override
  final Decimal price;
  final List<ProductEntity> _products;
  @override
  List<ProductEntity> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  @override
  String toString() {
    return 'CartEntity(price: $price, products: $products)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$$CartEntityImpl &&
            (identical(other.price, price) || other.price == price) &&
            const DeepCollectionEquality().equals(other._products, _products));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, price, const DeepCollectionEquality().hash(_products));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$$CartEntityImplCopyWith<_$$CartEntityImpl> get copyWith =>
      __$$$CartEntityImplCopyWithImpl<_$$CartEntityImpl>(this, _$identity);
}

abstract class _$CartEntity implements CartEntity {
  factory _$CartEntity(
      {required final Decimal price,
      required final List<ProductEntity> products}) = _$$CartEntityImpl;

  @override
  Decimal get price;
  @override
  List<ProductEntity> get products;
  @override
  @JsonKey(ignore: true)
  _$$$CartEntityImplCopyWith<_$$CartEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
