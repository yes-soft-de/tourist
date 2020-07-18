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
import '../../ui/user/home/home.dart' as _i21;
import '../../ui/user/home/subscreens/main/main_home.dart' as _i22;
import '../../bloc/main_home/main_home_bloc.dart' as _i23;
import '../../services/location_list/location_list_service.dart' as _i24;
import '../../managers/location_list/location_list_manager.dart' as _i25;
import '../../repositories/location_list/location_list_repository.dart' as _i26;
import '../../ui/user/location_details/location_details.dart' as _i27;
import '../../bloc/location_details/location_details_bloc.dart' as _i28;
import '../../services/location_details/location_details_service.dart' as _i29;
import '../../managers/location_details/location_details.dart' as _i30;
import '../../repositories/location_details/location_details_repository.dart'
    as _i31;
import '../../managers/guides_manager/guides_manager.dart' as _i32;
import '../../repositories/guides/guide_repository.dart' as _i33;
import '../../ui/user/request_guide/request_guide_screen.dart' as _i34;
import '../../bloc/request_guide/request_guide.bloc.dart' as _i35;
import '../../services/request_guide/request_guide.service.dart' as _i36;
import '../../services/guide_list/guide_list.dart' as _i37;
import '../../managers/request_guide/request_guide_manager.dart' as _i38;
import '../../repositories/request_guide/request_guide_repository.dart' as _i39;
import '../../ui/user/home/subscreens/tourist_guide_list/tourist_guide_list.dart'
    as _i40;
import '../../bloc/guide_list/guide_list_bloc.dart' as _i41;
import '../../ui/user/home/subscreens/tourist_event_list/tourist_event_list.dart'
    as _i42;
import '../../ui/user/tourist_orders/tourist_order.dart' as _i43;
import '../../ui/user/intention_profile/intention_profile.dart' as _i44;
import '../../bloc/create_intentions/create_intention_bloc.dart' as _i45;
import '../../services/intentions/intentions_service.dart' as _i46;
import '../../managers/intentions/intentions_manager.dart' as _i47;
import '../../repositories/intentions/intentions_repository.dart' as _i48;
import '../../components/guide/guide_component.dart' as _i49;
import '../../ui/guide/guide_login/guide_login.dart' as _i50;
import '../../bloc/guide_login/guide_login.bloc.dart' as _i51;
import '../../ui/guide/guide_home/guide_home.dart' as _i52;
import '../../ui/guide/guide_home/subscreens/main/guide_main_subscreen.dart'
    as _i53;
