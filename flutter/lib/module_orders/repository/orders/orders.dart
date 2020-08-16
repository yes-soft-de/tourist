import 'dart:convert';

import 'package:inject/inject.dart';
import 'package:tourists/consts/urls.dart';
import 'package:tourists/module_forms/user_orders_module/response/order/order_response.dart';
import 'package:tourists/module_network/http_client/http_client.dart';

@provide
class OrdersRepository {
  final HttpClient _httpClient;

  OrdersRepository(this._httpClient);

  Future<OrderResponse> getOrders(String uid) async {
    String response = await _httpClient.get(Urls.orderGuide + "/" + uid);
    if (response != null) {
      return OrderResponse.fromJson(jsonDecode(response));
    }
    return null;
  }

  Future<OrderResponse> getGeneralOrderList(String guideId) async {
    String response = await _httpClient.get(Urls.orderLookup + '/' + guideId);
    if (response == null) {
      return null;
    } else {
      return OrderResponse.fromJson(jsonDecode(response));
    }
  }
}