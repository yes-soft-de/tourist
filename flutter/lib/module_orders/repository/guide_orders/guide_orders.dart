import 'dart:convert';

import 'package:inject/inject.dart';
import 'package:tourists/consts/urls.dart';
import 'package:tourists/module_forms/user_orders_module/response/order/order_response.dart';
import 'package:tourists/module_guide/response/guide_response/guides_response.dart';
import 'package:tourists/module_network/http_client/http_client.dart';
import 'package:tourists/module_orders/model/order/order_model.dart';

@provide
class GuideOrdersRepository {
  HttpClient _httpClient;

  GuideOrdersRepository(this._httpClient);

  Future<OrderResponse> getAvailableOrders() async {
    String response = await _httpClient.get(Urls.orderLookup);

    if (response == null) {
      return null;
    }

    return OrderResponse.fromJson(jsonDecode(response));
  }

  Future<OrderResponse> startOrder(OrderModel model) async {
    String response = await _httpClient.put(Urls.updateOrder, model.toJson());

    if (response == null) {
      return null;
    }

    return OrderResponse.fromJson(jsonDecode(response));
  }
}