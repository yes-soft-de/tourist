import 'app.component.dart' as _i1;
import '../../utils/logger/logger.dart' as _i2;
import '../../utils/auth_guard/auth_gard.dart' as _i3;
import '../../module_locations/bloc/location_list/location_list_bloc.dart'
    as _i4;
import 'dart:async' as _i5;
import '../../main.dart' as _i6;
import '../../utils/language/language.dart' as _i7;
import '../../module_persistence/sharedpref/shared_preferences_helper.dart'
    as _i8;
import '../../module_authorization/authprization_module.dart' as _i9;
import '../../module_authorization/user_authorization_module/user_auth.dart'
    as _i10;
import '../../module_authorization/user_authorization_module/ui/screens/create_profile/create_profile.dart'
    as _i11;
import '../../module_authorization/user_authorization_module/bloc/create_profile/create_profile_bloc.dart'
    as _i12;
import '../../module_authorization/user_authorization_module/service/profile/profile.service.dart'
    as _i13;
import '../../module_authorization/user_authorization_module/manager/profile/profile.manager.dart'
    as _i14;
import '../../module_authorization/user_authorization_module/repository/profile/profile.repository.dart'
    as _i15;
import '../../module_network/http_client/http_client.dart' as _i16;
import '../../module_authorization/user_authorization_module/ui/screens/register/register.dart'
    as _i17;
import '../../module_authorization/user_authorization_module/bloc/register/register.bloc.dart'
    as _i18;
import '../../module_authorization/user_authorization_module/service/register/register.service.dart'
    as _i19;
import '../../module_authorization/user_authorization_module/ui/screens/login/login.dart'
    as _i20;
import '../../module_authorization/user_authorization_module/bloc/login/login.bloc.dart'
    as _i21;
import '../../module_authorization/user_authorization_module/service/login/login.service.dart'
    as _i22;
import '../../module_authorization/user_authorization_module/ui/screens/intention_profile/intention_profile.dart'
    as _i23;
import '../../module_authorization/user_authorization_module/bloc/create_intentions/create_intention_bloc.dart'
    as _i24;
import '../../module_authorization/user_authorization_module/service/intentions/intentions_service.dart'
    as _i25;
import '../../module_authorization/user_authorization_module/manager/intentions/intentions_manager.dart'
    as _i26;
import '../../module_authorization/user_authorization_module/repository/intentions/intentions_repository.dart'
    as _i27;
import '../../module_authorization/login_selector_module/ui/screens/logout/logout.dart'
    as _i28;
import '../../module_authorization/guide_authorization_module/guide_authorization_module.dart'
    as _i29;
import '../../module_authorization/guide_authorization_module/ui/screens/guide_profile/guide_profile.dart'
    as _i30;
import '../../module_locations/service/location_list/location_list_service.dart'
    as _i31;
import '../../module_locations/manager/location_list/location_list_manager.dart'
    as _i32;
import '../../module_locations/repository/location_list/location_list_repository.dart'
    as _i33;
import '../../module_authorization/guide_authorization_module/bloc/guide_register/guide_register.dart'
    as _i34;
import '../../module_authorization/guide_authorization_module/service/guide_register/guide_register.dart'
    as _i35;
import '../../module_authorization/guide_authorization_module/manager/guide_register/guide_register.dart'
    as _i36;
import '../../module_authorization/guide_authorization_module/repository/guide_register/guide_register.dart'
    as _i37;
import '../../module_guide/service/guide_list/guide_list.dart' as _i38;
import '../../module_guide/manager/guides_manager/guides_manager.dart' as _i39;
import '../../module_guide/repository/guides/guide_repository.dart' as _i40;
import '../../module_authorization/guide_authorization_module/ui/screens/guide_login/guide_login.dart'
    as _i41;
import '../../module_authorization/guide_authorization_module/bloc/guide_login/guide_login.bloc.dart'
    as _i42;
import '../../module_authorization/login_selector_module/ui/screens/account_type_selector/login_type_selector.dart'
    as _i43;
import '../../module_settings/settings_module.dart' as _i44;
import '../../module_settings/ui/settings/settings.dart' as _i45;
import '../../module_home/home_module.dart' as _i46;
import '../../module_home/ui/screens/guide_home/guide_home.dart' as _i47;
import '../../module_orders/ui/screen/guide_orders/guide_orders.dart' as _i48;
import '../../module_orders/bloc/guide_orders_list/guide_orders_list.dart'
    as _i49;
