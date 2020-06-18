import 'app.component.dart' as _i1;
import '../../network/http_client/http_client.dart' as _i2;
import 'dart:async' as _i3;
import '../../main.dart' as _i4;
import '../../ui/screens/login/login.dart' as _i5;
import '../../bloc/login/login.bloc.dart' as _i6;
import '../../services/login/login.service.dart' as _i7;
import '../../persistence/sharedpref/shared_preferences_helper.dart' as _i8;
import '../../ui/screens/register/register.dart' as _i9;
import '../../bloc/register/register.bloc.dart' as _i10;
import '../../services/register/register.service.dart' as _i11;
import '../../ui/screens/create_profile/create_profile.dart' as _i12;
import '../../bloc/create_profile/create_profile_bloc.dart' as _i13;
import '../../services/profile/profile.service.dart' as _i14;
import '../../managers/profile/profile.manager.dart' as _i15;
import '../../repositories/profile/profile.repository.dart' as _i16;
import '../../ui/screens/home/home.dart' as _i17;
import '../../ui/screens/intention_profile/intention_profile.dart' as _i18;
import '../../bloc/create_intentions/create_intention_bloc.dart' as _i19;
import '../../services/intentions/intentions_service.dart' as _i20;
import '../../managers/intentions/intentions_manager.dart' as _i21;
import '../../repositories/intentions/intentions_repository.dart' as _i22;

class AppComponent$Injector implements _i1.AppComponent {
  AppComponent$Injector._();

  _i2.HttpClient _singletonHttpClient;

  static _i3.Future<_i1.AppComponent> create() async {
    final injector = AppComponent$Injector._();

    return injector;
  }

  _i4.MyApp _createMyApp() => _i4.MyApp(
      _createLoginScreen(),
      _createRegisterScreen(),
      _createCreateProfileScreen(),
      _createHomeScreen(),
      _createIntentionProfileScreen());
  _i5.LoginScreen _createLoginScreen() => _i5.LoginScreen(_createLoginBloc());
  _i6.LoginBloc _createLoginBloc() => _i6.LoginBloc(_createLoginService());
  _i7.LoginService _createLoginService() =>
      _i7.LoginService(_createSharedPreferencesHelper());
  _i8.SharedPreferencesHelper _createSharedPreferencesHelper() =>
      _i8.SharedPreferencesHelper();
  _i9.RegisterScreen _createRegisterScreen() =>
      _i9.RegisterScreen(_createRegisterBloc());
  _i10.RegisterBloc _createRegisterBloc() =>
      _i10.RegisterBloc(_createRegisterService());
  _i11.RegisterService _createRegisterService() =>
      _i11.RegisterService(_createSharedPreferencesHelper());
  _i12.CreateProfileScreen _createCreateProfileScreen() =>
      _i12.CreateProfileScreen(
          _createCreateProfileBloc(), _createSharedPreferencesHelper());
  _i13.CreateProfileBloc _createCreateProfileBloc() =>
      _i13.CreateProfileBloc(_createProfileService());
  _i14.ProfileService _createProfileService() => _i14.ProfileService(
      _createProfileManager(), _createSharedPreferencesHelper());
  _i15.ProfileManager _createProfileManager() =>
      _i15.ProfileManager(_createProfileRepository());
  _i16.ProfileRepository _createProfileRepository() =>
      _i16.ProfileRepository(_createHttpClient());
  _i2.HttpClient _createHttpClient() =>
      _singletonHttpClient ??= _i2.HttpClient();
  _i17.HomeScreen _createHomeScreen() => _i17.HomeScreen();
  _i18.IntentionProfileScreen _createIntentionProfileScreen() =>
      _i18.IntentionProfileScreen(_createCreateIntentionBloc());
  _i19.CreateIntentionBloc _createCreateIntentionBloc() =>
      _i19.CreateIntentionBloc(_createIntentionService());
  _i20.IntentionService _createIntentionService() =>
      _i20.IntentionService(_createIntentionsManager());
  _i21.IntentionsManager _createIntentionsManager() =>
      _i21.IntentionsManager(_createIntentionsRepository());
  _i22.IntentionsRepository _createIntentionsRepository() =>
      _i22.IntentionsRepository(_createHttpClient());
  @override
  _i4.MyApp get app => _createMyApp();
  @override
  _i2.HttpClient getHttpClient() => _createHttpClient();
}
