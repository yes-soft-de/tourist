import 'package:inject/inject.dart';
import 'package:tourists/module_forms/user_orders_module/response/order/order_response.dart';
import 'package:tourists/module_orders/model/order/order_model.dart';
import 'package:tourists/module_orders/repository/guide_orders/guide_orders.dart';

@provide
class GuideOrdersManager {
  final GuideOrdersRepository _repository;
  GuideOrdersManager(this._repository);

  Future<OrderResponse> getAvailableOrders() {
    return _repository.getAvailableOrders();
  }

  Future<OrderResponse> startOrder(OrderModel orderModel) {
    return _repository.startOrder(orderModel);
  }
}