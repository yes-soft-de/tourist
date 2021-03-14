import 'app.component.dart' as _i1;
import '../../utils/logger/logger.dart' as _i2;
import '../../module_locations/bloc/location_list/location_list_bloc.dart'
    as _i3;
import '../../utils/auth_guard/auth_gard.dart' as _i4;
import 'dart:async' as _i5;
import '../../main.dart' as _i6;
import '../../utils/language/language.dart' as _i7;
import '../../module_persistence/sharedpref/shared_preferences_helper.dart'
    as _i8;
import '../../module_auth/authoriazation_module.dart' as _i9;
import '../../module_auth/ui/screen/login_screen/login_screen.dart' as _i10;
import '../../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i11;
import '../../module_auth/service/auth_service/auth_service.dart' as _i12;
import '../../module_auth/presistance/auth_prefs_helper.dart' as _i13;
import '../../module_auth/manager/auth_manager/auth_manager.dart' as _i14;
import '../../module_auth/repository/auth/auth_repository.dart' as _i15;
import '../../module_settings/settings_module.dart' as _i16;
import '../../module_settings/ui/settings/settings.dart' as _i17;
import '../../module_home/home_module.dart' as _i18;
import '../../module_home/ui/screens/guide_home/guide_home.dart' as _i19;
import '../../module_orders/ui/screen/guide_orders/guide_orders.dart' as _i20;
import '../../module_orders/bloc/guide_orders_list/guide_orders_list.dart'
    as _i21;
import '../../module_orders/service/guide_orders/guide_orders.dart' as _i22;
import '../../module_orders/manager/guide_orders/guide_orders.dart' as _i23;
import '../../module_orders/repository/guide_orders/guide_orders.dart' as _i24;
import '../../module_network/http_client/http_client.dart' as _i25;
import '../../module_locations/ui/screens/location_list/location_list_screen.dart'
    as _i26;
import '../../module_locations/service/location_list/location_list_service.dart'
    as _i27;
import '../../module_locations/manager/location_list/location_list_manager.dart'
    as _i28;
import '../../module_locations/repository/location_list/location_list_repository.dart'
    as _i29;
import '../../module_locations/ui/screens/event_list/event_list.dart' as _i30;
import '../../module_locations/bloc/event_list/event_list_bloc.dart' as _i31;
import '../../module_locations/service/event/event_service.dart' as _i32;
import '../../module_locations/manager/event/event_manager.dart' as _i33;
import '../../module_locations/repository/event/event_repository.dart' as _i34;
import '../../module_home/ui/screens/home/home.dart' as _i35;
import '../../module_guide/ui/screen/guide_list/guide_list_screen.dart' as _i36;
import '../../module_guide/bloc/guide_list/guide_list_bloc.dart' as _i37;
import '../../module_guide/service/guide_list/guide_list.dart' as _i38;
import '../../module_guide/manager/guides_manager/guides_manager.dart' as _i39;
import '../../module_guide/repository/guides/guide_repository.dart' as _i40;
import '../../module_locations/ui/screens/location_carousel/location_carousel.dart'
    as _i41;
import '../../module_splash/splash_module.dart' as _i42;
import '../../module_splash/ui/screen/splash_screen.dart' as _i43;
import '../../module_chat/chat_module.dart' as _i44;
import '../../module_chat/ui/screens/chat_page/chat_page.dart' as _i45;
import '../../module_chat/bloc/chat_page/chat_page.bloc.dart' as _i46;
import '../../module_chat/service/chat/char_service.dart' as _i47;
import '../../module_chat/manager/chat/chat_manager.dart' as _i48;
import '../../module_chat/repository/chat/chat_repository.dart' as _i49;
import '../../module_locations/location_module.dart' as _i50;
import '../../module_locations/ui/screens/location_details/location_details.dart'
    as _i51;
import '../../module_locations/bloc/location_details/location_details_bloc.dart'
    as _i52;
