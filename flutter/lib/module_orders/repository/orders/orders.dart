import 'package:firebase_auth/firebase_auth.dart';
import 'package:inject/inject.dart';
import 'package:tourists/consts/urls.dart';
import 'package:tourists/module_forms/user_orders_module/response/order/order_response.dart';
import 'package:tourists/module_network/http_client/http_client.dart';
import 'package:tourists/module_orders/model/order/order_model.dart';
import 'package:tourists/module_orders/request/update_order_request.dart';
import 'package:tourists/module_orders/response/update_order_response.dart';

@provide
class OrdersRepository {
  final HttpClient _httpClient;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  OrdersRepository(this._httpClient);

  Future<OrderListResponse> getOrders(String uid) async {
    Map response = await _httpClient.get(Urls.orderGuide + '/' + uid);
    if (response != null) {
      return OrderListResponse.fromJson(response);
    }
    return null;
  }

  Future<OrderListResponse> getTouristOrders(String uid) async {
    Map response = await _httpClient.get(Urls.touristOrders + '/' + uid);
    if (response != null) {
      return OrderListResponse.fromJson(response);
    }
    return null;
  }

  Future<OrderListResponse> getGeneralOrderList(String guideId) async {
    Map response = await _httpClient.get(Urls.orderLookup + '/' + guideId);
    if (response == null) {
      return null;
    } else {
      return OrderListResponse.fromJson(response);
    }
  }

  Future<OrderListResponse> getAvailableOrders() async {
    User guideUser = await _auth.currentUser;
    String guideId = guideUser.uid;

    Map response = await _httpClient.get(Urls.orderLookup + '/$guideId');

    if (response == null) {
      return null;
    }

    return OrderListResponse.fromJson(response);
  }

  Future<UpdateOrderResponse> updateOrder(UpdateOrderRequest model) async {
    Map response = await _httpClient.put(Urls.updateOrder, model.toJson());

    if (response == null) {
      return null;
    }

    return UpdateOrderResponse.fromJson(response);
  }

  Future<UpdateOrderResponse> updateAvailableOrder(UpdateOrderRequest model) async {
    Map response = await _httpClient.post(Urls.acceptOrder, model.toJson());
    if (response == null) return null;
    return UpdateOrderResponse.fromJson(response);
  }
}
