import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class UserPendingOrders {
  UserPendingOrders();

  final PublishSubject<Map<String, dynamic>> _stateStream =
      new PublishSubject();
  Stream<Map<String, dynamic>> get stateStream => _stateStream.stream;

  void dispose() {
    _stateStream.close();
  }
}
