import 'package:mockito/annotations.dart';
import 'package:seo_web/feature/data/data_source/local_data_source/local_data_source.dart';
import 'package:seo_web/feature/data/data_source/remote_data_source/auth/auth_data_source.dart';
import 'package:seo_web/feature/data/data_source/remote_data_source/cart/cart_data_source.dart';
import 'package:seo_web/feature/data/data_source/remote_data_source/favorites/favorites_data_source.dart';
import 'package:seo_web/feature/data/data_source/remote_data_source/order/order_data_source.dart';
import 'package:seo_web/feature/data/data_source/remote_data_source/products/products_data_source.dart';

@GenerateMocks([
  AuthDataSource,
  LocalAuthDataSource,
  CartDataSource,
  FavoritesDataSource,
  ProductsDataSource,
  OrderDataSource,
])
import 'data_sources.mocks.dart';
