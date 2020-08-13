import 'app.component.dart' as _i1;
import '../../utils/logger/logger.dart' as _i2;
import '../../module_network/http_client/http_client.dart' as _i3;
import 'dart:async' as _i4;
import '../../main.dart' as _i5;
import '../../module_authorization/authprization_module.dart' as _i6;
import '../../module_authorization/user_authorization_module/user_auth.dart'
    as _i7;
import '../../module_authorization/guide_authorization_module/guide_authorization_module.dart'
    as _i8;
import '../../module_authorization/guide_authorization_module/ui/screens/guide_profile/guide_profile.dart'
    as _i9;
import '../../module_locations/service/location_list/location_list_service.dart'
    as _i10;
import '../../module_locations/manager/location_list/location_list_manager.dart'
    as _i11;
import '../../module_locations/repository/location_list/location_list_repository.dart'
    as _i12;
import '../../module_authorization/guide_authorization_module/bloc/guide_register/guide_register.dart'
    as _i13;
import '../../module_authorization/guide_authorization_module/service/guide_register/guide_register.dart'
    as _i14;
import '../../module_authorization/guide_authorization_module/manager/guide_register/guide_register.dart'
    as _i15;
import '../../module_authorization/guide_authorization_module/repository/guide_register/guide_register.dart'
    as _i16;
import '../../module_persistence/sharedpref/shared_preferences_helper.dart'
    as _i17;
import '../../module_guide/service/guide_list/guide_list.dart' as _i18;
import '../../module_guide/manager/guides_manager/guides_manager.dart' as _i19;
import '../../module_guide/repository/guides/guide_repository.dart' as _i20;
import '../../module_authorization/guide_authorization_module/ui/screens/guide_login/guide_login.dart'
    as _i21;
import '../../module_authorization/guide_authorization_module/bloc/guide_login/guide_login.bloc.dart'
    as _i22;
import '../../module_authorization/login_selector_module/ui/screens/account_type_selector/login_type_selector.dart'
    as _i23;
import '../../module_home/home_module.dart' as _i24;
import '../../module_home/ui/screens/guide_home/guide_home.dart' as _i25;
import '../../module_orders/ui/screen/orders_list/order_list_screen.dart'
    as _i26;
import '../../module_orders/bloc/orders_list_bloc.dart' as _i27;
import '../../module_orders/service/orders/orders_service.dart' as _i28;
import '../../module_orders/manager/orders/orders_manager.dart' as _i29;
import '../../module_orders/repository/orders/orders.dart' as _i30;
import '../../module_locations/ui/screens/location_list/location_list_screen.dart'
    as _i31;
import '../../module_locations/bloc/location_list/location_list_bloc.dart'
    as _i32;
import '../../module_home/ui/screens/home/home.dart' as _i33;
import '../../module_guide/ui/screen/guide_list/guide_list_screen.dart' as _i34;
import '../../module_guide/bloc/guide_list/guide_list_bloc.dart' as _i35;
import '../../module_locations/ui/screens/event_list/event_list.dart' as _i36;
import '../../module_locations/bloc/event_list/event_list_bloc.dart' as _i37;
import '../../module_locations/service/event/event_service.dart' as _i38;
import '../../module_locations/manager/event/event_manager.dart' as _i39;
import '../../module_locations/repository/event/event_repository.dart' as _i40;
import '../../module_locations/ui/screens/location_carousel/location_carousel.dart'
    as _i41;
import '../../module_chat/chat_module.dart' as _i42;
import '../../module_chat/ui/screens/chat_page/chat_page.dart' as _i43;
import '../../module_chat/bloc/chat_page/chat_page.bloc.dart' as _i44;
import '../../module_chat/service/chat/char_service.dart' as _i45;
import '../../module_chat/manager/chat/chat_manager.dart' as _i46;
import '../../module_chat/repository/chat/chat_repository.dart' as _i47;
import '../../module_locations/location_module.dart' as _i48;
import '../../module_locations/ui/screens/location_details/location_details.dart'
    as _i49;
import '../../module_locations/bloc/location_details/location_details_bloc.dart'
    as _i50;
import '../../module_locations/service/location_details/location_details_service.dart'
    as _i51;
import '../../module_locations/manager/location_details/location_details.dart'
    as _i52;
import '../../module_locations/repository/location_details/location_details_repository.dart'
    as _i53;
import '../../module_comment/manager/rate/rate_manager.dart' as _i54;
import '../../module_comment/repository/rating/rating_repository.dart' as _i55;
import '../../module_comment/manager/comment/comment_service.dart' as _i56;
import '../../module_comment/repository/comment/comment_repository.dart'
    as _i57;
import '../../module_locations/ui/screens/event_details/event_details_screen.dart'
    as _i58;
