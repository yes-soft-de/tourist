import 'package:inject/inject.dart';
import 'package:tourists/module_forms/user_orders_module/response/order/order_response.dart';
import 'package:tourists/module_orders/model/order/order_model.dart';
import 'package:tourists/module_orders/repository/orders/orders.dart';
import 'package:tourists/module_orders/response/update_order_response.dart';

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

  Future<UpdateOrderResponse> updateOrder(OrderModel orderModel) {
    return _ordersRepository.updateOrder(orderModel);
  }

  Future<UpdateOrderResponse> updateAvailableOrder(OrderModel orderModel) {
    return _ordersRepository.updateAvailableOrder(orderModel);
  }
}