import '../../module_orders/service/guide_orders/guide_orders.dart' as _i50;
import '../../module_orders/manager/guide_orders/guide_orders.dart' as _i51;
import '../../module_orders/repository/guide_orders/guide_orders.dart' as _i52;
import '../../module_forms/user_orders_module/service/request_guide/request_guide.service.dart'
    as _i53;
import '../../module_forms/user_orders_module/manager/request_manager/request_guide_manager.dart'
    as _i54;
import '../../module_forms/user_orders_module/repository/request_guide/request_guide_repository.dart'
    as _i55;
import '../../module_locations/ui/screens/location_list/location_list_screen.dart'
    as _i56;
import '../../module_locations/ui/screens/event_list/event_list.dart' as _i57;
import '../../module_locations/bloc/event_list/event_list_bloc.dart' as _i58;
import '../../module_locations/service/event/event_service.dart' as _i59;
import '../../module_locations/manager/event/event_manager.dart' as _i60;
import '../../module_locations/repository/event/event_repository.dart' as _i61;
import '../../module_home/ui/screens/home/home.dart' as _i62;
import '../../module_guide/ui/screen/guide_list/guide_list_screen.dart' as _i63;
import '../../module_guide/bloc/guide_list/guide_list_bloc.dart' as _i64;
import '../../module_locations/ui/screens/location_carousel/location_carousel.dart'
    as _i65;
import '../../module_splash/splash_module.dart' as _i66;
import '../../module_splash/ui/screen/splash_screen.dart' as _i67;
import '../../module_chat/chat_module.dart' as _i68;
import '../../module_chat/ui/screens/chat_page/chat_page.dart' as _i69;
import '../../module_chat/bloc/chat_page/chat_page.bloc.dart' as _i70;
import '../../module_chat/service/chat/char_service.dart' as _i71;
import '../../module_chat/manager/chat/chat_manager.dart' as _i72;
import '../../module_chat/repository/chat/chat_repository.dart' as _i73;
import '../../module_locations/location_module.dart' as _i74;
import '../../module_locations/ui/screens/location_details/location_details.dart'
    as _i75;
import '../../module_locations/bloc/location_details/location_details_bloc.dart'
    as _i76;
import '../../module_locations/service/location_details/location_details_service.dart'
    as _i77;
import '../../module_locations/manager/location_details/location_details.dart'
    as _i78;
import '../../module_locations/repository/location_details/location_details_repository.dart'
    as _i79;
import '../../module_comment/manager/rate/rate_manager.dart' as _i80;
import '../../module_comment/repository/rating/rating_repository.dart' as _i81;
import '../../module_comment/manager/comment/comment_service.dart' as _i82;
import '../../module_comment/repository/comment/comment_repository.dart'
    as _i83;
import '../../module_locations/ui/screens/event_details/event_details_screen.dart'
    as _i84;
import '../../module_locations/bloc/event_details/event_details.dart' as _i85;
import '../../module_guide/guide_list_module.dart' as _i86;
import '../../module_orders/order_module.dart' as _i87;
import '../../module_orders/ui/screen/orders_list/order_list_screen.dart'
    as _i88;
import '../../module_orders/bloc/orders_list_bloc/orders_list_bloc.dart'
    as _i89;
import '../../module_orders/service/orders/orders_service.dart' as _i90;
import '../../module_orders/manager/orders/orders_manager.dart' as _i91;
import '../../module_orders/repository/orders/orders.dart' as _i92;
import '../../module_forms/forms_module.dart' as _i93;
import '../../module_forms/user_orders_module/ui/screens/request_guide/request_guide_screen.dart'
    as _i94;
import '../../module_forms/user_orders_module/bloc/request_guide/request_guide.bloc.dart'
    as _i95;

class AppComponent$Injector implements _i1.AppComponent {
  AppComponent$Injector._();

  _i2.Logger _singletonLogger;

  _i3.AuthGuard _singletonAuthGuard;

  _i4.LocationListBloc _singletonLocationListBloc;

  static _i5.Future<_i1.AppComponent> create() async {
    final injector = AppComponent$Injector._();

    return injector;
  }

