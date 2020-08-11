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
import '../../module_home/ui/screens/home/subscreens/main/main_home.dart'
    as _i17;
import '../../module_home/bloc/main_home/main_home_bloc.dart' as _i18;
import '../../module_locations/service/location_list/location_list_service.dart'
    as _i19;
import '../../module_locations/manager/location_list/location_list_manager.dart'
    as _i20;
import '../../module_locations/repository/location_list/location_list_repository.dart'
    as _i21;
import '../../module_locations/ui/screens/location_details/location_details.dart'
    as _i22;
import '../../module_locations/bloc/location_details/location_details_bloc.dart'
    as _i23;
import '../../module_locations/service/location_details/location_details_service.dart'
    as _i24;
import '../../module_locations/manager/location_details/location_details.dart'
    as _i25;
import '../../module_locations/repository/location_details/location_details_repository.dart'
    as _i26;
import '../../module_comment/manager/rate/rate_manager.dart' as _i27;
import '../../module_comment/repository/rating/rating_repository.dart' as _i28;
import '../../module_persistence/sharedpref/shared_preferences_helper.dart'
    as _i29;
import '../../module_comment/manager/comment/comment_service.dart' as _i30;
import '../../module_comment/repository/comment/comment_repository.dart'
    as _i31;
import '../../module_chat/chat_module.dart' as _i32;
import '../../module_chat/ui/screens/chat_page/chat_page.dart' as _i33;
import '../../module_chat/bloc/chat_page/chat_page.bloc.dart' as _i34;
import '../../module_chat/service/chat/char_service.dart' as _i35;
import '../../module_chat/manager/chat/chat_manager.dart' as _i36;
import '../../module_chat/repository/chat/chat_repository.dart' as _i37;

class AppComponent$Injector implements _i1.AppComponent {
  AppComponent$Injector._();

  _i2.Logger _singletonLogger;

  _i3.HttpClient _singletonHttpClient;

  static _i4.Future<_i1.AppComponent> create() async {
    final injector = AppComponent$Injector._();

    return injector;
  }

  _i5.MyApp _createMyApp() => _i5.MyApp(
      null, _createHomeModule(), _createChatModule(), null, null, null);
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
  _i16.HomeScreen _createHomeScreen() => _i16.HomeScreen(
      _createMainHomeSubScreen(), null, null, _createSharedPreferencesHelper());
  _i17.MainHomeSubScreen _createMainHomeSubScreen() => _i17.MainHomeSubScreen(
      _createMainHomeBloc(), _createLocationDetailsScreen());
  _i18.MainHomeBloc _createMainHomeBloc() =>
      _i18.MainHomeBloc(_createLocationListService(), _createLogger());
  _i19.LocationListService _createLocationListService() =>
      _i19.LocationListService(_createLocationListManager());
  _i20.LocationListManager _createLocationListManager() =>
      _i20.LocationListManager(_createLocationListRepository());
  _i21.LocationListRepository _createLocationListRepository() =>
      _i21.LocationListRepository(_createHttpClient());
  _i22.LocationDetailsScreen _createLocationDetailsScreen() =>
      _i22.LocationDetailsScreen(_createLocationDetailsBloc());
  _i23.LocationDetailsBloc _createLocationDetailsBloc() =>
      _i23.LocationDetailsBloc(_createLocationDetailsService(),
          _createSharedPreferencesHelper(), _createCommentManager());
  _i24.LocationDetailsService _createLocationDetailsService() =>
      _i24.LocationDetailsService(
          _createLocationDetailsManager(),
          _createGuidesManager(),
          _createRatingManager(),
          _createSharedPreferencesHelper());
  _i25.LocationDetailsManager _createLocationDetailsManager() =>
      _i25.LocationDetailsManager(_createLocationDetailsRepository());
  _i26.LocationDetailsRepository _createLocationDetailsRepository() =>
      _i26.LocationDetailsRepository(_createHttpClient());
  _i27.RatingManager _createRatingManager() =>
      _i27.RatingManager(_createRatingRepository());
  _i28.RatingRepository _createRatingRepository() =>
      _i28.RatingRepository(_createHttpClient());
  _i29.SharedPreferencesHelper _createSharedPreferencesHelper() =>
      _i29.SharedPreferencesHelper();
  _i30.CommentManager _createCommentManager() =>
      _i30.CommentManager(_createCommentRepository());
  _i31.CommentRepository _createCommentRepository() =>
      _i31.CommentRepository(_createHttpClient());
  _i32.ChatModule _createChatModule() => _i32.ChatModule(_createChatPage());
  _i33.ChatPage _createChatPage() =>
      _i33.ChatPage(_createChatPageBloc(), _createSharedPreferencesHelper());
  _i34.ChatPageBloc _createChatPageBloc() =>
      _i34.ChatPageBloc(_createChatService());
  _i35.ChatService _createChatService() =>
      _i35.ChatService(_createChatManager(), _createSharedPreferencesHelper());
  _i36.ChatManager _createChatManager() =>
      _i36.ChatManager(_createChatRepository());
  _i37.ChatRepository _createChatRepository() => _i37.ChatRepository();
  @override
  _i5.MyApp get app => _createMyApp();
}