import '../../module_locations/service/location_details/location_details_service.dart'
    as _i53;
import '../../module_locations/manager/location_details/location_details.dart'
    as _i54;
import '../../module_locations/repository/location_details/location_details_repository.dart'
    as _i55;
import '../../module_comment/manager/rate/rate_manager.dart' as _i56;
import '../../module_comment/repository/rating/rating_repository.dart' as _i57;
import '../../module_locations/service/google_locations/google_locations_service.dart'
    as _i58;
import '../../module_locations/manager/google_locations/google_locations_manager.dart'
    as _i59;
import '../../module_locations/repository/google_location/google_location_repository.dart'
    as _i60;
import '../../module_locations/service/prefs/location_prefs.dart' as _i61;
import '../../module_comment/manager/comment/comment_service.dart' as _i62;
import '../../module_comment/repository/comment/comment_repository.dart'
    as _i63;
import '../../module_locations/ui/screens/event_details/event_details_screen.dart'
    as _i64;
import '../../module_locations/bloc/event_details/event_details.dart' as _i65;
import '../../module_locations/ui/screens/add_location/add_location.dart'
    as _i66;
import '../../module_locations/bloc/add_location/add_location.dart' as _i67;
import '../../module_upload/service/image_upload/image_upload_service.dart'
    as _i68;
import '../../module_upload/manager/upload_manager/upload_manager.dart' as _i69;
import '../../module_upload/repository/upload_repository/upload_repository.dart'
    as _i70;
import '../../module_guide/guide_list_module.dart' as _i71;
import '../../module_orders/order_module.dart' as _i72;
import '../../module_orders/ui/screen/orders_list/order_list_screen.dart'
    as _i73;
import '../../module_orders/bloc/orders_list_bloc/orders_list_bloc.dart'
    as _i74;
import '../../module_orders/service/orders/orders_service.dart' as _i75;
import '../../module_orders/manager/orders/orders_manager.dart' as _i76;
import '../../module_orders/repository/orders/orders.dart' as _i77;
import '../../module_forms/forms_module.dart' as _i78;
import '../../module_forms/user_orders_module/ui/screens/request_guide/request_guide_screen.dart'
    as _i79;
import '../../module_forms/user_orders_module/bloc/request_guide/request_guide.bloc.dart'
    as _i80;
import '../../module_forms/user_orders_module/service/request_guide/request_guide.service.dart'
    as _i81;
import '../../module_forms/user_orders_module/manager/request_manager/request_guide_manager.dart'
    as _i82;
import '../../module_forms/user_orders_module/repository/request_guide/request_guide_repository.dart'
    as _i83;
import '../../module_search/search_module.dart' as _i84;
import '../../module_search/ui/screen/search_screen/search_screen.dart' as _i85;
import '../../module_search/bloc/search_bloc/search_bloc.dart' as _i86;
import '../../module_profile/profile_module.dart' as _i87;
import '../../module_profile/ui/my_profile/my_profile.dart' as _i88;
import '../../module_profile/state_manager/my_profile/my_profile_state_manager.dart'
    as _i89;
import '../../module_profile/service/profile/profile_service.dart' as _i90;
import '../../module_profile/manager/my_profile_manager/my_profile_manager.dart'
    as _i91;
import '../../module_profile/repository/my_profile/my_profile.dart' as _i92;
import '../../module_profile/presistance/profile_shared_preferences.dart'
    as _i93;

class AppComponent$Injector implements _i1.AppComponent {
  AppComponent$Injector._();

  _i2.Logger _singletonLogger;

  _i3.LocationListBloc _singletonLocationListBloc;

