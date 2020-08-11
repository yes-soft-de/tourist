import 'package:inject/inject.dart';
import 'package:tourists/repositories/orders/orders.dart';
import 'package:tourists/responses/order/order_response.dart';

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