import '../../module_locations/bloc/event_details/event_details.dart' as _i59;
import '../../module_guide/guide_list_module.dart' as _i60;
import '../../module_forms/forms_module.dart' as _i61;
import '../../module_forms/user_orders_module/ui/screens/request_guide/request_guide_screen.dart'
    as _i62;
import '../../module_forms/user_orders_module/bloc/request_guide/request_guide.bloc.dart'
    as _i63;
import '../../module_forms/user_orders_module/service/request_guide/request_guide.service.dart'
    as _i64;
import '../../module_forms/user_orders_module/manager/request_manager/request_guide_manager.dart'
    as _i65;
import '../../module_forms/user_orders_module/repository/request_guide/request_guide_repository.dart'
    as _i66;

class AppComponent$Injector implements _i1.AppComponent {
  AppComponent$Injector._();

  _i2.Logger _singletonLogger;

  _i3.HttpClient _singletonHttpClient;

  static _i4.Future<_i1.AppComponent> create() async {
    final injector = AppComponent$Injector._();

    return injector;
  }

  _i5.MyApp _createMyApp() => _i5.MyApp(
      _createAuthorizationModule(),
      _createHomeModule(),
      _createChatModule(),
      _createLocationModule(),
      _createGuideListModule(),
      _createFormsModule(),
      _createSharedPreferencesHelper());
  _i6.AuthorizationModule _createAuthorizationModule() =>
      _i6.AuthorizationModule(_createUserAuthorizationModule(),
          _createGuideAuthorizationModule(), _createLoginTypeSelectorScreen());
  _i7.UserAuthorizationModule _createUserAuthorizationModule() =>
      _i7.UserAuthorizationModule();
  _i8.GuideAuthorizationModule _createGuideAuthorizationModule() =>
      _i8.GuideAuthorizationModule(
          _createGuideProfileScreen(), _createGuideLoginScreen());
  _i9.GuideProfileScreen _createGuideProfileScreen() => _i9.GuideProfileScreen(
      _createLocationListService(), _createGuideRegisterBloc());
  _i10.LocationListService _createLocationListService() =>
      _i10.LocationListService(_createLocationListManager());
  _i11.LocationListManager _createLocationListManager() =>
      _i11.LocationListManager(_createLocationListRepository());
  _i12.LocationListRepository _createLocationListRepository() =>
      _i12.LocationListRepository(_createHttpClient());
  _i3.HttpClient _createHttpClient() =>
      _singletonHttpClient ??= _i3.HttpClient(_createLogger());
  _i2.Logger _createLogger() => _singletonLogger ??= _i2.Logger();
  _i13.GuideRegisterBloc _createGuideRegisterBloc() =>
      _i13.GuideRegisterBloc(_createGuideRegisterService());
  _i14.GuideRegisterService _createGuideRegisterService() =>
      _i14.GuideRegisterService(_createGuideRegisterManager(),
          _createSharedPreferencesHelper(), _createGuideListService());
  _i15.GuideRegisterManager _createGuideRegisterManager() =>
      _i15.GuideRegisterManager(_createGuideRegisterRepository());
  _i16.GuideRegisterRepository _createGuideRegisterRepository() =>
      _i16.GuideRegisterRepository(_createHttpClient());
  _i17.SharedPreferencesHelper _createSharedPreferencesHelper() =>
      _i17.SharedPreferencesHelper();
  _i18.GuideListService _createGuideListService() =>
      _i18.GuideListService(_createGuidesManager());
  _i19.GuidesManager _createGuidesManager() =>
      _i19.GuidesManager(_createGuidesRepository());
  _i20.GuidesRepository _createGuidesRepository() =>
      _i20.GuidesRepository(_createHttpClient());
  _i21.GuideLoginScreen _createGuideLoginScreen() =>
      _i21.GuideLoginScreen(_createGuideLoginBloc());
  _i22.GuideLoginBloc _createGuideLoginBloc() => _i22.GuideLoginBloc();
  _i23.LoginTypeSelectorScreen _createLoginTypeSelectorScreen() =>
      _i23.LoginTypeSelectorScreen();
  _i24.HomeModule _createHomeModule() =>
      _i24.HomeModule(_createGuideHomeScreen(), _createHomeScreen());
  _i25.GuideHomeScreen _createGuideHomeScreen() => _i25.GuideHomeScreen(
      _createOrdersListScreen(), _createLocationListScreen());
  _i26.OrdersListScreen _createOrdersListScreen() =>
      _i26.OrdersListScreen(_createOrdersListBloc());
  _i27.OrdersListBloc _createOrdersListBloc() =>
      _i27.OrdersListBloc(_createOrdersService());
  _i28.OrdersService _createOrdersService() =>
      _i28.OrdersService(_createOrdersManager(), _createGuideListService());
  _i29.OrdersManager _createOrdersManager() =>
      _i29.OrdersManager(_createOrdersRepository());
  _i30.OrdersRepository _createOrdersRepository() =>
      _i30.OrdersRepository(_createHttpClient());
  _i31.LocationListScreen _createLocationListScreen() =>
      _i31.LocationListScreen(_createLocationListBloc());
  _i32.LocationListBloc _createLocationListBloc() =>
      _i32.LocationListBloc(_createLocationListService(), _createLogger());
  _i33.HomeScreen _createHomeScreen() => _i33.HomeScreen(
      _createLocationListScreen(),
      _createGuideListScreen(),
      _createEventListScreen(),
      _createSharedPreferencesHelper(),
      _createLocationCarouselScreen());
  _i34.GuideListScreen _createGuideListScreen() =>
      _i34.GuideListScreen(_createGuideListBloc());
  _i35.GuideListBloc _createGuideListBloc() =>
      _i35.GuideListBloc(_createGuideListService());
  _i36.EventListScreen _createEventListScreen() =>
      _i36.EventListScreen(_createEventListBloc());
  _i37.EventListBloc _createEventListBloc() =>
      _i37.EventListBloc(_createEventService());
  _i38.EventService _createEventService() =>
      _i38.EventService(_createEventManager());
  _i39.EventManager _createEventManager() =>
      _i39.EventManager(_createEventRepository());
  _i40.EventRepository _createEventRepository() =>
      _i40.EventRepository(_createHttpClient());
  _i41.LocationCarouselScreen _createLocationCarouselScreen() =>
      _i41.LocationCarouselScreen(_createLocationListBloc());
  _i42.ChatModule _createChatModule() => _i42.ChatModule(_createChatPage());
  _i43.ChatPage _createChatPage() =>
      _i43.ChatPage(_createChatPageBloc(), _createSharedPreferencesHelper());
  _i44.ChatPageBloc _createChatPageBloc() =>
      _i44.ChatPageBloc(_createChatService());
  _i45.ChatService _createChatService() =>
      _i45.ChatService(_createChatManager(), _createSharedPreferencesHelper());
  _i46.ChatManager _createChatManager() =>
      _i46.ChatManager(_createChatRepository());
  _i47.ChatRepository _createChatRepository() => _i47.ChatRepository();
  _i48.LocationModule _createLocationModule() => _i48.LocationModule(
      _createLocationDetailsScreen(), _createEventDetailsScreen());
  _i49.LocationDetailsScreen _createLocationDetailsScreen() =>
      _i49.LocationDetailsScreen(_createLocationDetailsBloc());
  _i50.LocationDetailsBloc _createLocationDetailsBloc() =>
      _i50.LocationDetailsBloc(_createLocationDetailsService(),
          _createSharedPreferencesHelper(), _createCommentManager());
  _i51.LocationDetailsService _createLocationDetailsService() =>
      _i51.LocationDetailsService(
          _createLocationDetailsManager(),
          _createGuidesManager(),
          _createRatingManager(),
          _createSharedPreferencesHelper());
  _i52.LocationDetailsManager _createLocationDetailsManager() =>
      _i52.LocationDetailsManager(_createLocationDetailsRepository());
  _i53.LocationDetailsRepository _createLocationDetailsRepository() =>
      _i53.LocationDetailsRepository(_createHttpClient());
  _i54.RatingManager _createRatingManager() =>
      _i54.RatingManager(_createRatingRepository());
  _i55.RatingRepository _createRatingRepository() =>
      _i55.RatingRepository(_createHttpClient());
  _i56.CommentManager _createCommentManager() =>
      _i56.CommentManager(_createCommentRepository());
  _i57.CommentRepository _createCommentRepository() =>
      _i57.CommentRepository(_createHttpClient());
  _i58.EventDetailsScreen _createEventDetailsScreen() =>
      _i58.EventDetailsScreen(_createEventDetailsBloc());
  _i59.EventDetailsBloc _createEventDetailsBloc() => _i59.EventDetailsBloc(
      _createEventService(), _createLocationListService());
  _i60.GuideListModule _createGuideListModule() => _i60.GuideListModule();
  _i61.FormsModule _createFormsModule() =>
      _i61.FormsModule(_createRequestGuideScreen());
  _i62.RequestGuideScreen _createRequestGuideScreen() =>
      _i62.RequestGuideScreen(_createRequestGuideBloc(), _createLogger());
  _i63.RequestGuideBloc _createRequestGuideBloc() => _i63.RequestGuideBloc(
      _createRequestGuideService(), _createLocationDetailsService());
  _i64.RequestGuideService _createRequestGuideService() =>
      _i64.RequestGuideService(_createSharedPreferencesHelper(),
          _createGuideListService(), _createRequestGuideManager());
  _i65.RequestGuideManager _createRequestGuideManager() =>
      _i65.RequestGuideManager(_createRequestGuideRepository());
  _i66.RequestGuideRepository _createRequestGuideRepository() =>
      _i66.RequestGuideRepository(_createHttpClient());
  @override
  _i5.MyApp get app => _createMyApp();
}
