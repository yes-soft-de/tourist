import 'app.component.dart' as _i1;
import '../../utils/logger/logger.dart' as _i2;
import '../../module_network/http_client/http_client.dart' as _i3;
import '../../module_locations/bloc/location_list/location_list_bloc.dart'
    as _i4;
import '../../utils/auth_guard/auth_gard.dart' as _i5;
import 'dart:async' as _i6;
import '../../main.dart' as _i7;
import '../../module_authorization/authprization_module.dart' as _i8;
import '../../module_authorization/user_authorization_module/user_auth.dart'
    as _i9;
import '../../module_authorization/guide_authorization_module/guide_authorization_module.dart'
    as _i10;
import '../../module_authorization/guide_authorization_module/ui/screens/guide_profile/guide_profile.dart'
    as _i11;
import '../../module_locations/service/location_list/location_list_service.dart'
    as _i12;
import '../../module_locations/manager/location_list/location_list_manager.dart'
    as _i13;
import '../../module_locations/repository/location_list/location_list_repository.dart'
    as _i14;
import '../../module_authorization/guide_authorization_module/bloc/guide_register/guide_register.dart'
    as _i15;
import '../../module_authorization/guide_authorization_module/service/guide_register/guide_register.dart'
    as _i16;
import '../../module_authorization/guide_authorization_module/manager/guide_register/guide_register.dart'
    as _i17;
import '../../module_authorization/guide_authorization_module/repository/guide_register/guide_register.dart'
    as _i18;
import '../../module_persistence/sharedpref/shared_preferences_helper.dart'
    as _i19;
import '../../module_guide/service/guide_list/guide_list.dart' as _i20;
import '../../module_guide/manager/guides_manager/guides_manager.dart' as _i21;
import '../../module_guide/repository/guides/guide_repository.dart' as _i22;
import '../../module_authorization/guide_authorization_module/ui/screens/guide_login/guide_login.dart'
    as _i23;
import '../../module_authorization/guide_authorization_module/bloc/guide_login/guide_login.bloc.dart'
    as _i24;
import '../../module_authorization/login_selector_module/ui/screens/account_type_selector/login_type_selector.dart'
    as _i25;
import '../../module_home/home_module.dart' as _i26;
import '../../module_home/ui/screens/guide_home/guide_home.dart' as _i27;
import '../../module_orders/ui/screen/orders_list/order_list_screen.dart'
    as _i28;
import '../../module_orders/bloc/orders_list_bloc.dart' as _i29;
import '../../module_orders/service/orders/orders_service.dart' as _i30;
import '../../module_orders/manager/orders/orders_manager.dart' as _i31;
import '../../module_orders/repository/orders/orders.dart' as _i32;
import '../../module_locations/ui/screens/location_list/location_list_screen.dart'
    as _i33;
import '../../module_home/ui/screens/home/home.dart' as _i34;
import '../../module_guide/ui/screen/guide_list/guide_list_screen.dart' as _i35;
import '../../module_guide/bloc/guide_list/guide_list_bloc.dart' as _i36;
import '../../module_locations/ui/screens/event_list/event_list.dart' as _i37;
import '../../module_locations/bloc/event_list/event_list_bloc.dart' as _i38;
import '../../module_locations/service/event/event_service.dart' as _i39;
import '../../module_locations/manager/event/event_manager.dart' as _i40;
import '../../module_locations/repository/event/event_repository.dart' as _i41;
import '../../module_locations/ui/screens/location_carousel/location_carousel.dart'
    as _i42;
import '../../module_chat/chat_module.dart' as _i43;
import '../../module_chat/ui/screens/chat_page/chat_page.dart' as _i44;
import '../../module_chat/bloc/chat_page/chat_page.bloc.dart' as _i45;
import '../../module_chat/service/chat/char_service.dart' as _i46;
import '../../module_chat/manager/chat/chat_manager.dart' as _i47;
import '../../module_chat/repository/chat/chat_repository.dart' as _i48;
import '../../module_locations/location_module.dart' as _i49;
import '../../module_locations/ui/screens/location_details/location_details.dart'
    as _i50;
