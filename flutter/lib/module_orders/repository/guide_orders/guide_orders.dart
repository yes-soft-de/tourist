import 'package:firebase_auth/firebase_auth.dart';
import 'package:inject/inject.dart';
import 'package:tourists/consts/urls.dart';
import 'package:tourists/module_forms/user_orders_module/response/order/order_response.dart';
import 'package:tourists/module_network/http_client/http_client.dart';
import 'package:tourists/module_orders/model/order/order_model.dart';
import 'package:tourists/module_orders/response/update_order_response.dart';

@provide
class GuideOrdersRepository {
  final HttpClient _httpClient;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  GuideOrdersRepository(this._httpClient);

  Future<OrderResponse> getAvailableOrders() async {
    FirebaseUser guideUser = await _auth.currentUser();
    String guideId = guideUser.uid;

    Map response = await _httpClient.get(Urls.orderLookup + '/$guideId');

    if (response == null) {
      return null;
    }

    return OrderResponse.fromJson(response);
  }

  Future<UpdateOrderResponse> updateOrder(OrderModel model) async {
    Map response = await _httpClient.put(Urls.updateOrder, model.toJson());

    if (response == null) {
      return null;
    }

    return UpdateOrderResponse.fromJson(response);
  }

  Future<UpdateOrderResponse> updateAvailableOrder(OrderModel model) async {
    Map response = await _httpClient.post(Urls.acceptOrder, model.toJson());
    if (response == null) return null;
    return UpdateOrderResponse.fromJson(response);
  }

  Future<OrderResponse> getGuideOrders(String guideUserId) async {
    Map response = await _httpClient.get(Urls.guideOrders + '/$guideUserId');

    if (response == null) {
      return null;
    }

    return OrderResponse.fromJson(response);
  }
}
