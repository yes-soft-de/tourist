import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tourists/services/orders/orders_service.dart';

@provide
class UserPendingOrders {
  OrdersService _ordersService;

  UserPendingOrders(this._ordersService);

  PublishSubject<Map<String, dynamic>> _stateStream = new PublishSubject();
  Stream<Map<String, dynamic>> get stateStream => _stateStream.stream;

  dispose() {
    _stateStream.close();
  }
}