import '../../module_locations/bloc/location_details/location_details_bloc.dart'
    as _i51;
import '../../module_locations/service/location_details/location_details_service.dart'
    as _i52;
import '../../module_locations/manager/location_details/location_details.dart'
    as _i53;
import '../../module_locations/repository/location_details/location_details_repository.dart'
    as _i54;
import '../../module_comment/manager/rate/rate_manager.dart' as _i55;
import '../../module_comment/repository/rating/rating_repository.dart' as _i56;
import '../../module_comment/manager/comment/comment_service.dart' as _i57;
import '../../module_comment/repository/comment/comment_repository.dart'
    as _i58;
import '../../module_locations/ui/screens/event_details/event_details_screen.dart'
    as _i59;
import '../../module_locations/bloc/event_details/event_details.dart' as _i60;
import '../../module_guide/guide_list_module.dart' as _i61;
import '../../module_orders/order_module.dart' as _i62;
import '../../module_forms/forms_module.dart' as _i63;
import '../../module_forms/user_orders_module/ui/screens/request_guide/request_guide_screen.dart'
    as _i64;
import '../../module_forms/user_orders_module/bloc/request_guide/request_guide.bloc.dart'
    as _i65;
import '../../module_forms/user_orders_module/service/request_guide/request_guide.service.dart'
    as _i66;
import '../../module_forms/user_orders_module/manager/request_manager/request_guide_manager.dart'
    as _i67;
import '../../module_forms/user_orders_module/repository/request_guide/request_guide_repository.dart'
    as _i68;

class AppComponent$Injector implements _i1.AppComponent {
  AppComponent$Injector._();

  _i2.Logger _singletonLogger;

  _i3.HttpClient _singletonHttpClient;

  _i4.LocationListBloc _singletonLocationListBloc;

  _i5.AuthGuard _singletonAuthGuard;

  static _i6.Future<_i1.AppComponent> create() async {
    final injector = AppComponent$Injector._();

    return injector;
  }

