import 'app.component.dart' as _i1;
import '../../utils/logger/logger.dart' as _i2;
import '../../network/http_client/http_client.dart' as _i3;
import 'dart:async' as _i4;
import '../../main.dart' as _i5;
import '../../components/user/user_component.dart' as _i6;
import '../../ui/user/login/login.dart' as _i7;
import '../../bloc/login/login.bloc.dart' as _i8;
import '../../services/login/login.service.dart' as _i9;
import '../../persistence/sharedpref/shared_preferences_helper.dart' as _i10;
import '../../ui/user/account_type_selector/login_type_selector.dart' as _i11;
import '../../ui/user/request_guide_success/request_guide_success.dart' as _i12;
import '../../ui/user/register/register.dart' as _i13;
import '../../bloc/register/register.bloc.dart' as _i14;
import '../../services/register/register.service.dart' as _i15;
import '../../ui/user/create_profile/create_profile.dart' as _i16;
import '../../bloc/create_profile/create_profile_bloc.dart' as _i17;
import '../../services/profile/profile.service.dart' as _i18;
import '../../managers/profile/profile.manager.dart' as _i19;
import '../../repositories/profile/profile.repository.dart' as _i20;
import '../../ui/user/orders_page/orders_page.dart' as _i21;
import '../../bloc/orders_list/orders_list_screen_bloc.dart' as _i22;
import '../../services/orders/orders_service.dart' as _i23;
import '../../managers/orders/orders_manager.dart' as _i24;
import '../../repositories/orders/orders.dart' as _i25;
import '../../services/guide_list/guide_list.dart' as _i26;
import '../../managers/guides_manager/guides_manager.dart' as _i27;
import '../../repositories/guides/guide_repository.dart' as _i28;
import '../../ui/user/home/home.dart' as _i29;
import '../../ui/user/home/subscreens/main/main_home.dart' as _i30;
import '../../bloc/main_home/main_home_bloc.dart' as _i31;
import '../../services/location_list/location_list_service.dart' as _i32;
import '../../managers/location_list/location_list_manager.dart' as _i33;
import '../../repositories/location_list/location_list_repository.dart' as _i34;
import '../../ui/user/location_details/location_details.dart' as _i35;
import '../../bloc/location_details/location_details_bloc.dart' as _i36;
import '../../services/location_details/location_details_service.dart' as _i37;
import '../../managers/location_details/location_details.dart' as _i38;
import '../../repositories/location_details/location_details_repository.dart'
    as _i39;
import '../../ui/user/home/subscreens/tourist_guide_list/tourist_guide_list.dart'
    as _i40;
import '../../bloc/guide_list/guide_list_bloc.dart' as _i41;
import '../../ui/user/request_guide/request_guide_screen.dart' as _i42;
import '../../bloc/request_guide/request_guide.bloc.dart' as _i43;
import '../../services/request_guide/request_guide.service.dart' as _i44;
import '../../managers/request_guide/request_guide_manager.dart' as _i45;
import '../../repositories/request_guide/request_guide_repository.dart' as _i46;
import '../../ui/user/home/subscreens/tourist_event_list/tourist_event_list.dart'
    as _i47;
import '../../bloc/event_list/event_list_bloc.dart' as _i48;
import '../../services/event/event_service.dart' as _i49;
import '../../managers/event/event_manager.dart' as _i50;
import '../../repositories/event/event_repository.dart' as _i51;
import '../../ui/user/intention_profile/intention_profile.dart' as _i52;
import '../../bloc/create_intentions/create_intention_bloc.dart' as _i53;
import '../../services/intentions/intentions_service.dart' as _i54;
import '../../managers/intentions/intentions_manager.dart' as _i55;
import '../../repositories/intentions/intentions_repository.dart' as _i56;
import '../../components/guide/guide_component.dart' as _i57;
import '../../ui/guide/guide_login/guide_login.dart' as _i58;
import '../../bloc/guide_login/guide_login.bloc.dart' as _i59;
import '../../ui/guide/guide_home/guide_home.dart' as _i60;
import '../../ui/guide/guide_home/subscreens/main/guide_main_subscreen.dart'
    as _i61;
import '../../bloc/guide_home/guide_home.dart' as _i62;
import '../../ui/guide/guide_info/guide_info.dart' as _i63;
import '../../bloc/guide_register/guide_register.dart' as _i64;
import '../../services/guide_register/guide_register.dart' as _i65;
import '../../managers/guide_register/guide_register.dart' as _i66;
import '../../repositories/guide_register/guide_register.dart' as _i67;
import '../../components/shared/shared_component.dart' as _i68;
import '../../ui/shared/chat_page/chat_page.dart' as _i69;
import '../../bloc/chat_page/chat_page.bloc.dart' as _i70;
import '../../services/chat/char_service.dart' as _i71;
import '../../managers/chat/chat_manager.dart' as _i72;
import '../../repositories/chat/chat_repository.dart' as _i73;

class AppComponent$Injector implements _i1.AppComponent {
  AppComponent$Injector._();

  _i2.Logger _singletonLogger;

  _i3.HttpClient _singletonHttpClient;

