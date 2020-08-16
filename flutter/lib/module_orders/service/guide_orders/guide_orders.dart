import 'package:inject/inject.dart';
import 'package:tourists/module_forms/user_orders_module/response/order/order_response.dart';
import 'package:tourists/module_orders/manager/guide_orders/guide_orders.dart';
import 'package:tourists/module_orders/model/order/order_model.dart';
import 'package:uuid/uuid.dart';

@provide
class GuideOrdersService {
  GuideOrdersManager _ordersManager;

  GuideOrdersService(this._ordersManager);

  Future<List<OrderModel>> getAvailableOrders() async {
    OrderResponse response = await _ordersManager.getAvailableOrders();

    if (response == null) {
      return null;
    }

    return response.orderList;
  }

  Future<OrderResponse> acceptOrder(OrderModel orderModel) async {
    orderModel.roomID = new Uuid().v1();
    orderModel.status = 'on-going';

    OrderResponse response = await _ordersManager.startOrder(orderModel);

    if (response == null) {
      return null;
    }

    return response;
  }
}