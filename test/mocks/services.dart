import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:seo_web/feature/data/services/auth/auth_service.dart';
import 'package:seo_web/feature/data/services/cart/cart_service.dart';
import 'package:seo_web/feature/data/services/favorites/favorites_service.dart';
import 'package:seo_web/feature/data/services/order/order_service.dart';
import 'package:seo_web/feature/data/services/products/products_service.dart';

@GenerateMocks([
  AuthService,
  OrderService,
  CartService,
  ProductsService,
  FavoritesService,
  Dio,
])
import 'services.mocks.dart';
