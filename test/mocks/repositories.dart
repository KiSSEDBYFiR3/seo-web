// ignore_for_file: unused_import

import 'package:mockito/annotations.dart';
import 'package:seo_web/feature/data/repository/auth/auth_repository.dart';
import 'package:seo_web/feature/data/repository/cart/cart_repository.dart';
import 'package:seo_web/feature/data/repository/favorites/favorites_repository.dart';
import 'package:seo_web/feature/data/repository/order/order_repository.dart';
import 'package:seo_web/feature/data/repository/products/products_repository.dart';

@GenerateMocks([
  AuthRepository,
  ProductsRepository,
  FavoritesRepository,
  OrderRepository,
  CartRepository,
])
import 'repositories.mocks.dart';
