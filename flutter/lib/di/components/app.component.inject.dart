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
import '../../user/ui/screens/register/register.dart' as _i11;
import '../../user/bloc/register/register.bloc.dart' as _i12;
import '../../user/services/register/register.service.dart' as _i13;
import '../../user/ui/screens/create_profile/create_profile.dart' as _i14;
import '../../user/bloc/create_profile/create_profile_bloc.dart' as _i15;
import '../../user/services/profile/profile.service.dart' as _i16;
import '../../user/managers/profile/profile.manager.dart' as _i17;
import '../../user/repositories/profile/profile.repository.dart' as _i18;
import '../../user/ui/screens/home/home.dart' as _i19;
import '../../user/ui/screens/home/subscreens/main/main_home.dart' as _i20;
import '../../user/ui/screens/home/subscreens/tourist_guide_list/tourist_guide_list.dart'
    as _i21;
import '../../user/ui/screens/intention_profile/intention_profile.dart' as _i22;
import '../../user/bloc/create_intentions/create_intention_bloc.dart' as _i23;
import '../../user/services/intentions/intentions_service.dart' as _i24;
import '../../user/managers/intentions/intentions_manager.dart' as _i25;
import '../../user/repositories/intentions/intentions_repository.dart' as _i26;

class AppComponent$Injector implements _i1.AppComponent {
  AppComponent$Injector._();

  _i2.HttpClient _singletonHttpClient;

  static _i3.Future<_i1.AppComponent> create() async {
    final injector = AppComponent$Injector._();

    return injector;
  }

  _i4.MyApp _createMyApp() => _i4.MyApp(_createUserComponent());
  _i5.UserComponent _createUserComponent() => _i5.UserComponent(
      _createLoginScreen(),
      _createLoginTypeSelectorScreen(),
      _createRegisterScreen(),
      _createCreateProfileScreen(),
      _createHomeScreen(),
      _createIntentionProfileScreen());
  _i6.LoginScreen _createLoginScreen() => _i6.LoginScreen(_createLoginBloc());
  _i7.LoginBloc _createLoginBloc() => _i7.LoginBloc(_createLoginService());
  _i8.LoginService _createLoginService() =>
      _i8.LoginService(_createSharedPreferencesHelper());
  _i9.SharedPreferencesHelper _createSharedPreferencesHelper() =>
      _i9.SharedPreferencesHelper();
  _i10.LoginTypeSelectorScreen _createLoginTypeSelectorScreen() =>
      _i10.LoginTypeSelectorScreen();
  _i11.RegisterScreen _createRegisterScreen() =>
      _i11.RegisterScreen(_createRegisterBloc());
  _i12.RegisterBloc _createRegisterBloc() =>
      _i12.RegisterBloc(_createRegisterService());
  _i13.RegisterService _createRegisterService() =>
      _i13.RegisterService(_createSharedPreferencesHelper());
  _i14.CreateProfileScreen _createCreateProfileScreen() =>
      _i14.CreateProfileScreen(
          _createCreateProfileBloc(), _createSharedPreferencesHelper());
  _i15.CreateProfileBloc _createCreateProfileBloc() =>
      _i15.CreateProfileBloc(_createProfileService());
  _i16.ProfileService _createProfileService() => _i16.ProfileService(
      _createProfileManager(), _createSharedPreferencesHelper());
  _i17.ProfileManager _createProfileManager() =>
      _i17.ProfileManager(_createProfileRepository());
  _i18.ProfileRepository _createProfileRepository() =>
      _i18.ProfileRepository(_createHttpClient());
  _i2.HttpClient _createHttpClient() =>
      _singletonHttpClient ??= _i2.HttpClient();
  _i19.HomeScreen _createHomeScreen() => _i19.HomeScreen(
      _createMainHomeSubScreen(),
      _createTouristGuideListSubScreen(),
      _createTouristGuideListSubScreen());
  _i20.MainHomeSubScreen _createMainHomeSubScreen() => _i20.MainHomeSubScreen();
  _i21.TouristGuideListSubScreen _createTouristGuideListSubScreen() =>
      _i21.TouristGuideListSubScreen();
  _i22.IntentionProfileScreen _createIntentionProfileScreen() =>
      _i22.IntentionProfileScreen(_createCreateIntentionBloc());
  _i23.CreateIntentionBloc _createCreateIntentionBloc() =>
      _i23.CreateIntentionBloc(_createIntentionService());
  _i24.IntentionService _createIntentionService() =>
      _i24.IntentionService(_createIntentionsManager());
  _i25.IntentionsManager _createIntentionsManager() =>
      _i25.IntentionsManager(_createIntentionsRepository());
  _i26.IntentionsRepository _createIntentionsRepository() =>
      _i26.IntentionsRepository(_createHttpClient());
  @override
  _i4.MyApp get app => _createMyApp();
}
