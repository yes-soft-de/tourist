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
  SharedPreferencesHelper _preferencesHelper;

  OrdersService(this._ordersManager, this._preferencesHelper, this._guideListService);

  Future<List<OrderModel>> getOrders() async {
    String uid = await _preferencesHelper.getUserUID();

    if (uid == null) {
      return null;
    }

    OrderResponse orderResponse = await _ordersManager.getOrders(uid);
    List<GuideListItemModel> guides = await _guideListService.getAllGuides();

    Map<String, GuideListItemModel> guidesMap = {};
    guides.forEach((guide) {
      guidesMap[guide.user] = guide;
    });

    if (orderResponse == null) {
      return null;
    }

    orderResponse.orderList.forEach((order) {
      if (order.guidUserID != null) {
        // Get the info from the list
        order.guideInfo = guidesMap[order.guidUserID];
      }
    });

    return orderResponse.orderList;
  }

}