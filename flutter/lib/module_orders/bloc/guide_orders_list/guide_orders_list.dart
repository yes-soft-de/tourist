import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tourists/module_orders/model/order/order_model.dart';
import 'package:tourists/module_orders/service/guide_orders/guide_orders.dart';

@provide
class GuideOrdersListBloc {
  static const STATUS_CODE_INIT = -1;
  static const STATUS_CODE_LOAD_ERROR = 158;
  static const STATUS_CODE_LOAD_SUCCESS = 168;
  static const STATUS_CODE_LOADING = 178;
  static const STATUS_CODE_ORDER_UPDATED = 188;

  static const String KEY_STATUS = 'status';
  static const String KEY_PAYLOAD = 'payload';

  GuideOrdersService _ordersService;

  GuideOrdersListBloc(this._ordersService);

  PublishSubject<Map<String, dynamic>> _stateSubject = new PublishSubject();

  Stream<Map<String, dynamic>> get stateStream => _stateSubject.stream;

  getAvailableOrders() {
    _stateSubject.add({KEY_STATUS: STATUS_CODE_LOADING});
    _ordersService.getAllPossibleOrders().then((ordersList) {
      if (ordersList != null) {
        _stateSubject.add(
            {KEY_STATUS: STATUS_CODE_LOAD_SUCCESS, KEY_PAYLOAD: ordersList});
      } else {
        _stateSubject.add({KEY_STATUS: STATUS_CODE_LOAD_ERROR});
      }
    });
  }

  acceptOrder(OrderModel orderModel) {
    _stateSubject.add({KEY_STATUS: STATUS_CODE_LOADING});
    _ordersService.acceptOrder(orderModel).then((value) {
      if (value == null) {
        _stateSubject.add({KEY_STATUS: STATUS_CODE_LOAD_ERROR});
      } else {
        this.getAvailableOrders();
      }
    });
  }

  acceptAvailableOrder(OrderModel orderModel) {
    _stateSubject.add({KEY_STATUS: STATUS_CODE_LOADING});
    _ordersService.acceptAvailableOrder(orderModel).then((value) {
      if (value == null) {
        _stateSubject.add({KEY_STATUS: STATUS_CODE_LOAD_ERROR});
      } else {
        this.getAvailableOrders();
      }
    });
  }

  payOrder(OrderModel orderModel) {
    _stateSubject.add({KEY_STATUS: STATUS_CODE_LOADING});
    _ordersService.payOrder(orderModel).then((value) {
      if (value == null) {
        _stateSubject.add({KEY_STATUS: STATUS_CODE_LOAD_ERROR});
      } else {
        this.getAvailableOrders();
      }
    });
  }

  payAvailableOrder(OrderModel orderModel) {
    _stateSubject.add({KEY_STATUS: STATUS_CODE_LOADING});
    _ordersService.payAvailableOrder(orderModel).then((value) {
      if (value == null) {
        _stateSubject.add({KEY_STATUS: STATUS_CODE_LOAD_ERROR});
      } else {
        this.getAvailableOrders();
      }
    });
  }

  dispose() {
    _stateSubject.close();
  }
}
