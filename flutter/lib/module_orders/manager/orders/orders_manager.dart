import 'package:inject/inject.dart';
import 'package:tourists/module_forms/user_orders_module/response/order/order_response.dart';
import 'package:tourists/module_orders/repository/orders/orders.dart';

@provide
class OrdersManager {
  OrdersRepository _ordersRepository;

  OrdersManager(this._ordersRepository);

  Future<OrderResponse> getOrders(String userId) {
    return _ordersRepository.getOrders(userId);
  }

  Future<OrderResponse> getGeneralOrderList(String guideId) {
    return _ordersRepository.getGeneralOrderList(guideId);
  }
}