  _i6.MyApp _createMyApp() => _i6.MyApp(
      _createLanguageHelper(),
      _createAuthorizationModule(),
      _createSettingsModule(),
      _createHomeModule(),
      _createSplashModule(),
      _createChatModule(),
      _createLocationModule(),
      _createGuideListModule(),
      _createOrderModule(),
      _createFormsModule());
  _i7.LanguageHelper _createLanguageHelper() =>
      _i7.LanguageHelper(_createSharedPreferencesHelper());
  _i8.SharedPreferencesHelper _createSharedPreferencesHelper() =>
      _i8.SharedPreferencesHelper();
  _i9.AuthorizationModule _createAuthorizationModule() =>
      _i9.AuthorizationModule(
          _createUserAuthorizationModule(),
          _createLogoutScreen(),
          _createGuideAuthorizationModule(),
          _createLoginTypeSelectorScreen());
  _i10.UserAuthorizationModule _createUserAuthorizationModule() =>
      _i10.UserAuthorizationModule(
          _createCreateProfileScreen(),
          _createRegisterScreen(),
          _createLoginScreen(),
          _createIntentionProfileScreen(),
          _createLogoutScreen());
  _i11.CreateProfileScreen _createCreateProfileScreen() =>
      _i11.CreateProfileScreen(
          _createCreateProfileBloc(), _createSharedPreferencesHelper());
  _i12.CreateProfileBloc _createCreateProfileBloc() =>
      _i12.CreateProfileBloc(_createProfileService());
  _i13.ProfileService _createProfileService() => _i13.ProfileService(
      _createProfileManager(), _createSharedPreferencesHelper());
  _i14.ProfileManager _createProfileManager() =>
      _i14.ProfileManager(_createProfileRepository());
  _i15.ProfileRepository _createProfileRepository() =>
      _i15.ProfileRepository(_createHttpClient());
  _i16.HttpClient _createHttpClient() => _i16.HttpClient(_createLogger());
  _i2.Logger _createLogger() => _singletonLogger ??= _i2.Logger();
  _i17.RegisterScreen _createRegisterScreen() =>
      _i17.RegisterScreen(_createRegisterBloc());
  _i18.RegisterBloc _createRegisterBloc() =>
      _i18.RegisterBloc(_createRegisterService());
  _i19.RegisterService _createRegisterService() =>
      _i19.RegisterService(_createSharedPreferencesHelper());
  _i20.LoginScreen _createLoginScreen() =>
      _i20.LoginScreen(_createLoginBloc(), _createSharedPreferencesHelper());
  _i21.LoginBloc _createLoginBloc() => _i21.LoginBloc(_createLoginService());
  _i22.LoginService _createLoginService() =>
      _i22.LoginService(_createSharedPreferencesHelper());
  _i23.IntentionProfileScreen _createIntentionProfileScreen() =>
      _i23.IntentionProfileScreen(
          _createCreateIntentionBloc(), _createSharedPreferencesHelper());
  _i24.CreateIntentionBloc _createCreateIntentionBloc() =>
      _i24.CreateIntentionBloc(_createIntentionService());
  _i25.IntentionService _createIntentionService() =>
      _i25.IntentionService(_createIntentionsManager());
  _i26.IntentionsManager _createIntentionsManager() =>
      _i26.IntentionsManager(_createIntentionsRepository());
  _i27.IntentionsRepository _createIntentionsRepository() =>
      _i27.IntentionsRepository(_createHttpClient());
  _i28.LogoutScreen _createLogoutScreen() =>
      _i28.LogoutScreen(_createSharedPreferencesHelper());
  _i29.GuideAuthorizationModule _createGuideAuthorizationModule() =>
      _i29.GuideAuthorizationModule(
          _createGuideProfileScreen(), _createGuideLoginScreen());
  _i30.GuideProfileScreen _createGuideProfileScreen() =>
      _i30.GuideProfileScreen(_createLocationListService(),
          _createGuideRegisterBloc(), _createSharedPreferencesHelper());
  _i31.LocationListService _createLocationListService() =>
      _i31.LocationListService(_createLocationListManager());
  _i32.LocationListManager _createLocationListManager() =>
      _i32.LocationListManager(_createLocationListRepository());
  _i33.LocationListRepository _createLocationListRepository() =>
      _i33.LocationListRepository(_createHttpClient());
  _i34.GuideRegisterBloc _createGuideRegisterBloc() =>
      _i34.GuideRegisterBloc(_createGuideRegisterService());
  _i35.GuideRegisterService _createGuideRegisterService() =>
      _i35.GuideRegisterService(_createGuideRegisterManager(),
          _createSharedPreferencesHelper(), _createGuideListService());
  _i36.GuideRegisterManager _createGuideRegisterManager() =>
      _i36.GuideRegisterManager(_createGuideRegisterRepository());
  _i37.GuideRegisterRepository _createGuideRegisterRepository() =>
      _i37.GuideRegisterRepository(_createHttpClient());
  _i38.GuideListService _createGuideListService() =>
      _i38.GuideListService(_createGuidesManager());
  _i39.GuidesManager _createGuidesManager() =>
      _i39.GuidesManager(_createGuidesRepository());
  _i40.GuidesRepository _createGuidesRepository() =>
      _i40.GuidesRepository(_createHttpClient());
  _i41.GuideLoginScreen _createGuideLoginScreen() =>
      _i41.GuideLoginScreen(_createGuideLoginBloc());
  _i42.GuideLoginBloc _createGuideLoginBloc() => _i42.GuideLoginBloc();
  _i43.LoginTypeSelectorScreen _createLoginTypeSelectorScreen() =>
      _i43.LoginTypeSelectorScreen();
  _i44.SettingsModule _createSettingsModule() =>
      _i44.SettingsModule(_createSettingsScreen());
  _i45.SettingsScreen _createSettingsScreen() =>
      _i45.SettingsScreen(_createAuthGuard(), _createLanguageHelper());
  _i3.AuthGuard _createAuthGuard() =>
      _singletonAuthGuard ??= _i3.AuthGuard(_createSharedPreferencesHelper());
  _i46.HomeModule _createHomeModule() => _i46.HomeModule(
      _createGuideHomeScreen(), _createHomeScreen(), _createAuthGuard());
  _i47.GuideHomeScreen _createGuideHomeScreen() => _i47.GuideHomeScreen(
      _createGuideOrdersScreen(),
      _createLocationListScreen(),
      _createEventListScreen(),
      _createSharedPreferencesHelper());
  _i48.GuideOrdersScreen _createGuideOrdersScreen() =>
      _i48.GuideOrdersScreen(_createGuideOrdersListBloc());
  _i49.GuideOrdersListBloc _createGuideOrdersListBloc() =>
      _i49.GuideOrdersListBloc(_createGuideOrdersService());
  _i50.GuideOrdersService _createGuideOrdersService() =>
      _i50.GuideOrdersService(
          _createGuideOrdersManager(), _createRequestGuideService());
  _i51.GuideOrdersManager _createGuideOrdersManager() =>
      _i51.GuideOrdersManager(_createGuideOrdersRepository());
  _i52.GuideOrdersRepository _createGuideOrdersRepository() =>
      _i52.GuideOrdersRepository(_createHttpClient());
  _i53.RequestGuideService _createRequestGuideService() =>
      _i53.RequestGuideService(_createSharedPreferencesHelper(),
          _createGuideListService(), _createRequestGuideManager());
  _i54.RequestGuideManager _createRequestGuideManager() =>
      _i54.RequestGuideManager(_createRequestGuideRepository());
  _i55.RequestGuideRepository _createRequestGuideRepository() =>
      _i55.RequestGuideRepository(_createHttpClient());
  _i56.LocationListScreen _createLocationListScreen() =>
      _i56.LocationListScreen(_createLocationListBloc());
  _i4.LocationListBloc _createLocationListBloc() =>
      _singletonLocationListBloc ??=
          _i4.LocationListBloc(_createLocationListService(), _createLogger());
  _i57.EventListScreen _createEventListScreen() =>
      _i57.EventListScreen(_createEventListBloc());
  _i58.EventListBloc _createEventListBloc() =>
      _i58.EventListBloc(_createEventService());
  _i59.EventService _createEventService() =>
      _i59.EventService(_createEventManager());
  _i60.EventManager _createEventManager() =>
      _i60.EventManager(_createEventRepository());
  _i61.EventRepository _createEventRepository() =>
      _i61.EventRepository(_createHttpClient());
  _i62.HomeScreen _createHomeScreen() => _i62.HomeScreen(
      _createLocationListScreen(),
      _createGuideListScreen(),
      _createEventListScreen(),
      _createSharedPreferencesHelper(),
      _createAuthGuard(),
      _createLocationCarouselScreen());
  _i63.GuideListScreen _createGuideListScreen() =>
      _i63.GuideListScreen(_createGuideListBloc());
  _i64.GuideListBloc _createGuideListBloc() =>
      _i64.GuideListBloc(_createGuideListService());
  _i65.LocationCarouselScreen _createLocationCarouselScreen() =>
      _i65.LocationCarouselScreen(_createLocationListBloc());
  _i66.SplashModule _createSplashModule() =>
      _i66.SplashModule(_createSplashScreen());
  _i67.SplashScreen _createSplashScreen() => _i67.SplashScreen();
  _i68.ChatModule _createChatModule() => _i68.ChatModule(
      _createChatPage(), _createAuthGuard(), _createLoginTypeSelectorScreen());
  _i69.ChatPage _createChatPage() =>
      _i69.ChatPage(_createChatPageBloc(), _createSharedPreferencesHelper());
  _i70.ChatPageBloc _createChatPageBloc() =>
      _i70.ChatPageBloc(_createChatService());
  _i71.ChatService _createChatService() =>
      _i71.ChatService(_createChatManager(), _createSharedPreferencesHelper());
  _i72.ChatManager _createChatManager() =>
      _i72.ChatManager(_createChatRepository());
  _i73.ChatRepository _createChatRepository() => _i73.ChatRepository();
  _i74.LocationModule _createLocationModule() => _i74.LocationModule(
      _createLocationDetailsScreen(), _createEventDetailsScreen());
  _i75.LocationDetailsScreen _createLocationDetailsScreen() =>
      _i75.LocationDetailsScreen(
          _createLocationDetailsBloc(), _createAuthGuard());
  _i76.LocationDetailsBloc _createLocationDetailsBloc() =>
      _i76.LocationDetailsBloc(_createLocationDetailsService(),
          _createSharedPreferencesHelper(), _createCommentManager());
  _i77.LocationDetailsService _createLocationDetailsService() =>
      _i77.LocationDetailsService(
          _createLocationDetailsManager(),
          _createGuidesManager(),
          _createRatingManager(),
          _createSharedPreferencesHelper());
  _i78.LocationDetailsManager _createLocationDetailsManager() =>
      _i78.LocationDetailsManager(_createLocationDetailsRepository());
  _i79.LocationDetailsRepository _createLocationDetailsRepository() =>
      _i79.LocationDetailsRepository(_createHttpClient());
  _i80.RatingManager _createRatingManager() =>
      _i80.RatingManager(_createRatingRepository());
  _i81.RatingRepository _createRatingRepository() =>
      _i81.RatingRepository(_createHttpClient());
  _i82.CommentManager _createCommentManager() =>
      _i82.CommentManager(_createCommentRepository());
  _i83.CommentRepository _createCommentRepository() =>
      _i83.CommentRepository(_createHttpClient());
  _i84.EventDetailsScreen _createEventDetailsScreen() =>
      _i84.EventDetailsScreen(_createEventDetailsBloc());
  _i85.EventDetailsBloc _createEventDetailsBloc() => _i85.EventDetailsBloc(
      _createEventService(), _createLocationListService());
  _i86.GuideListModule _createGuideListModule() => _i86.GuideListModule();
  _i87.OrderModule _createOrderModule() => _i87.OrderModule(
      _createOrdersListScreen(),
      _createLoginTypeSelectorScreen(),
      _createAuthGuard());
  _i88.OrdersListScreen _createOrdersListScreen() =>
      _i88.OrdersListScreen(_createOrdersListBloc());
  _i89.OrdersListBloc _createOrdersListBloc() =>
      _i89.OrdersListBloc(_createOrdersService());
  _i90.OrdersService _createOrdersService() =>
      _i90.OrdersService(_createOrdersManager(), _createGuideListService());
  _i91.OrdersManager _createOrdersManager() =>
      _i91.OrdersManager(_createOrdersRepository());
  _i92.OrdersRepository _createOrdersRepository() =>
      _i92.OrdersRepository(_createHttpClient());
  _i93.FormsModule _createFormsModule() => _i93.FormsModule(
      _createRequestGuideScreen(),
      _createAuthGuard(),
      _createLoginTypeSelectorScreen());
  _i94.RequestGuideScreen _createRequestGuideScreen() =>
      _i94.RequestGuideScreen(_createRequestGuideBloc(), _createLogger());
  _i95.RequestGuideBloc _createRequestGuideBloc() => _i95.RequestGuideBloc(
      _createRequestGuideService(), _createLocationDetailsService());
  @override
  _i6.MyApp get app => _createMyApp();
}
