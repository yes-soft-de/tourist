import 'package:firebase_auth/firebase_auth.dart';
import 'package:inject/inject.dart';
import 'package:tourists/module_auth/enums/user_type.dart';
import 'package:tourists/module_auth/service/auth_service/auth_service.dart';
import 'package:tourists/module_forms/user_orders_module/response/order/order_response.dart';
import 'package:tourists/module_guide/model/guide_list_item/guide_list_item.dart';
import 'package:tourists/module_guide/service/guide_list/guide_list.dart';
import 'package:tourists/module_orders/enum/order_status.dart';
import 'package:tourists/module_orders/manager/orders/orders_manager.dart';
import 'package:tourists/module_orders/model/order/order_model.dart';
import 'package:tourists/module_orders/request/update_order_request.dart';
import 'package:tourists/module_orders/response/update_order_response.dart';
import 'package:uuid/uuid.dart';

@provide
class TouristOrdersService {
  final OrdersManager _ordersManager;
  final GuideListService _guideListService;
  final AuthService _authService;

  TouristOrdersService(
    this._ordersManager,
    this._guideListService,
    this._authService,
  );

  Future<List<OrderModel>> getOrders() async {
    String uid = await _authService.userID;
    if (uid == null) {
      return null;
    }

    UserRole role = await _authService.userRole;

    try {
      if (role == UserRole.ROLE_GUIDE) {
        var orders = await _ordersManager.getGuideOrders(uid);
        return orders.data.map((e) => OrderModel(
          id: e.id,
          touristId: e.touristUserID,
          guideUserID: e.guidUserID,
          language: e.language,
          services: e.services,
          arriveDate: DateTime.fromMillisecondsSinceEpoch(1000 * e.arriveDate.timestamp),
          leaveDate: DateTime.fromMillisecondsSinceEpoch(1000 * e.leaveDate.timestamp),
          date: DateTime.fromMillisecondsSinceEpoch(1000 * e.date.timestamp),
          city: e.city,
          cost: e.cost,
          roomId: e.roomID,
          status: e.status,
        ));
      } else {
        var orders = await _ordersManager.getTouristOrders(uid);
        return orders.data.map((e) => OrderModel(
          id: e.id,
          touristId: e.touristUserID,
          guideUserID: e.guidUserID,
          language: e.language,
          services: e.services,
          arriveDate: DateTime.fromMillisecondsSinceEpoch(1000 * e.arriveDate.timestamp),
          leaveDate: DateTime.fromMillisecondsSinceEpoch(1000 * e.leaveDate.timestamp),
          date: DateTime.fromMillisecondsSinceEpoch(1000 * e.date.timestamp),
          city: e.city,
          cost: e.cost,
          roomId: e.roomID,
          status: e.status,
        )).toList();
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<OrderModel>> getGeneralOrders() async {
    String uid = await _authService.userID;

    OrderListResponse response = await _ordersManager.getGeneralOrderList(uid);

    if (response != null) {
      return response.data.map((e) => OrderModel(
        id: e.id,
        touristId: e.touristUserID,
        guideUserID: e.guidUserID,
        language: e.language,
        services: e.services,
        arriveDate: DateTime.fromMillisecondsSinceEpoch(1000 * e.arriveDate.timestamp),
        leaveDate: DateTime.fromMillisecondsSinceEpoch(1000 * e.leaveDate.timestamp),
        date: DateTime.fromMillisecondsSinceEpoch(1000 * e.date.timestamp),
        city: e.city,
        cost: e.cost,
        roomId: e.roomID,
        status: e.status,
      )).toList();
    }
    return null;
  }

  Future<UpdateOrderResponse> payOrder(OrderModel orderModel) async {
    orderModel.status = 'onGoing';

    UpdateOrderResponse response = await _ordersManager.updateOrder(_toUpdateOrderRequest(orderModel));

    if (response == null) {
      return null;
    }

    return response;
  }

  UpdateOrderRequest _toUpdateOrderRequest(OrderModel orderModel) {
    return UpdateOrderRequest(
        status: 'onGoing',
        services: orderModel.services,
        touristUserID: orderModel.touristId,
        guidUserID: FirebaseAuth.instance.currentUser.uid,
        cost: int.tryParse(orderModel.cost),
        city: orderModel.city,
        language: orderModel.language,
        date: DateTime.now().toIso8601String(),
        arriveDate: orderModel.arriveDate.toIso8601String(),
        leaveDate: orderModel.leaveDate.toIso8601String(),
        id: orderModel.id.toString()
    );
  }
}
