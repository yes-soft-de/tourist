import 'package:tourists/models/order/order_model.dart';

class OrderResponse {
  String statusCode;
  String msg;
  OrderModel orderModel;

  OrderResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    orderModel = OrderModel.fromJson(json);
  }
}