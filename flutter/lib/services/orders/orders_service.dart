import 'package:inject/inject.dart';
import 'package:tourists/managers/orders/orders_manager.dart';
import 'package:tourists/persistence/sharedpref/shared_preferences_helper.dart';
import 'package:tourists/responses/order/order_response.dart';

@provide
class OrdersService {
  OrdersManager _ordersManager;
  SharedPreferencesHelper _preferencesHelper;

  OrdersService(this._ordersManager);

  Future<OrderResponse> getOrders() async {
    String uid = await _preferencesHelper.getUserUID();
    return _ordersManager.getOrders(uid);
  }

}