  _i4.AuthGuard _singletonAuthGuard;

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
      _createFormsModule(),
      _createAuthService(),
      _createSearchModule(),
      _createProfileModule());
  _i7.LanguageHelper _createLanguageHelper() =>
      _i7.LanguageHelper(_createSharedPreferencesHelper());
  _i8.SharedPreferencesHelper _createSharedPreferencesHelper() =>
      _i8.SharedPreferencesHelper();
  _i9.AuthorizationModule _createAuthorizationModule() =>
      _i9.AuthorizationModule(_createLoginScreen());
  _i10.LoginScreen _createLoginScreen() =>
      _i10.LoginScreen(_createLoginStateManager());
  _i11.LoginStateManager _createLoginStateManager() =>
      _i11.LoginStateManager(_createAuthService());
  _i12.AuthService _createAuthService() =>
      _i12.AuthService(_createAuthPrefsHelper(), _createAuthManager());
  _i13.AuthPrefsHelper _createAuthPrefsHelper() => _i13.AuthPrefsHelper();
  _i14.AuthManager _createAuthManager() =>
      _i14.AuthManager(_createAuthRepository());
  _i15.AuthRepository _createAuthRepository() => _i15.AuthRepository();
  _i16.SettingsModule _createSettingsModule() =>
      _i16.SettingsModule(_createSettingsScreen());
  _i17.SettingsScreen _createSettingsScreen() =>
      _i17.SettingsScreen(_createLanguageHelper(), _createAuthService());
  _i18.HomeModule _createHomeModule() => _i18.HomeModule(
      _createGuideHomeScreen(), _createHomeScreen(), _createAuthGuard());
  _i19.GuideHomeScreen _createGuideHomeScreen() => _i19.GuideHomeScreen(
      _createGuideOrdersScreen(),
      _createLocationListScreen(),
      _createEventListScreen(),
      _createSharedPreferencesHelper());
  _i20.GuideOrdersScreen _createGuideOrdersScreen() =>
      _i20.GuideOrdersScreen(_createGuideOrdersListBloc());
  _i21.GuideOrdersListBloc _createGuideOrdersListBloc() =>
      _i21.GuideOrdersListBloc(_createGuideOrdersService());
  _i22.GuideOrdersService _createGuideOrdersService() =>
      _i22.GuideOrdersService(_createGuideOrdersManager());
  _i23.GuideOrdersManager _createGuideOrdersManager() =>
      _i23.GuideOrdersManager(_createGuideOrdersRepository());
  _i24.GuideOrdersRepository _createGuideOrdersRepository() =>
      _i24.GuideOrdersRepository(_createHttpClient());
  _i25.HttpClient _createHttpClient() => _i25.HttpClient();
  _i26.LocationListScreen _createLocationListScreen() =>
      _i26.LocationListScreen(_createLocationListBloc());
  _i3.LocationListBloc _createLocationListBloc() =>
      _singletonLocationListBloc ??=
          _i3.LocationListBloc(_createLocationListService(), _createLogger());
  _i27.LocationListService _createLocationListService() =>
      _i27.LocationListService(_createLocationListManager());
  _i28.LocationListManager _createLocationListManager() =>
      _i28.LocationListManager(_createLocationListRepository());
  _i29.LocationListRepository _createLocationListRepository() =>
      _i29.LocationListRepository(_createHttpClient());
  _i2.Logger _createLogger() => _singletonLogger ??= _i2.Logger();
  _i30.EventListScreen _createEventListScreen() =>
      _i30.EventListScreen(_createEventListBloc());
  _i31.EventListBloc _createEventListBloc() =>
      _i31.EventListBloc(_createEventService());
  _i32.EventService _createEventService() =>
      _i32.EventService(_createEventManager());
  _i33.EventManager _createEventManager() =>
      _i33.EventManager(_createEventRepository());
  _i34.EventRepository _createEventRepository() =>
      _i34.EventRepository(_createHttpClient());
  _i35.HomeScreen _createHomeScreen() => _i35.HomeScreen(
      _createLocationListScreen(),
      _createGuideListScreen(),
      _createEventListScreen(),
      _createAuthService(),
      _createLocationCarouselScreen());
  _i36.GuideListScreen _createGuideListScreen() =>
      _i36.GuideListScreen(_createGuideListBloc());
  _i37.GuideListBloc _createGuideListBloc() =>
      _i37.GuideListBloc(_createGuideListService(), _createAuthService());
  _i38.GuideListService _createGuideListService() =>
      _i38.GuideListService(_createGuidesManager());
  _i39.GuidesManager _createGuidesManager() =>
      _i39.GuidesManager(_createGuidesRepository());
  _i40.GuidesRepository _createGuidesRepository() =>
      _i40.GuidesRepository(_createHttpClient());
  _i41.LocationCarouselScreen _createLocationCarouselScreen() =>
      _i41.LocationCarouselScreen(_createLocationListBloc());
  _i4.AuthGuard _createAuthGuard() =>
      _singletonAuthGuard ??= _i4.AuthGuard(_createSharedPreferencesHelper());
  _i42.SplashModule _createSplashModule() =>
      _i42.SplashModule(_createSplashScreen());
  _i43.SplashScreen _createSplashScreen() =>
      _i43.SplashScreen(_createLanguageHelper());
  _i44.ChatModule _createChatModule() => _i44.ChatModule(_createChatPage());
  _i45.ChatPage _createChatPage() => _i45.ChatPage(_createChatPageBloc());
  _i46.ChatPageBloc _createChatPageBloc() =>
      _i46.ChatPageBloc(_createChatService());
  _i47.ChatService _createChatService() =>
      _i47.ChatService(_createChatManager());
  _i48.ChatManager _createChatManager() =>
      _i48.ChatManager(_createChatRepository());
  _i49.ChatRepository _createChatRepository() => _i49.ChatRepository();
  _i50.LocationModule _createLocationModule() => _i50.LocationModule(
      _createLocationDetailsScreen(),
      _createEventDetailsScreen(),
      _createAddLocationScreen());
  _i51.LocationDetailsScreen _createLocationDetailsScreen() =>
      _i51.LocationDetailsScreen(
          _createLocationDetailsBloc(), _createAuthGuard());
  _i52.LocationDetailsBloc _createLocationDetailsBloc() =>
      _i52.LocationDetailsBloc(
          _createLocationDetailsService(),
          _createSharedPreferencesHelper(),
          _createCommentManager(),
          _createAuthService());
  _i53.LocationDetailsService _createLocationDetailsService() =>
      _i53.LocationDetailsService(
          _createLocationDetailsManager(),
          _createGuidesManager(),
          _createRatingManager(),
          _createSharedPreferencesHelper(),
          _createGoogleLocationsService());
  _i54.LocationDetailsManager _createLocationDetailsManager() =>
      _i54.LocationDetailsManager(_createLocationDetailsRepository());
  _i55.LocationDetailsRepository _createLocationDetailsRepository() =>
      _i55.LocationDetailsRepository(_createHttpClient());
  _i56.RatingManager _createRatingManager() =>
      _i56.RatingManager(_createRatingRepository());
  _i57.RatingRepository _createRatingRepository() =>
      _i57.RatingRepository(_createHttpClient());
  _i58.GoogleLocationsService _createGoogleLocationsService() =>
      _i58.GoogleLocationsService(
          _createGoogleLocationsManager(), _createLocationPreferencesHelper());
  _i59.GoogleLocationsManager _createGoogleLocationsManager() =>
      _i59.GoogleLocationsManager(_createGoogleLocationRepository());
  _i60.GoogleLocationRepository _createGoogleLocationRepository() =>
      _i60.GoogleLocationRepository();
  _i61.LocationPreferencesHelper _createLocationPreferencesHelper() =>
      _i61.LocationPreferencesHelper();
  _i62.CommentManager _createCommentManager() =>
      _i62.CommentManager(_createCommentRepository());
  _i63.CommentRepository _createCommentRepository() =>
      _i63.CommentRepository(_createAuthService());
  _i64.EventDetailsScreen _createEventDetailsScreen() =>
      _i64.EventDetailsScreen(_createEventDetailsBloc());
  _i65.EventDetailsBloc _createEventDetailsBloc() => _i65.EventDetailsBloc(
      _createEventService(), _createLocationListService());
  _i66.AddLocationScreen _createAddLocationScreen() =>
      _i66.AddLocationScreen(_createAddLocationBloc());
  _i67.AddLocationBloc _createAddLocationBloc() => _i67.AddLocationBloc(
      _createImageUploadService(), _createLocationDetailsService());
  _i68.ImageUploadService _createImageUploadService() =>
      _i68.ImageUploadService(_createUploadManager());
  _i69.UploadManager _createUploadManager() =>
      _i69.UploadManager(_createUploadRepository());
  _i70.UploadRepository _createUploadRepository() => _i70.UploadRepository();
  _i71.GuideListModule _createGuideListModule() => _i71.GuideListModule();
  _i72.OrderModule _createOrderModule() =>
      _i72.OrderModule(_createOrdersListScreen());
  _i73.OrdersListScreen _createOrdersListScreen() =>
      _i73.OrdersListScreen(_createOrdersListBloc());
  _i74.OrdersListBloc _createOrdersListBloc() =>
      _i74.OrdersListBloc(_createOrdersService());
  _i75.OrdersService _createOrdersService() =>
      _i75.OrdersService(_createOrdersManager(), _createGuideListService());
  _i76.OrdersManager _createOrdersManager() =>
      _i76.OrdersManager(_createOrdersRepository());
  _i77.OrdersRepository _createOrdersRepository() =>
      _i77.OrdersRepository(_createHttpClient());
  _i78.FormsModule _createFormsModule() =>
      _i78.FormsModule(_createRequestGuideScreen());
  _i79.RequestGuideScreen _createRequestGuideScreen() =>
      _i79.RequestGuideScreen(_createRequestGuideBloc(), _createLogger());
  _i80.RequestGuideBloc _createRequestGuideBloc() => _i80.RequestGuideBloc(
      _createRequestGuideService(), _createLocationDetailsService());
  _i81.RequestGuideService _createRequestGuideService() =>
      _i81.RequestGuideService(
          _createGuideListService(), _createRequestGuideManager());
  _i82.RequestGuideManager _createRequestGuideManager() =>
      _i82.RequestGuideManager(_createRequestGuideRepository());
  _i83.RequestGuideRepository _createRequestGuideRepository() =>
      _i83.RequestGuideRepository(_createHttpClient());
  _i84.SearchModule _createSearchModule() =>
      _i84.SearchModule(_createSearchScreen());
  _i85.SearchScreen _createSearchScreen() =>
      _i85.SearchScreen(_createSearchBloc());
  _i86.SearchBloc _createSearchBloc() =>
      _i86.SearchBloc(_createGoogleLocationsService());
  _i87.ProfileModule _createProfileModule() =>
      _i87.ProfileModule(_createMyProfileScreen());
  _i88.MyProfileScreen _createMyProfileScreen() =>
      _i88.MyProfileScreen(_createMyProfileStateManager());
  _i89.MyProfileStateManager _createMyProfileStateManager() =>
      _i89.MyProfileStateManager(_createImageUploadService(),
          _createProfileService(), _createAuthService(), _createSearchBloc());
  _i90.ProfileService _createProfileService() => _i90.ProfileService(
      _createMyProfileManager(),
      _createProfileSharedPreferencesHelper(),
      _createAuthService(),
      _createLocationListService());
  _i91.MyProfileManager _createMyProfileManager() =>
      _i91.MyProfileManager(_createMyProfileRepository());
  _i92.MyProfileRepository _createMyProfileRepository() =>
      _i92.MyProfileRepository();
  _i93.ProfileSharedPreferencesHelper _createProfileSharedPreferencesHelper() =>
      _i93.ProfileSharedPreferencesHelper();
  @override
  _i6.MyApp get app => _createMyApp();
}
