import 'package:firebase_auth/firebase_auth.dart';
import 'package:inject/inject.dart';
import 'package:tourists/managers/orders/orders_manager.dart';
import 'package:tourists/models/guide_list_item/guide_list_item.dart';
import 'package:tourists/models/order/order_model.dart';
import 'package:tourists/persistence/sharedpref/shared_preferences_helper.dart';
import 'package:tourists/responses/order/order_response.dart';
import 'package:tourists/services/guide_list/guide_list.dart';

@provide
class OrdersService {
  OrdersManager _ordersManager;
  GuideListService _guideListService;
  final FirebaseAuth _authService = FirebaseAuth.instance;

  OrdersService(this._ordersManager, this._guideListService);

  Future<List<OrderModel>> getOrders() async {
    FirebaseUser user = await _authService.currentUser();
    if (user == null) {
      return null;
    }

    String uid = user.uid;

    OrderResponse orderResponse = await _ordersManager.getOrders(uid);
    List<GuideListItemModel> allGuides = await _guideListService.getAllGuides();

    return formatOrders(allGuides, orderResponse);
  }

  Future<List<OrderModel>> getGeneralOrders() async {
    FirebaseUser user = await _authService.currentUser();

    OrderResponse response = await _ordersManager.getGeneralOrderList(user.uid);

    if (response != null) {
      return response.orderList;
    }
    return null;
  }

  List<OrderModel> formatOrders(
      List<GuideListItemModel> allGuides, OrderResponse orderResponse) {
    Map<String, GuideListItemModel> guidesMap = {};
    allGuides.forEach((guide) {
      guidesMap[guide.user] = guide;
    });

    orderResponse.orderList.forEach((order) {
      if (order.guidUserID != null) {
        // Get the info from the list
        order.guideInfo = guidesMap[order.guidUserID];
      }
    });

    return orderResponse.orderList;
  }
}
