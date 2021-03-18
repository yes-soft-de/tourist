import 'package:firebase_auth/firebase_auth.dart';
import 'package:inject/inject.dart';
import 'package:tourists/module_auth/enums/user_type.dart';
import 'package:tourists/module_auth/service/auth_service/auth_service.dart';
import 'package:tourists/module_forms/user_orders_module/response/order/order_response.dart';
import 'package:tourists/module_guide/model/guide_list_item/guide_list_item.dart';
import 'package:tourists/module_guide/service/guide_list/guide_list.dart';
import 'package:tourists/module_orders/manager/orders/orders_manager.dart';
import 'package:tourists/module_orders/model/order/order_model.dart';
import 'package:tourists/module_orders/response/update_order_response.dart';

@provide
class OrdersService {
  final OrdersManager _ordersManager;
  final GuideListService _guideListService;
  final AuthService _authService;

  OrdersService(this._ordersManager, this._guideListService,
      this._authService,);

  Future<List<OrderModel>> getOrders() async {
    String uid = await _authService.userID;
    if (uid == null) {
      return null;
    }

    UserRole role = await _authService.userRole;

    try {
      OrderResponse orderResponse;
      if (role == UserRole.ROLE_GUIDE) {
        var response = await Future.wait([
          _ordersManager.getOrders(uid),
          _guideListService.getAllGuides(),
        ]);
        return formatOrders(response[1], response[0]);
      } else {
        var response = await Future.wait([
          _ordersManager.getTouristOrders(uid),
          _guideListService.getAllGuides(),
        ]);
        return formatOrders(response[1], response[0]);
      }

    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<OrderModel>> getGeneralOrders() async {
    String uid = await _authService.userID;

    OrderResponse response = await _ordersManager.getGeneralOrderList(uid);

    if (response != null) {
      return response.orderList;
    }
    return null;
  }

  List<OrderModel> formatOrders(List<GuideListItemModel> allGuides,
      OrderResponse orderResponse,) {
    orderResponse ??= OrderResponse(orderList: []);
    Map<String, GuideListItemModel> guidesMap = {};
    allGuides.forEach((guide) {
      guidesMap[guide.userID] = guide;
    });

    orderResponse.orderList.forEach((order) {
      if (order.guidUserID != null) {
        // Get the info from the list
        order.guideInfo = guidesMap[order.guidUserID];
      }
    });

    return orderResponse.orderList;
  }

  Future<UpdateOrderResponse> payOrder(OrderModel orderModel) async {
    orderModel.status = 'onGoing';

    UpdateOrderResponse response = await _ordersManager.updateOrder(orderModel);

    if (response == null) {
      return null;
    }

    return response;
  }
}