  static _i4.Future<_i1.AppComponent> create() async {
    final injector = AppComponent$Injector._();

    return injector;
  }

  _i5.MyApp _createMyApp() => _i5.MyApp(_createUserComponent(),
      _createGuideComponent(), _createSharedComponent());
  _i6.UserComponent _createUserComponent() => _i6.UserComponent(
      _createLoginScreen(),
      _createLoginTypeSelectorScreen(),
      _createRequestGuideSuccessScreen(),
      _createRegisterScreen(),
      _createCreateProfileScreen(),
      _createOrdersScreen(),
      _createHomeScreen(),
      _createIntentionProfileScreen(),
      _createLocationDetailsScreen(),
      _createRequestGuideScreen());
  _i7.LoginScreen _createLoginScreen() =>
      _i7.LoginScreen(_createLoginBloc(), _createSharedPreferencesHelper());
  _i8.LoginBloc _createLoginBloc() => _i8.LoginBloc(_createLoginService());
  _i9.LoginService _createLoginService() =>
      _i9.LoginService(_createSharedPreferencesHelper());
  _i10.SharedPreferencesHelper _createSharedPreferencesHelper() =>
      _i10.SharedPreferencesHelper();
  _i11.LoginTypeSelectorScreen _createLoginTypeSelectorScreen() =>
      _i11.LoginTypeSelectorScreen(_createSharedPreferencesHelper());
  _i12.RequestGuideSuccessScreen _createRequestGuideSuccessScreen() =>
      _i12.RequestGuideSuccessScreen();
  _i13.RegisterScreen _createRegisterScreen() =>
      _i13.RegisterScreen(_createRegisterBloc());
  _i14.RegisterBloc _createRegisterBloc() =>
      _i14.RegisterBloc(_createRegisterService());
  _i15.RegisterService _createRegisterService() =>
      _i15.RegisterService(_createSharedPreferencesHelper());
  _i16.CreateProfileScreen _createCreateProfileScreen() =>
      _i16.CreateProfileScreen(
          _createCreateProfileBloc(), _createSharedPreferencesHelper());
  _i17.CreateProfileBloc _createCreateProfileBloc() =>
      _i17.CreateProfileBloc(_createProfileService());
  _i18.ProfileService _createProfileService() => _i18.ProfileService(
      _createProfileManager(), _createSharedPreferencesHelper());
  _i19.ProfileManager _createProfileManager() =>
      _i19.ProfileManager(_createProfileRepository());
  _i20.ProfileRepository _createProfileRepository() =>
      _i20.ProfileRepository(_createHttpClient());
  _i3.HttpClient _createHttpClient() =>
      _singletonHttpClient ??= _i3.HttpClient(_createLogger());
  _i2.Logger _createLogger() => _singletonLogger ??= _i2.Logger();
  _i21.OrdersScreen _createOrdersScreen() =>
      _i21.OrdersScreen(_createOrdersListScreenBloc());
  _i22.OrdersListScreenBloc _createOrdersListScreenBloc() =>
      _i22.OrdersListScreenBloc(_createOrdersService());
  _i23.OrdersService _createOrdersService() => _i23.OrdersService(
      _createOrdersManager(),
      _createSharedPreferencesHelper(),
      _createGuideListService());
  _i24.OrdersManager _createOrdersManager() =>
      _i24.OrdersManager(_createOrdersRepository());
  _i25.OrdersRepository _createOrdersRepository() =>
      _i25.OrdersRepository(_createHttpClient());
  _i26.GuideListService _createGuideListService() =>
      _i26.GuideListService(_createGuidesManager());
  _i27.GuidesManager _createGuidesManager() =>
      _i27.GuidesManager(_createGuidesRepository());
  _i28.GuidesRepository _createGuidesRepository() =>
      _i28.GuidesRepository(_createHttpClient());
  _i29.HomeScreen _createHomeScreen() => _i29.HomeScreen(
      _createMainHomeSubScreen(),
      _createTouristGuideListSubScreen(),
      _createTouristEventListSubScreen(),
      _createSharedPreferencesHelper());
  _i30.MainHomeSubScreen _createMainHomeSubScreen() => _i30.MainHomeSubScreen(
      _createMainHomeBloc(), _createLocationDetailsScreen());
  _i31.MainHomeBloc _createMainHomeBloc() =>
      _i31.MainHomeBloc(_createLocationListService(), _createLogger());
  _i32.LocationListService _createLocationListService() =>
      _i32.LocationListService(_createLocationListManager());
  _i33.LocationListManager _createLocationListManager() =>
      _i33.LocationListManager(_createLocationListRepository());
  _i34.LocationListRepository _createLocationListRepository() =>
      _i34.LocationListRepository(_createHttpClient());
  _i35.LocationDetailsScreen _createLocationDetailsScreen() =>
      _i35.LocationDetailsScreen(_createLocationDetailsBloc());
  _i36.LocationDetailsBloc _createLocationDetailsBloc() =>
      _i36.LocationDetailsBloc(_createLocationDetailsService());
  _i37.LocationDetailsService _createLocationDetailsService() =>
      _i37.LocationDetailsService(
          _createLocationDetailsManager(), _createGuidesManager());
  _i38.LocationDetailsManager _createLocationDetailsManager() =>
      _i38.LocationDetailsManager(_createLocationDetailsRepository());
  _i39.LocationDetailsRepository _createLocationDetailsRepository() =>
      _i39.LocationDetailsRepository(_createHttpClient());
  _i40.TouristGuideListSubScreen _createTouristGuideListSubScreen() =>
      _i40.TouristGuideListSubScreen(
          _createGuideListBloc(), _createRequestGuideScreen());
  _i41.GuideListBloc _createGuideListBloc() =>
      _i41.GuideListBloc(_createGuideListService());
  _i42.RequestGuideScreen _createRequestGuideScreen() =>
      _i42.RequestGuideScreen(_createRequestGuideBloc(), _createLogger());
  _i43.RequestGuideBloc _createRequestGuideBloc() => _i43.RequestGuideBloc(
      _createRequestGuideService(), _createLocationDetailsService());
  _i44.RequestGuideService _createRequestGuideService() =>
      _i44.RequestGuideService(_createSharedPreferencesHelper(),
          _createGuideListService(), _createRequestGuideManager());
  _i45.RequestGuideManager _createRequestGuideManager() =>
      _i45.RequestGuideManager(_createRequestGuideRepository());
  _i46.RequestGuideRepository _createRequestGuideRepository() =>
      _i46.RequestGuideRepository(_createHttpClient());
  _i47.TouristEventListSubScreen _createTouristEventListSubScreen() =>
      _i47.TouristEventListSubScreen(_createEventListBloc());
  _i48.EventListBloc _createEventListBloc() =>
      _i48.EventListBloc(_createEventService());
  _i49.EventService _createEventService() =>
      _i49.EventService(_createEventManager());
  _i50.EventManager _createEventManager() =>
      _i50.EventManager(_createEventRepository());
  _i51.EventRepository _createEventRepository() =>
      _i51.EventRepository(_createHttpClient());
  _i52.IntentionProfileScreen _createIntentionProfileScreen() =>
      _i52.IntentionProfileScreen(
          _createCreateIntentionBloc(), _createSharedPreferencesHelper());
  _i53.CreateIntentionBloc _createCreateIntentionBloc() =>
      _i53.CreateIntentionBloc(_createIntentionService());
  _i54.IntentionService _createIntentionService() =>
      _i54.IntentionService(_createIntentionsManager());
  _i55.IntentionsManager _createIntentionsManager() =>
      _i55.IntentionsManager(_createIntentionsRepository());
  _i56.IntentionsRepository _createIntentionsRepository() =>
      _i56.IntentionsRepository(_createHttpClient());
  _i57.GuideComponent _createGuideComponent() => _i57.GuideComponent(
      _createGuideLoginScreen(),
      _createGuideHomeScreen(),
      _createGuideInfoScreen());
  _i58.GuideLoginScreen _createGuideLoginScreen() =>
      _i58.GuideLoginScreen(_createGuideLoginBloc());
  _i59.GuideLoginBloc _createGuideLoginBloc() => _i59.GuideLoginBloc();
  _i60.GuideHomeScreen _createGuideHomeScreen() =>
      _i60.GuideHomeScreen(_createGuideMainSubScreen());
  _i61.GuideMainSubScreen _createGuideMainSubScreen() =>
      _i61.GuideMainSubScreen(_createGuideHomeBloc());
  _i62.GuideHomeBloc _createGuideHomeBloc() =>
      _i62.GuideHomeBloc(_createOrdersService());
  _i63.GuideInfoScreen _createGuideInfoScreen() => _i63.GuideInfoScreen(
      _createGuideRegisterBloc(), _createSharedPreferencesHelper());
  _i64.GuideRegisterBloc _createGuideRegisterBloc() =>
      _i64.GuideRegisterBloc(_createGuideRegisterService());
  _i65.GuideRegisterService _createGuideRegisterService() =>
      _i65.GuideRegisterService(_createGuideRegisterManager(),
          _createSharedPreferencesHelper(), _createGuideListService());
  _i66.GuideRegisterManager _createGuideRegisterManager() =>
      _i66.GuideRegisterManager(_createGuideRegisterRepository());
  _i67.GuideRegisterRepository _createGuideRegisterRepository() =>
      _i67.GuideRegisterRepository(_createHttpClient());
  _i68.SharedComponent _createSharedComponent() =>
      _i68.SharedComponent(_createChatPage());
  _i69.ChatPage _createChatPage() =>
      _i69.ChatPage(_createChatPageBloc(), _createSharedPreferencesHelper());
  _i70.ChatPageBloc _createChatPageBloc() =>
      _i70.ChatPageBloc(_createChatService());
  _i71.ChatService _createChatService() =>
      _i71.ChatService(_createChatManager(), _createSharedPreferencesHelper());
  _i72.ChatManager _createChatManager() =>
      _i72.ChatManager(_createChatRepository());
  _i73.ChatRepository _createChatRepository() => _i73.ChatRepository();
  @override
  _i5.MyApp get app => _createMyApp();
}
