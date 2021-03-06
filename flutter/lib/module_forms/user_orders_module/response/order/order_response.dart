import 'package:tourists/module_orders/model/order/order_model.dart';

class OrderResponse {
  String statusCode;
  String msg;
  List<OrderModel> orderList;

  OrderResponse({this.statusCode, this.msg, this.orderList});

  OrderResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    if (json['data'] != null) {
      orderList = <OrderModel>[];
      json['data'].forEach((v) {
        orderList.add(new OrderModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status_code'] = this.statusCode;
    data['msg'] = this.msg;
    if (this.orderList != null) {
      data['data'] = this.orderList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
