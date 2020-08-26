import 'package:analyzer_plugin/utilities/pair.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tourists/module_orders/model/order/order_model.dart';
import 'package:tourists/module_orders/service/orders/orders_service.dart';
import 'package:uuid/uuid.dart';

@provide
class OrdersListBloc {
  static const STATUS_CODE_INIT = 145;
  static const STATUS_CODE_LOADING = 175;
  static const STATUS_CODE_LOAD_SUCCESS = 155;
  static const STATUS_CODE_LOAD_ERROR = 165;

  final OrdersService _ordersService;

  OrdersListBloc(this._ordersService);

  PublishSubject<Pair<int, List<OrderModel>>> _orderSubject =
      new PublishSubject();

  Stream<Pair<int, List<OrderModel>>> get ordersStream => _orderSubject.stream;

  getOrdersList() {
    _orderSubject.add(Pair(STATUS_CODE_LOADING, null));
    _ordersService.getOrders().then((value) {
      if (value == null) {
        _orderSubject.add(Pair(STATUS_CODE_LOAD_ERROR, null));
      }
      _orderSubject.add(Pair(STATUS_CODE_LOAD_SUCCESS, value));
    });
  }

  payOrder(OrderModel orderModel) {
    _orderSubject.add(Pair(STATUS_CODE_LOADING, null));
    orderModel.roomID = Uuid().v1();
    _ordersService.payOrder(orderModel).then((value) {
      if (value == null) {
        _orderSubject.add(Pair(STATUS_CODE_LOAD_ERROR, null));
      } else {
        this.getOrdersList();
      }
    });
  }

  void dispose() {
    _orderSubject.close();
  }
}
