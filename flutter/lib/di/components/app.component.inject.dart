import 'app.component.dart' as _i1;
import '../../utils/logger/logger.dart' as _i2;
import '../../module_network/http_client/http_client.dart' as _i3;
import 'dart:async' as _i4;
import '../../main.dart' as _i5;
import '../../module_home/home_module.dart' as _i6;
import '../../module_home/ui/screens/guide_home/guide_home.dart' as _i7;
import '../../module_orders/ui/screen/orders_list/order_list_screen.dart'
    as _i8;
import '../../module_orders/bloc/orders_list_bloc.dart' as _i9;
import '../../module_orders/service/orders/orders_service.dart' as _i10;
import '../../module_orders/manager/orders/orders_manager.dart' as _i11;
import '../../module_orders/repository/orders/orders.dart' as _i12;
import '../../module_guide/service/guide_list/guide_list.dart' as _i13;
import '../../module_guide/manager/guides_manager/guides_manager.dart' as _i14;
import '../../module_guide/repository/guides/guide_repository.dart' as _i15;
import '../../module_home/ui/screens/home/home.dart' as _i16;
import '../../module_persistence/sharedpref/shared_preferences_helper.dart'
    as _i17;
import '../../module_chat/chat_module.dart' as _i18;
import '../../module_chat/ui/screens/chat_page/chat_page.dart' as _i19;
import '../../module_chat/bloc/chat_page/chat_page.bloc.dart' as _i20;
import '../../module_chat/service/chat/char_service.dart' as _i21;
import '../../module_chat/manager/chat/chat_manager.dart' as _i22;
import '../../module_chat/repository/chat/chat_repository.dart' as _i23;

class AppComponent$Injector implements _i1.AppComponent {
  AppComponent$Injector._();

  _i2.Logger _singletonLogger;

  _i3.HttpClient _singletonHttpClient;

  static _i4.Future<_i1.AppComponent> create() async {
    final injector = AppComponent$Injector._();

    return injector;
  }

  _i5.MyApp _createMyApp() => _i5.MyApp(null, _createHomeModule(),
      _createChatModule(), null, null, _createSharedPreferencesHelper());
  _i6.HomeModule _createHomeModule() =>
      _i6.HomeModule(_createGuideHomeScreen(), _createHomeScreen());
  _i7.GuideHomeScreen _createGuideHomeScreen() =>
      _i7.GuideHomeScreen(_createOrdersListScreen(), null);
  _i8.OrdersListScreen _createOrdersListScreen() =>
      _i8.OrdersListScreen(_createOrdersListBloc());
  _i9.OrdersListBloc _createOrdersListBloc() =>
      _i9.OrdersListBloc(_createOrdersService());
  _i10.OrdersService _createOrdersService() =>
      _i10.OrdersService(_createOrdersManager(), _createGuideListService());
  _i11.OrdersManager _createOrdersManager() =>
      _i11.OrdersManager(_createOrdersRepository());
  _i12.OrdersRepository _createOrdersRepository() =>
      _i12.OrdersRepository(_createHttpClient());
  _i3.HttpClient _createHttpClient() =>
      _singletonHttpClient ??= _i3.HttpClient(_createLogger());
  _i2.Logger _createLogger() => _singletonLogger ??= _i2.Logger();
  _i13.GuideListService _createGuideListService() =>
      _i13.GuideListService(_createGuidesManager());
  _i14.GuidesManager _createGuidesManager() =>
      _i14.GuidesManager(_createGuidesRepository());
  _i15.GuidesRepository _createGuidesRepository() =>
      _i15.GuidesRepository(_createHttpClient());
  _i16.HomeScreen _createHomeScreen() =>
      _i16.HomeScreen(null, null, null, _createSharedPreferencesHelper());
  _i17.SharedPreferencesHelper _createSharedPreferencesHelper() =>
      _i17.SharedPreferencesHelper();
  _i18.ChatModule _createChatModule() => _i18.ChatModule(_createChatPage());
  _i19.ChatPage _createChatPage() =>
      _i19.ChatPage(_createChatPageBloc(), _createSharedPreferencesHelper());
  _i20.ChatPageBloc _createChatPageBloc() =>
      _i20.ChatPageBloc(_createChatService());
  _i21.ChatService _createChatService() =>
      _i21.ChatService(_createChatManager(), _createSharedPreferencesHelper());
  _i22.ChatManager _createChatManager() =>
      _i22.ChatManager(_createChatRepository());
  _i23.ChatRepository _createChatRepository() => _i23.ChatRepository();
  @override
  _i5.MyApp get app => _createMyApp();
}
