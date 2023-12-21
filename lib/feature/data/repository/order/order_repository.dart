import 'package:seo_web/feature/data/data_source/remote_data_source/order/i_order_data_source.dart';
import 'package:seo_web/feature/domain/repository/order/i_order_repository.dart';

class OrderRepository implements IOrderRepository {
  final IOrderDataSource _dataSource;

  const OrderRepository({required IOrderDataSource dataSource})
      : _dataSource = dataSource;

  @override
  Future<String> createOrder() async => await _dataSource.createOrder();
}
