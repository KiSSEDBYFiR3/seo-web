import 'package:seo_web/feature/data/data_source/remote_data_source/cart/i_cart_data_source.dart';
import 'package:seo_web/feature/data/model/cart/mapper/cart_mapper.dart';
import 'package:seo_web/feature/domain/entity/cart_entity.dart';
import 'package:seo_web/feature/domain/repository/cart/i_cart_repository.dart';

class CartRepository implements ICartRepository {
  final ICartDataSource _dataSource;
  const CartRepository({required ICartDataSource dataSource})
      : _dataSource = dataSource;

  @override
  Future<CartEntity> addToCart({required int id}) async => dtoToCartMapper(
        await _dataSource.addToCart(id: id),
      );

  @override
  Future<CartEntity> deleteFromCart({required int id}) async => dtoToCartMapper(
        await _dataSource.deleteFromCart(id: id),
      );

  @override
  Future<CartEntity> getCart() async => dtoToCartMapper(
        await _dataSource.getCart(),
      );
}
