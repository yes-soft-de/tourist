import 'app.component.dart' as _i1;
import '../../user/network/http_client/http_client.dart' as _i2;
import 'dart:async' as _i3;
import '../../main.dart' as _i4;
import '../../user/user_component.dart' as _i5;
import '../../user/ui/screens/login/login.dart' as _i6;
import '../../user/bloc/login/login.bloc.dart' as _i7;
import '../../user/services/login/login.service.dart' as _i8;
import '../../user/persistence/sharedpref/shared_preferences_helper.dart'
    as _i9;
import '../../user/ui/screens/account_type_selector/login_type_selector.dart'
    as _i10;
import '../../user/ui/screens/request_guide_success/request_guide_success.dart'
    as _i11;
import '../../user/ui/screens/register/register.dart' as _i12;
import '../../user/bloc/register/register.bloc.dart' as _i13;
import '../../user/services/register/register.service.dart' as _i14;
import '../../user/ui/screens/create_profile/create_profile.dart' as _i15;
import '../../user/bloc/create_profile/create_profile_bloc.dart' as _i16;
import '../../user/services/profile/profile.service.dart' as _i17;
import '../../user/managers/profile/profile.manager.dart' as _i18;
import '../../user/repositories/profile/profile.repository.dart' as _i19;
import '../../user/ui/screens/home/home.dart' as _i20;
import '../../user/ui/screens/home/subscreens/main/main_home.dart' as _i21;
import '../../user/bloc/main_home/main_home_bloc.dart' as _i22;
import '../../user/services/location_list/location_list_service.dart' as _i23;
import '../../user/managers/location_list/location_list_manager.dart' as _i24;
import '../../user/repositories/location_list/location_list_repository.dart'
    as _i25;
import '../../user/ui/screens/location_details/location_details.dart' as _i26;
import '../../user/bloc/location_details/location_details_bloc.dart' as _i27;
import '../../user/services/location_details/location_details_service.dart'
    as _i28;
import '../../user/managers/location_details/location_details.dart' as _i29;
import '../../user/repositories/location_details/location_details_repository.dart'
    as _i30;
import '../../user/managers/guides_manager/guides_manager.dart' as _i31;
import '../../user/repositories/guides/guide_repository.dart' as _i32;
import '../../user/ui/screens/request_guide/request_guide_screen.dart' as _i33;
import '../../user/bloc/request_guide/request_guide.bloc.dart' as _i34;
import '../../user/services/request_guide/request_guide.service.dart' as _i35;
import '../../user/services/guide_list/guide_list.dart' as _i36;
import '../../user/ui/screens/home/subscreens/tourist_guide_list/tourist_guide_list.dart'
    as _i37;
import '../../user/bloc/guide_list/guide_list_bloc.dart' as _i38;
import '../../user/ui/screens/home/subscreens/tourist_event_list/tourist_event_list.dart'
    as _i39;
import '../../user/ui/screens/tourist_orders/tourist_order.dart' as _i40;
import '../../user/ui/screens/intention_profile/intention_profile.dart' as _i41;
import '../../user/bloc/create_intentions/create_intention_bloc.dart' as _i42;
import '../../user/services/intentions/intentions_service.dart' as _i43;
import '../../user/managers/intentions/intentions_manager.dart' as _i44;
import '../../user/repositories/intentions/intentions_repository.dart' as _i45;
import '../../user/ui/screens/order_guide/order_guide.dart' as _i46;
import '../../guide/guide_component.dart' as _i47;
import '../../guide/ui/screens/guide_login/guide_login.dart' as _i48;
import '../../guide/bloc/guide_login/guide_login.bloc.dart' as _i49;

class AppComponent$Injector implements _i1.AppComponent {
  AppComponent$Injector._();

  _i2.HttpClient _singletonHttpClient;

  static _i3.Future<_i1.AppComponent> create() async {
    final injector = AppComponent$Injector._();

    return injector;
  }

  _i4.MyApp _createMyApp() =>
      _i4.MyApp(_createUserComponent(), _createGuideComponent());
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
      _i47.GuideComponent(_createGuideLoginScreen());
  _i48.GuideLoginScreen _createGuideLoginScreen() =>
      _i48.GuideLoginScreen(_createGuideLoginBloc());
  _i49.GuideLoginBloc _createGuideLoginBloc() => _i49.GuideLoginBloc();
  @override
  _i4.MyApp get app => _createMyApp();
}
