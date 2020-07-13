import 'app.component.dart' as _i1;
import '../../network/http_client/http_client.dart' as _i2;
import 'dart:async' as _i3;
import '../../main.dart' as _i4;
import '../../components/user/user_component.dart' as _i5;
import '../../ui/user/login/login.dart' as _i6;
import '../../bloc/login/login.bloc.dart' as _i7;
import '../../services/login/login.service.dart' as _i8;
import '../../persistence/sharedpref/shared_preferences_helper.dart' as _i9;
import '../../ui/user/account_type_selector/login_type_selector.dart' as _i10;
import '../../ui/user/request_guide_success/request_guide_success.dart' as _i11;
import '../../ui/user/register/register.dart' as _i12;
import '../../bloc/register/register.bloc.dart' as _i13;
import '../../services/register/register.service.dart' as _i14;
import '../../ui/user/create_profile/create_profile.dart' as _i15;
import '../../bloc/create_profile/create_profile_bloc.dart' as _i16;
import '../../services/profile/profile.service.dart' as _i17;
import '../../managers/profile/profile.manager.dart' as _i18;
import '../../repositories/profile/profile.repository.dart' as _i19;
import '../../ui/user/home/home.dart' as _i20;
import '../../ui/user/home/subscreens/main/main_home.dart' as _i21;
import '../../bloc/main_home/main_home_bloc.dart' as _i22;
import '../../services/location_list/location_list_service.dart' as _i23;
import '../../managers/location_list/location_list_manager.dart' as _i24;
import '../../repositories/location_list/location_list_repository.dart' as _i25;
import '../../ui/user/location_details/location_details.dart' as _i26;
import '../../bloc/location_details/location_details_bloc.dart' as _i27;
import '../../services/location_details/location_details_service.dart' as _i28;
import '../../managers/location_details/location_details.dart' as _i29;
import '../../repositories/location_details/location_details_repository.dart'
    as _i30;
import '../../managers/guides_manager/guides_manager.dart' as _i31;
import '../../repositories/guides/guide_repository.dart' as _i32;
import '../../ui/user/request_guide/request_guide_screen.dart' as _i33;
import '../../bloc/request_guide/request_guide.bloc.dart' as _i34;
import '../../services/request_guide/request_guide.service.dart' as _i35;
import '../../services/guide_list/guide_list.dart' as _i36;
import '../../ui/user/home/subscreens/tourist_guide_list/tourist_guide_list.dart'
    as _i37;
import '../../bloc/guide_list/guide_list_bloc.dart' as _i38;
import '../../ui/user/home/subscreens/tourist_event_list/tourist_event_list.dart'
    as _i39;
import '../../ui/user/tourist_orders/tourist_order.dart' as _i40;
import '../../ui/user/intention_profile/intention_profile.dart' as _i41;
import '../../bloc/create_intentions/create_intention_bloc.dart' as _i42;
import '../../services/intentions/intentions_service.dart' as _i43;
import '../../managers/intentions/intentions_manager.dart' as _i44;
import '../../repositories/intentions/intentions_repository.dart' as _i45;
import '../../ui/user/order_guide/order_guide.dart' as _i46;
import '../../components/guide/guide_component.dart' as _i47;
import '../../ui/guide/guide_login/guide_login.dart' as _i48;
import '../../bloc/guide_login/guide_login.bloc.dart' as _i49;
import '../../ui/guide/guide_home/guide_home.dart' as _i50;
import '../../ui/guide/guide_home/subscreens/main/guide_main_subscreen.dart'
    as _i51;
import '../../components/shared/shared_component.dart' as _i52;
import '../../ui/shared/chat_page/chat_page.dart' as _i53;
import '../../bloc/chat_page/chat_page.bloc.dart' as _i54;

class AppComponent$Injector implements _i1.AppComponent {
  AppComponent$Injector._();

  _i2.HttpClient _singletonHttpClient;

  static _i3.Future<_i1.AppComponent> create() async {
    final injector = AppComponent$Injector._();

    return injector;
  }