  _i7.MyApp _createMyApp() => _i7.MyApp(
      _createAuthorizationModule(),
      _createHomeModule(),
      _createChatModule(),
      _createLocationModule(),
      _createGuideListModule(),
      _createOrderModule(),
      _createFormsModule(),
      _createSharedPreferencesHelper());
  _i8.AuthorizationModule _createAuthorizationModule() =>
      _i8.AuthorizationModule(_createUserAuthorizationModule(),
          _createGuideAuthorizationModule(), _createLoginTypeSelectorScreen());
  _i9.UserAuthorizationModule _createUserAuthorizationModule() =>
      _i9.UserAuthorizationModule();
  _i10.GuideAuthorizationModule _createGuideAuthorizationModule() =>
      _i10.GuideAuthorizationModule(
          _createGuideProfileScreen(), _createGuideLoginScreen());
  _i11.GuideProfileScreen _createGuideProfileScreen() =>
      _i11.GuideProfileScreen(_createLocationListService(),
          _createGuideRegisterBloc(), _createSharedPreferencesHelper());
  _i12.LocationListService _createLocationListService() =>
      _i12.LocationListService(_createLocationListManager());
  _i13.LocationListManager _createLocationListManager() =>
      _i13.LocationListManager(_createLocationListRepository());
  _i14.LocationListRepository _createLocationListRepository() =>
      _i14.LocationListRepository(_createHttpClient());
  _i3.HttpClient _createHttpClient() =>
      _singletonHttpClient ??= _i3.HttpClient(_createLogger());
  _i2.Logger _createLogger() => _singletonLogger ??= _i2.Logger();
  _i15.GuideRegisterBloc _createGuideRegisterBloc() =>
      _i15.GuideRegisterBloc(_createGuideRegisterService());
  _i16.GuideRegisterService _createGuideRegisterService() =>
      _i16.GuideRegisterService(_createGuideRegisterManager(),
          _createSharedPreferencesHelper(), _createGuideListService());
  _i17.GuideRegisterManager _createGuideRegisterManager() =>
      _i17.GuideRegisterManager(_createGuideRegisterRepository());
  _i18.GuideRegisterRepository _createGuideRegisterRepository() =>
      _i18.GuideRegisterRepository(_createHttpClient());
  _i19.SharedPreferencesHelper _createSharedPreferencesHelper() =>
      _i19.SharedPreferencesHelper();
  _i20.GuideListService _createGuideListService() =>
      _i20.GuideListService(_createGuidesManager());
  _i21.GuidesManager _createGuidesManager() =>
      _i21.GuidesManager(_createGuidesRepository());
  _i22.GuidesRepository _createGuidesRepository() =>
      _i22.GuidesRepository(_createHttpClient());
  _i23.GuideLoginScreen _createGuideLoginScreen() =>
      _i23.GuideLoginScreen(_createGuideLoginBloc());
  _i24.GuideLoginBloc _createGuideLoginBloc() => _i24.GuideLoginBloc();
  _i25.LoginTypeSelectorScreen _createLoginTypeSelectorScreen() =>
      _i25.LoginTypeSelectorScreen();
  _i26.HomeModule _createHomeModule() => _i26.HomeModule(
      _createGuideHomeScreen(), _createHomeScreen(), _createAuthGuard());
  _i27.GuideHomeScreen _createGuideHomeScreen() => _i27.GuideHomeScreen(
      _createOrdersListScreen(), _createLocationListScreen());
  _i28.OrdersListScreen _createOrdersListScreen() =>
      _i28.OrdersListScreen(_createOrdersListBloc());
  _i29.OrdersListBloc _createOrdersListBloc() =>
      _i29.OrdersListBloc(_createOrdersService());
  _i30.OrdersService _createOrdersService() =>
      _i30.OrdersService(_createOrdersManager(), _createGuideListService());
  _i31.OrdersManager _createOrdersManager() =>
      _i31.OrdersManager(_createOrdersRepository());
  _i32.OrdersRepository _createOrdersRepository() =>
      _i32.OrdersRepository(_createHttpClient());
  _i33.LocationListScreen _createLocationListScreen() =>
      _i33.LocationListScreen(_createLocationListBloc());
  _i4.LocationListBloc _createLocationListBloc() =>
      _singletonLocationListBloc ??=
          _i4.LocationListBloc(_createLocationListService(), _createLogger());
  _i34.HomeScreen _createHomeScreen() => _i34.HomeScreen(
      _createLocationListScreen(),
      _createGuideListScreen(),
      _createEventListScreen(),
      _createSharedPreferencesHelper(),
      _createLocationCarouselScreen());
  _i35.GuideListScreen _createGuideListScreen() =>
      _i35.GuideListScreen(_createGuideListBloc());
  _i36.GuideListBloc _createGuideListBloc() =>
      _i36.GuideListBloc(_createGuideListService());
  _i37.EventListScreen _createEventListScreen() =>
      _i37.EventListScreen(_createEventListBloc());
  _i38.EventListBloc _createEventListBloc() =>
      _i38.EventListBloc(_createEventService());
  _i39.EventService _createEventService() =>
      _i39.EventService(_createEventManager());
  _i40.EventManager _createEventManager() =>
      _i40.EventManager(_createEventRepository());
  _i41.EventRepository _createEventRepository() =>
      _i41.EventRepository(_createHttpClient());
  _i42.LocationCarouselScreen _createLocationCarouselScreen() =>
      _i42.LocationCarouselScreen(_createLocationListBloc());
  _i5.AuthGuard _createAuthGuard() =>
      _singletonAuthGuard ??= _i5.AuthGuard(_createSharedPreferencesHelper());
  _i43.ChatModule _createChatModule() => _i43.ChatModule(
      _createChatPage(), _createAuthGuard(), _createLoginTypeSelectorScreen());
  _i44.ChatPage _createChatPage() =>
      _i44.ChatPage(_createChatPageBloc(), _createSharedPreferencesHelper());
  _i45.ChatPageBloc _createChatPageBloc() =>
      _i45.ChatPageBloc(_createChatService());
  _i46.ChatService _createChatService() =>
      _i46.ChatService(_createChatManager(), _createSharedPreferencesHelper());
  _i47.ChatManager _createChatManager() =>
      _i47.ChatManager(_createChatRepository());
  _i48.ChatRepository _createChatRepository() => _i48.ChatRepository();
  _i49.LocationModule _createLocationModule() => _i49.LocationModule(
      _createLocationDetailsScreen(), _createEventDetailsScreen());
  _i50.LocationDetailsScreen _createLocationDetailsScreen() =>
      _i50.LocationDetailsScreen(_createLocationDetailsBloc());
  _i51.LocationDetailsBloc _createLocationDetailsBloc() =>
      _i51.LocationDetailsBloc(_createLocationDetailsService(),
          _createSharedPreferencesHelper(), _createCommentManager());
  _i52.LocationDetailsService _createLocationDetailsService() =>
      _i52.LocationDetailsService(
          _createLocationDetailsManager(),
          _createGuidesManager(),
          _createRatingManager(),
          _createSharedPreferencesHelper());
  _i53.LocationDetailsManager _createLocationDetailsManager() =>
      _i53.LocationDetailsManager(_createLocationDetailsRepository());
  _i54.LocationDetailsRepository _createLocationDetailsRepository() =>
      _i54.LocationDetailsRepository(_createHttpClient());
  _i55.RatingManager _createRatingManager() =>
      _i55.RatingManager(_createRatingRepository());
  _i56.RatingRepository _createRatingRepository() =>
      _i56.RatingRepository(_createHttpClient());
  _i57.CommentManager _createCommentManager() =>
      _i57.CommentManager(_createCommentRepository());
  _i58.CommentRepository _createCommentRepository() =>
      _i58.CommentRepository(_createHttpClient());
  _i59.EventDetailsScreen _createEventDetailsScreen() =>
      _i59.EventDetailsScreen(_createEventDetailsBloc());
  _i60.EventDetailsBloc _createEventDetailsBloc() => _i60.EventDetailsBloc(
      _createEventService(), _createLocationListService());
  _i61.GuideListModule _createGuideListModule() => _i61.GuideListModule();
  _i62.OrderModule _createOrderModule() =>
      _i62.OrderModule(_createOrdersListScreen());
  _i63.FormsModule _createFormsModule() => _i63.FormsModule(
      _createRequestGuideScreen(),
      _createAuthGuard(),
      _createLoginTypeSelectorScreen());
  _i64.RequestGuideScreen _createRequestGuideScreen() =>
      _i64.RequestGuideScreen(_createRequestGuideBloc(), _createLogger());
  _i65.RequestGuideBloc _createRequestGuideBloc() => _i65.RequestGuideBloc(
      _createRequestGuideService(), _createLocationDetailsService());
  _i66.RequestGuideService _createRequestGuideService() =>
      _i66.RequestGuideService(_createSharedPreferencesHelper(),
          _createGuideListService(), _createRequestGuideManager());
  _i67.RequestGuideManager _createRequestGuideManager() =>
      _i67.RequestGuideManager(_createRequestGuideRepository());
  _i68.RequestGuideRepository _createRequestGuideRepository() =>
      _i68.RequestGuideRepository(_createHttpClient());
  @override
  _i7.MyApp get app => _createMyApp();
}
