import 'package:seo_web/feature/data/data_source/remote_data_source/order/i_order_data_source.dart';
import 'package:seo_web/feature/data/services/order/order_service.dart';

class OrderDataSource implements IOrderDataSource {
  final OrderService _orderService;

  const OrderDataSource({
    required OrderService orderService,
  }) : _orderService = orderService;

  @override
  Future<String> createOrder() async => await _orderService.createOrder();
}
