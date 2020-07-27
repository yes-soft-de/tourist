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
import '../../ui/user/event_details/event_details_screen.dart' as _i29;
import '../../bloc/event_details/event_details.dart' as _i30;
import '../../services/event/event_service.dart' as _i31;
import '../../managers/event/event_manager.dart' as _i32;
import '../../repositories/event/event_repository.dart' as _i33;
import '../../services/location_list/location_list_service.dart' as _i34;
import '../../managers/location_list/location_list_manager.dart' as _i35;
import '../../repositories/location_list/location_list_repository.dart' as _i36;
import '../../ui/user/tourist_create_general_request/tourist_create_general_request.dart'
    as _i37;
import '../../ui/user/home/subscreens/tourist_guide_list/tourist_guide_list.dart'
    as _i38;
import '../../bloc/guide_list/guide_list_bloc.dart' as _i39;
import '../../ui/user/request_guide/request_guide_screen.dart' as _i40;
import '../../bloc/request_guide/request_guide.bloc.dart' as _i41;
import '../../services/request_guide/request_guide.service.dart' as _i42;
import '../../managers/request_guide/request_guide_manager.dart' as _i43;
import '../../repositories/request_guide/request_guide_repository.dart' as _i44;
import '../../services/location_details/location_details_service.dart' as _i45;
import '../../managers/location_details/location_details.dart' as _i46;
import '../../repositories/location_details/location_details_repository.dart'
    as _i47;
import '../../ui/user/home/home.dart' as _i48;
import '../../ui/user/home/subscreens/main/main_home.dart' as _i49;
import '../../bloc/main_home/main_home_bloc.dart' as _i50;
import '../../ui/user/location_details/location_details.dart' as _i51;
import '../../bloc/location_details/location_details_bloc.dart' as _i52;
import '../../managers/comment/comment_service.dart' as _i53;
import '../../repositories/comment/comment_repository.dart' as _i54;
import '../../ui/user/home/subscreens/tourist_event_list/tourist_event_list.dart'
    as _i55;
import '../../bloc/event_list/event_list_bloc.dart' as _i56;
import '../../ui/user/intention_profile/intention_profile.dart' as _i57;
import '../../bloc/create_intentions/create_intention_bloc.dart' as _i58;
import '../../services/intentions/intentions_service.dart' as _i59;
import '../../managers/intentions/intentions_manager.dart' as _i60;
import '../../repositories/intentions/intentions_repository.dart' as _i61;
import '../../components/guide/guide_component.dart' as _i62;
import '../../ui/guide/guide_login/guide_login.dart' as _i63;
import '../../bloc/guide_login/guide_login.bloc.dart' as _i64;
import '../../ui/guide/guide_home/guide_home.dart' as _i65;
import '../../ui/guide/guide_home/subscreens/main/guide_main_subscreen.dart'
    as _i66;
