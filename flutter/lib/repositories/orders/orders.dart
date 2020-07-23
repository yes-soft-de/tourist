import 'dart:convert';

import 'package:inject/inject.dart';
import 'package:tourists/consts/urls.dart';
import 'package:tourists/network/http_client/http_client.dart';
import 'package:tourists/responses/order/order_response.dart';

@provide
class OrdersRepository {
  final HttpClient _httpClient;

  OrdersRepository(this._httpClient);

  Future<OrderResponse> getOrders(String uid) async {
    String response = await _httpClient.get(Urls.orderGuide);
    if (response != null) {
      return OrderResponse.fromJson(jsonDecode(response));
    }
    return null;
  }
}