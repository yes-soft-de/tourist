import 'package:firebase_auth/firebase_auth.dart';
import 'package:inject/inject.dart';
import 'package:tourists/module_forms/user_orders_module/response/order/order_response.dart';
import 'package:tourists/module_forms/user_orders_module/service/request_guide/request_guide.service.dart';
import 'package:tourists/module_orders/manager/guide_orders/guide_orders.dart';
import 'package:tourists/module_orders/model/order/order_model.dart';
import 'package:tourists/module_orders/response/update_order_response.dart';
import 'package:uuid/uuid.dart';

@provide
class GuideOrdersService {
  GuideOrdersManager _ordersManager;
  RequestGuideService _requestGuideService;
  FirebaseAuth _auth = FirebaseAuth.instance;

  GuideOrdersService(this._ordersManager, this._requestGuideService);

  Future<List<OrderModel>> getAvailableOrders() async {
    OrderResponse response = await _ordersManager.getAvailableOrders();

    if (response == null) {
      return [];
    }

    return response.orderList;
  }

  Future<List<OrderModel>> getGuideId() async {
    FirebaseUser user = await _auth.currentUser();
    String userId = user.uid;

    OrderResponse response = await _ordersManager.getGuideOrders(userId);

    if (response == null) {
      return [];
    }

    return response.orderList;
  }

  Future<List<OrderModel>> getAllPossibleOrders() async {
    List<OrderModel> locationOrders = await getAvailableOrders();
    List<OrderModel> guideOrders = await getGuideId();

    List<OrderModel> allOrders = [];
    allOrders.addAll(locationOrders);
    allOrders.addAll(guideOrders);

    return allOrders;
  }

  Future<UpdateOrderResponse> acceptOrder(OrderModel orderModel) async {
    orderModel.roomID = new Uuid().v1();
    orderModel.status = 'onGoing';

    UpdateOrderResponse response = await _ordersManager.updateOrder(orderModel);

    if (response == null) {
      return null;
    }

    return response;
  }

  Future<UpdateOrderResponse> acceptAvailableOrder(
      OrderModel orderModel) async {
    orderModel.roomID = new Uuid().v1();
    orderModel.status = 'pendingPayment';

    FirebaseUser user = await _auth.currentUser();
    orderModel.guidUserID = user.uid;

    UpdateOrderResponse response =
        await _ordersManager.updateAvailableOrder(orderModel);

    if (response == null) {
      return null;
    }

    return response;
  }

  Future<UpdateOrderResponse> payOrder(OrderModel orderModel) async {
    orderModel.status = 'onGoing';

    UpdateOrderResponse response = await _ordersManager.updateOrder(orderModel);

    if (response == null) {
      return null;
    }

    return response;
  }

  Future<UpdateOrderResponse> payAvailableOrder(OrderModel orderModel) async {
    orderModel.status = 'onGoing';

    UpdateOrderResponse response = await _ordersManager.updateOrder(orderModel);

    if (response == null) {
      return null;
    }

    return response;
  }

  Future<UpdateOrderResponse> startAvailableOrder(OrderModel orderModel) async {
    orderModel.status = 'onGoing';

    UpdateOrderResponse response = await _ordersManager.updateOrder(orderModel);

    if (response == null) {
      return null;
    }

    return response;
  }
}