import '../../bloc/guide_home/guide_home.dart' as _i67;
import '../../ui/guide/guide_info/guide_info.dart' as _i68;
import '../../bloc/guide_register/guide_register.dart' as _i69;
import '../../services/guide_register/guide_register.dart' as _i70;
import '../../managers/guide_register/guide_register.dart' as _i71;
import '../../repositories/guide_register/guide_register.dart' as _i72;
import '../../components/shared/shared_component.dart' as _i73;
import '../../ui/shared/chat_page/chat_page.dart' as _i74;
import '../../bloc/chat_page/chat_page.bloc.dart' as _i75;
import '../../services/chat/char_service.dart' as _i76;
import '../../managers/chat/chat_manager.dart' as _i77;
import '../../repositories/chat/chat_repository.dart' as _i78;

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
      _createEventDetailsScreen(),
      _createTouristCreateGeneralRequestScreen(),
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
  _i29.EventDetailsScreen _createEventDetailsScreen() =>
      _i29.EventDetailsScreen(_createEventDetailsBloc());
  _i30.EventDetailsBloc _createEventDetailsBloc() => _i30.EventDetailsBloc(
      _createEventService(), _createLocationListService());
  _i31.EventService _createEventService() =>
      _i31.EventService(_createEventManager());
  _i32.EventManager _createEventManager() =>
      _i32.EventManager(_createEventRepository());
  _i33.EventRepository _createEventRepository() =>
      _i33.EventRepository(_createHttpClient());
  _i34.LocationListService _createLocationListService() =>
      _i34.LocationListService(_createLocationListManager());
  _i35.LocationListManager _createLocationListManager() =>
      _i35.LocationListManager(_createLocationListRepository());
  _i36.LocationListRepository _createLocationListRepository() =>
      _i36.LocationListRepository(_createHttpClient());
  _i37.TouristCreateGeneralRequestScreen
      _createTouristCreateGeneralRequestScreen() =>
          _i37.TouristCreateGeneralRequestScreen(
              _createTouristGuideListSubScreen());
  _i38.TouristGuideListSubScreen _createTouristGuideListSubScreen() =>
      _i38.TouristGuideListSubScreen(
          _createGuideListBloc(), _createRequestGuideScreen());
  _i39.GuideListBloc _createGuideListBloc() =>
      _i39.GuideListBloc(_createGuideListService());
  _i40.RequestGuideScreen _createRequestGuideScreen() =>
      _i40.RequestGuideScreen(_createRequestGuideBloc(), _createLogger());
  _i41.RequestGuideBloc _createRequestGuideBloc() => _i41.RequestGuideBloc(
      _createRequestGuideService(), _createLocationDetailsService());
  _i42.RequestGuideService _createRequestGuideService() =>
      _i42.RequestGuideService(_createSharedPreferencesHelper(),
          _createGuideListService(), _createRequestGuideManager());
  _i43.RequestGuideManager _createRequestGuideManager() =>
      _i43.RequestGuideManager(_createRequestGuideRepository());
  _i44.RequestGuideRepository _createRequestGuideRepository() =>
      _i44.RequestGuideRepository(_createHttpClient());
  _i45.LocationDetailsService _createLocationDetailsService() =>
      _i45.LocationDetailsService(
          _createLocationDetailsManager(), _createGuidesManager());
  _i46.LocationDetailsManager _createLocationDetailsManager() =>
      _i46.LocationDetailsManager(_createLocationDetailsRepository());
  _i47.LocationDetailsRepository _createLocationDetailsRepository() =>
      _i47.LocationDetailsRepository(_createHttpClient());
  _i48.HomeScreen _createHomeScreen() => _i48.HomeScreen(
      _createMainHomeSubScreen(),
      _createTouristGuideListSubScreen(),
      _createTouristEventListSubScreen(),
      _createSharedPreferencesHelper());
  _i49.MainHomeSubScreen _createMainHomeSubScreen() => _i49.MainHomeSubScreen(
      _createMainHomeBloc(), _createLocationDetailsScreen());
  _i50.MainHomeBloc _createMainHomeBloc() =>
      _i50.MainHomeBloc(_createLocationListService(), _createLogger());
  _i51.LocationDetailsScreen _createLocationDetailsScreen() =>
      _i51.LocationDetailsScreen(_createLocationDetailsBloc());
  _i52.LocationDetailsBloc _createLocationDetailsBloc() =>
      _i52.LocationDetailsBloc(_createLocationDetailsService(),
          _createSharedPreferencesHelper(), _createCommentManager());
  _i53.CommentManager _createCommentManager() =>
      _i53.CommentManager(_createCommentRepository());
  _i54.CommentRepository _createCommentRepository() =>
      _i54.CommentRepository(_createHttpClient());
  _i55.TouristEventListSubScreen _createTouristEventListSubScreen() =>
      _i55.TouristEventListSubScreen(_createEventListBloc());
  _i56.EventListBloc _createEventListBloc() =>
      _i56.EventListBloc(_createEventService());
  _i57.IntentionProfileScreen _createIntentionProfileScreen() =>
      _i57.IntentionProfileScreen(
          _createCreateIntentionBloc(), _createSharedPreferencesHelper());
  _i58.CreateIntentionBloc _createCreateIntentionBloc() =>
      _i58.CreateIntentionBloc(_createIntentionService());
  _i59.IntentionService _createIntentionService() =>
      _i59.IntentionService(_createIntentionsManager());
  _i60.IntentionsManager _createIntentionsManager() =>
      _i60.IntentionsManager(_createIntentionsRepository());
  _i61.IntentionsRepository _createIntentionsRepository() =>
      _i61.IntentionsRepository(_createHttpClient());
  _i62.GuideComponent _createGuideComponent() => _i62.GuideComponent(
      _createGuideLoginScreen(),
      _createGuideHomeScreen(),
      _createGuideInfoScreen());
  _i63.GuideLoginScreen _createGuideLoginScreen() =>
      _i63.GuideLoginScreen(_createGuideLoginBloc());
  _i64.GuideLoginBloc _createGuideLoginBloc() => _i64.GuideLoginBloc();
  _i65.GuideHomeScreen _createGuideHomeScreen() =>
      _i65.GuideHomeScreen(_createGuideMainSubScreen());
  _i66.GuideMainSubScreen _createGuideMainSubScreen() =>
      _i66.GuideMainSubScreen(_createGuideHomeBloc());
  _i67.GuideHomeBloc _createGuideHomeBloc() =>
      _i67.GuideHomeBloc(_createOrdersService());
  _i68.GuideInfoScreen _createGuideInfoScreen() => _i68.GuideInfoScreen(
      _createGuideRegisterBloc(), _createSharedPreferencesHelper());
  _i69.GuideRegisterBloc _createGuideRegisterBloc() =>
      _i69.GuideRegisterBloc(_createGuideRegisterService());
  _i70.GuideRegisterService _createGuideRegisterService() =>
      _i70.GuideRegisterService(_createGuideRegisterManager(),
          _createSharedPreferencesHelper(), _createGuideListService());
  _i71.GuideRegisterManager _createGuideRegisterManager() =>
      _i71.GuideRegisterManager(_createGuideRegisterRepository());
  _i72.GuideRegisterRepository _createGuideRegisterRepository() =>
      _i72.GuideRegisterRepository(_createHttpClient());
  _i73.SharedComponent _createSharedComponent() =>
      _i73.SharedComponent(_createChatPage());
  _i74.ChatPage _createChatPage() =>
      _i74.ChatPage(_createChatPageBloc(), _createSharedPreferencesHelper());
  _i75.ChatPageBloc _createChatPageBloc() =>
      _i75.ChatPageBloc(_createChatService());
  _i76.ChatService _createChatService() =>
      _i76.ChatService(_createChatManager(), _createSharedPreferencesHelper());
  _i77.ChatManager _createChatManager() =>
      _i77.ChatManager(_createChatRepository());
  _i78.ChatRepository _createChatRepository() => _i78.ChatRepository();
  @override
  _i5.MyApp get app => _createMyApp();
}