import '../../components/shared/shared_component.dart' as _i54;
import '../../ui/shared/chat_page/chat_page.dart' as _i55;
import '../../bloc/chat_page/chat_page.bloc.dart' as _i56;
import '../../services/chat/char_service.dart' as _i57;
import '../../managers/chat/chat_manager.dart' as _i58;
import '../../repositories/chat/chat_repository.dart' as _i59;

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
      _createHomeScreen(),
      _createIntentionProfileScreen(),
      _createLocationDetailsScreen(),
      _createRequestGuideScreen());
  _i7.LoginScreen _createLoginScreen() => _i7.LoginScreen(_createLoginBloc());
  _i8.LoginBloc _createLoginBloc() => _i8.LoginBloc(_createLoginService());
  _i9.LoginService _createLoginService() =>
      _i9.LoginService(_createSharedPreferencesHelper());
  _i10.SharedPreferencesHelper _createSharedPreferencesHelper() =>
      _i10.SharedPreferencesHelper();
  _i11.LoginTypeSelectorScreen _createLoginTypeSelectorScreen() =>
      _i11.LoginTypeSelectorScreen();
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
  _i21.HomeScreen _createHomeScreen() => _i21.HomeScreen(
      _createMainHomeSubScreen(),
      _createTouristGuideListSubScreen(),
      _createTouristEventListSubScreen(),
      _createTouristOrdersScreen(),
      _createSharedPreferencesHelper());
  _i22.MainHomeSubScreen _createMainHomeSubScreen() => _i22.MainHomeSubScreen(
      _createMainHomeBloc(), _createLocationDetailsScreen());
  _i23.MainHomeBloc _createMainHomeBloc() =>
      _i23.MainHomeBloc(_createLocationListService(), _createLogger());
  _i24.LocationListService _createLocationListService() =>
      _i24.LocationListService(_createLocationListManager());
  _i25.LocationListManager _createLocationListManager() =>
      _i25.LocationListManager(_createLocationListRepository());
  _i26.LocationListRepository _createLocationListRepository() =>
      _i26.LocationListRepository(_createHttpClient());
  _i27.LocationDetailsScreen _createLocationDetailsScreen() =>
      _i27.LocationDetailsScreen(
          _createLocationDetailsBloc(), _createRequestGuideScreen());
  _i28.LocationDetailsBloc _createLocationDetailsBloc() =>
      _i28.LocationDetailsBloc(_createLocationDetailsService());
  _i29.LocationDetailsService _createLocationDetailsService() =>
      _i29.LocationDetailsService(
          _createLocationDetailsManager(), _createGuidesManager());
  _i30.LocationDetailsManager _createLocationDetailsManager() =>
      _i30.LocationDetailsManager(_createLocationDetailsRepository());
  _i31.LocationDetailsRepository _createLocationDetailsRepository() =>
      _i31.LocationDetailsRepository(_createHttpClient());
  _i32.GuidesManager _createGuidesManager() =>
      _i32.GuidesManager(_createGuidesRepository());
  _i33.GuidesRepository _createGuidesRepository() =>
      _i33.GuidesRepository(_createHttpClient());
  _i34.RequestGuideScreen _createRequestGuideScreen() =>
      _i34.RequestGuideScreen(_createRequestGuideBloc(), _createLogger());
  _i35.RequestGuideBloc _createRequestGuideBloc() =>
      _i35.RequestGuideBloc(_createRequestGuideService());
  _i36.RequestGuideService _createRequestGuideService() =>
      _i36.RequestGuideService(_createSharedPreferencesHelper(),
          _createGuideListService(), _createRequestGuideManager());
  _i37.GuideListService _createGuideListService() =>
      _i37.GuideListService(_createGuidesManager());
  _i38.RequestGuideManager _createRequestGuideManager() =>
      _i38.RequestGuideManager(_createRequestGuideRepository());
  _i39.RequestGuideRepository _createRequestGuideRepository() =>
      _i39.RequestGuideRepository(_createHttpClient());
  _i40.TouristGuideListSubScreen _createTouristGuideListSubScreen() =>
      _i40.TouristGuideListSubScreen(
          _createGuideListBloc(), _createRequestGuideScreen());
  _i41.GuideListBloc _createGuideListBloc() =>
      _i41.GuideListBloc(_createGuideListService());
  _i42.TouristEventListSubScreen _createTouristEventListSubScreen() =>
      _i42.TouristEventListSubScreen();
  _i43.TouristOrdersScreen _createTouristOrdersScreen() =>
      _i43.TouristOrdersScreen();
  _i44.IntentionProfileScreen _createIntentionProfileScreen() =>
      _i44.IntentionProfileScreen(_createCreateIntentionBloc());
  _i45.CreateIntentionBloc _createCreateIntentionBloc() =>
      _i45.CreateIntentionBloc(_createIntentionService());
  _i46.IntentionService _createIntentionService() =>
      _i46.IntentionService(_createIntentionsManager());
  _i47.IntentionsManager _createIntentionsManager() =>
      _i47.IntentionsManager(_createIntentionsRepository());
  _i48.IntentionsRepository _createIntentionsRepository() =>
      _i48.IntentionsRepository(_createHttpClient());
  _i49.GuideComponent _createGuideComponent() =>
      _i49.GuideComponent(_createGuideLoginScreen(), _createGuideHomeScreen());
  _i50.GuideLoginScreen _createGuideLoginScreen() =>
      _i50.GuideLoginScreen(_createGuideLoginBloc());
  _i51.GuideLoginBloc _createGuideLoginBloc() => _i51.GuideLoginBloc();
  _i52.GuideHomeScreen _createGuideHomeScreen() =>
      _i52.GuideHomeScreen(_createGuideMainSubScreen());
  _i53.GuideMainSubScreen _createGuideMainSubScreen() =>
      _i53.GuideMainSubScreen();
  _i54.SharedComponent _createSharedComponent() =>
      _i54.SharedComponent(_createChatPage());
  _i55.ChatPage _createChatPage() =>
      _i55.ChatPage(_createChatPageBloc(), _createSharedPreferencesHelper());
  _i56.ChatPageBloc _createChatPageBloc() =>
      _i56.ChatPageBloc(_createChatService());
  _i57.ChatService _createChatService() =>
      _i57.ChatService(_createChatManager(), _createSharedPreferencesHelper());
  _i58.ChatManager _createChatManager() =>
      _i58.ChatManager(_createChatRepository());
  _i59.ChatRepository _createChatRepository() => _i59.ChatRepository();
  @override
  _i5.MyApp get app => _createMyApp();
}
