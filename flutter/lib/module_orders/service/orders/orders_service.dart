import 'package:firebase_auth/firebase_auth.dart';
import 'package:inject/inject.dart';
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
  final FirebaseAuth _authService = FirebaseAuth.instance;

  OrdersService(this._ordersManager, this._guideListService);

  Future<List<OrderModel>> getOrders() async {
    User user = await _authService.currentUser;
    if (user == null) {
      return null;
    }

    String uid = user.uid;

    try {
      OrderResponse orderResponse = await _ordersManager.getOrders(uid);
      List<GuideListItemModel> allGuides = await _guideListService.getAllGuides();
      return formatOrders(allGuides, orderResponse);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<OrderModel>> getGeneralOrders() async {
    User user = await _authService.currentUser;

    OrderResponse response = await _ordersManager.getGeneralOrderList(user.uid);

    if (response != null) {
      return response.orderList;
    }
    return null;
  }

  List<OrderModel> formatOrders(
    List<GuideListItemModel> allGuides,
    OrderResponse orderResponse,
  ) {
    print('Guide List: ${allGuides.length} & ordersList ${orderResponse}');
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
