// Mocks generated by Mockito 5.4.4 from annotations
// in seo_web/test/mocks/repositories.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i5;
import 'package:seo_web/feature/data/repository/auth/auth_repository.dart'
    as _i3;
import 'package:seo_web/feature/data/repository/cart/cart_repository.dart'
    as _i10;
import 'package:seo_web/feature/data/repository/favorites/favorites_repository.dart'
    as _i8;
import 'package:seo_web/feature/data/repository/order/order_repository.dart'
    as _i9;
import 'package:seo_web/feature/data/repository/products/products_repository.dart'
    as _i6;
import 'package:seo_web/feature/domain/entity/cart_entity.dart' as _i2;
import 'package:seo_web/feature/domain/entity/products_entity.dart' as _i7;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeCartEntity_0 extends _i1.SmartFake implements _i2.CartEntity {
  _FakeCartEntity_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [AuthRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthRepository extends _i1.Mock implements _i3.AuthRepository {
  MockAuthRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<(String, String)> authorize() => (super.noSuchMethod(
        Invocation.method(
          #authorize,
          [],
        ),
        returnValue: _i4.Future<(String, String)>.value((
          _i5.dummyValue<String>(
            this,
            Invocation.method(
              #authorize,
              [],
            ),
          ),
          _i5.dummyValue<String>(
            this,
            Invocation.method(
              #authorize,
              [],
            ),
          )
        )),
      ) as _i4.Future<(String, String)>);

  @override
  _i4.Future<(String, String)> updateToken() => (super.noSuchMethod(
        Invocation.method(
          #updateToken,
          [],
        ),
        returnValue: _i4.Future<(String, String)>.value((
          _i5.dummyValue<String>(
            this,
            Invocation.method(
              #updateToken,
              [],
            ),
          ),
          _i5.dummyValue<String>(
            this,
            Invocation.method(
              #updateToken,
              [],
            ),
          )
        )),
      ) as _i4.Future<(String, String)>);
}

/// A class which mocks [ProductsRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockProductsRepository extends _i1.Mock
    implements _i6.ProductsRepository {
  MockProductsRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<List<_i7.ProductEntity>> getAllProducts() => (super.noSuchMethod(
        Invocation.method(
          #getAllProducts,
          [],
        ),
        returnValue:
            _i4.Future<List<_i7.ProductEntity>>.value(<_i7.ProductEntity>[]),
      ) as _i4.Future<List<_i7.ProductEntity>>);
}

/// A class which mocks [FavoritesRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockFavoritesRepository extends _i1.Mock
    implements _i8.FavoritesRepository {
  MockFavoritesRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<List<_i7.ProductEntity>> addToFavorites({required int? id}) =>
      (super.noSuchMethod(
        Invocation.method(
          #addToFavorites,
          [],
          {#id: id},
        ),
        returnValue:
            _i4.Future<List<_i7.ProductEntity>>.value(<_i7.ProductEntity>[]),
      ) as _i4.Future<List<_i7.ProductEntity>>);

  @override
  _i4.Future<List<_i7.ProductEntity>> deleteFromFavorites({required int? id}) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteFromFavorites,
          [],
          {#id: id},
        ),
        returnValue:
            _i4.Future<List<_i7.ProductEntity>>.value(<_i7.ProductEntity>[]),
      ) as _i4.Future<List<_i7.ProductEntity>>);

  @override
  _i4.Future<List<_i7.ProductEntity>> getFavorites() => (super.noSuchMethod(
        Invocation.method(
          #getFavorites,
          [],
        ),
        returnValue:
            _i4.Future<List<_i7.ProductEntity>>.value(<_i7.ProductEntity>[]),
      ) as _i4.Future<List<_i7.ProductEntity>>);
}

/// A class which mocks [OrderRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockOrderRepository extends _i1.Mock implements _i9.OrderRepository {
  MockOrderRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<String> createOrder() => (super.noSuchMethod(
        Invocation.method(
          #createOrder,
          [],
        ),
        returnValue: _i4.Future<String>.value(_i5.dummyValue<String>(
          this,
          Invocation.method(
            #createOrder,
            [],
          ),
        )),
      ) as _i4.Future<String>);
}

/// A class which mocks [CartRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockCartRepository extends _i1.Mock implements _i10.CartRepository {
  MockCartRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.CartEntity> addToCart({required int? id}) =>
      (super.noSuchMethod(
        Invocation.method(
          #addToCart,
          [],
          {#id: id},
        ),
        returnValue: _i4.Future<_i2.CartEntity>.value(_FakeCartEntity_0(
          this,
          Invocation.method(
            #addToCart,
            [],
            {#id: id},
          ),
        )),
      ) as _i4.Future<_i2.CartEntity>);

  @override
  _i4.Future<_i2.CartEntity> deleteFromCart({required int? id}) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteFromCart,
          [],
          {#id: id},
        ),
        returnValue: _i4.Future<_i2.CartEntity>.value(_FakeCartEntity_0(
          this,
          Invocation.method(
            #deleteFromCart,
            [],
            {#id: id},
          ),
        )),
      ) as _i4.Future<_i2.CartEntity>);

  @override
  _i4.Future<_i2.CartEntity> getCart() => (super.noSuchMethod(
        Invocation.method(
          #getCart,
          [],
        ),
        returnValue: _i4.Future<_i2.CartEntity>.value(_FakeCartEntity_0(
          this,
          Invocation.method(
            #getCart,
            [],
          ),
        )),
      ) as _i4.Future<_i2.CartEntity>);
}