  _i4.MyApp _createMyApp() => _i4.MyApp(_createUserComponent(),
      _createGuideComponent(), _createSharedComponent());
  _i5.UserComponent _createUserComponent() => _i5.UserComponent(
      _createLoginScreen(),
      _createLoginTypeSelectorScreen(),
      _createRequestGuideSuccessScreen(),
      _createRegisterScreen(),
      _createCreateProfileScreen(),
      _createHomeScreen(),
      _createIntentionProfileScreen(),
      _createLocationDetailsScreen(),
      _createOrderGuideScreen());
  _i6.LoginScreen _createLoginScreen() => _i6.LoginScreen(_createLoginBloc());
  _i7.LoginBloc _createLoginBloc() => _i7.LoginBloc(_createLoginService());
  _i8.LoginService _createLoginService() =>
      _i8.LoginService(_createSharedPreferencesHelper());
  _i9.SharedPreferencesHelper _createSharedPreferencesHelper() =>
      _i9.SharedPreferencesHelper();
  _i10.LoginTypeSelectorScreen _createLoginTypeSelectorScreen() =>
      _i10.LoginTypeSelectorScreen();
  _i11.RequestGuideSuccessScreen _createRequestGuideSuccessScreen() =>
      _i11.RequestGuideSuccessScreen();
  _i12.RegisterScreen _createRegisterScreen() =>
      _i12.RegisterScreen(_createRegisterBloc());
  _i13.RegisterBloc _createRegisterBloc() =>
      _i13.RegisterBloc(_createRegisterService());
  _i14.RegisterService _createRegisterService() =>
      _i14.RegisterService(_createSharedPreferencesHelper());
  _i15.CreateProfileScreen _createCreateProfileScreen() =>
      _i15.CreateProfileScreen(
          _createCreateProfileBloc(), _createSharedPreferencesHelper());
  _i16.CreateProfileBloc _createCreateProfileBloc() =>
      _i16.CreateProfileBloc(_createProfileService());
  _i17.ProfileService _createProfileService() => _i17.ProfileService(
      _createProfileManager(), _createSharedPreferencesHelper());
  _i18.ProfileManager _createProfileManager() =>
      _i18.ProfileManager(_createProfileRepository());
  _i19.ProfileRepository _createProfileRepository() =>
      _i19.ProfileRepository(_createHttpClient());
  _i2.HttpClient _createHttpClient() =>
      _singletonHttpClient ??= _i2.HttpClient();
  _i20.HomeScreen _createHomeScreen() => _i20.HomeScreen(
      _createMainHomeSubScreen(),
      _createTouristGuideListSubScreen(),
      _createTouristEventListSubScreen(),
      _createTouristOrdersScreen(),
      _createSharedPreferencesHelper());
  _i21.MainHomeSubScreen _createMainHomeSubScreen() => _i21.MainHomeSubScreen(
      _createMainHomeBloc(), _createLocationDetailsScreen());
  _i22.MainHomeBloc _createMainHomeBloc() =>
      _i22.MainHomeBloc(_createLocationListService());
  _i23.LocationListService _createLocationListService() =>
      _i23.LocationListService(_createLocationListManager());
  _i24.LocationListManager _createLocationListManager() =>
      _i24.LocationListManager(_createLocationListRepository());
  _i25.LocationListRepository _createLocationListRepository() =>
      _i25.LocationListRepository(_createHttpClient());
  _i26.LocationDetailsScreen _createLocationDetailsScreen() =>
      _i26.LocationDetailsScreen(
          _createLocationDetailsBloc(), _createRequestGuideScreen());
  _i27.LocationDetailsBloc _createLocationDetailsBloc() =>
      _i27.LocationDetailsBloc(_createLocationDetailsService());
  _i28.LocationDetailsService _createLocationDetailsService() =>
      _i28.LocationDetailsService(
          _createLocationDetailsManager(), _createGuidesManager());
  _i29.LocationDetailsManager _createLocationDetailsManager() =>
      _i29.LocationDetailsManager(_createLocationDetailsRepository());
  _i30.LocationDetailsRepository _createLocationDetailsRepository() =>
      _i30.LocationDetailsRepository(_createHttpClient());
  _i31.GuidesManager _createGuidesManager() =>
      _i31.GuidesManager(_createGuidesRepository());
  _i32.GuidesRepository _createGuidesRepository() =>
      _i32.GuidesRepository(_createHttpClient());
  _i33.RequestGuideScreen _createRequestGuideScreen() =>
      _i33.RequestGuideScreen(_createRequestGuideBloc());
  _i34.RequestGuideBloc _createRequestGuideBloc() =>
      _i34.RequestGuideBloc(_createRequestGuideService());
  _i35.RequestGuideService _createRequestGuideService() =>
      _i35.RequestGuideService(
          _createSharedPreferencesHelper(), _createGuideListService());
  _i36.GuideListService _createGuideListService() =>
      _i36.GuideListService(_createGuidesManager());
  _i37.TouristGuideListSubScreen _createTouristGuideListSubScreen() =>
      _i37.TouristGuideListSubScreen(
          _createGuideListBloc(), _createRequestGuideScreen());
  _i38.GuideListBloc _createGuideListBloc() =>
      _i38.GuideListBloc(_createGuideListService());
  _i39.TouristEventListSubScreen _createTouristEventListSubScreen() =>
      _i39.TouristEventListSubScreen();
  _i40.TouristOrdersScreen _createTouristOrdersScreen() =>
      _i40.TouristOrdersScreen();
  _i41.IntentionProfileScreen _createIntentionProfileScreen() =>
      _i41.IntentionProfileScreen(_createCreateIntentionBloc());
  _i42.CreateIntentionBloc _createCreateIntentionBloc() =>
      _i42.CreateIntentionBloc(_createIntentionService());
  _i43.IntentionService _createIntentionService() =>
      _i43.IntentionService(_createIntentionsManager());
  _i44.IntentionsManager _createIntentionsManager() =>
      _i44.IntentionsManager(_createIntentionsRepository());
  _i45.IntentionsRepository _createIntentionsRepository() =>
      _i45.IntentionsRepository(_createHttpClient());
  _i46.OrderGuideScreen _createOrderGuideScreen() => _i46.OrderGuideScreen();
  _i47.GuideComponent _createGuideComponent() =>
      _i47.GuideComponent(_createGuideLoginScreen(), _createGuideHomeScreen());
  _i48.GuideLoginScreen _createGuideLoginScreen() =>
      _i48.GuideLoginScreen(_createGuideLoginBloc());
  _i49.GuideLoginBloc _createGuideLoginBloc() => _i49.GuideLoginBloc();
  _i50.GuideHomeScreen _createGuideHomeScreen() =>
      _i50.GuideHomeScreen(_createGuideMainSubScreen());
  _i51.GuideMainSubScreen _createGuideMainSubScreen() =>
      _i51.GuideMainSubScreen();
  _i52.SharedComponent _createSharedComponent() =>
      _i52.SharedComponent(_createChatPage());
  _i53.ChatPage _createChatPage() => _i53.ChatPage(_createChatPageBloc());
  _i54.ChatPageBloc _createChatPageBloc() => _i54.ChatPageBloc();
  @override
  _i4.MyApp get app => _createMyApp();
}
