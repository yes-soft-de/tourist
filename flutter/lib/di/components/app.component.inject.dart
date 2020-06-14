import 'app.component.dart' as _i1;
import '../../network/http_client/http_client.dart' as _i2;
import 'dart:async' as _i3;
import '../../main.dart' as _i4;
import '../../ui/screens/login/login.dart' as _i5;
import '../../bloc/login/login.bloc.dart' as _i6;
import '../../services/login/login.service.dart' as _i7;
import '../../persistence/sharedpref/shared_preferences_helper.dart' as _i8;

class AppComponent$Injector implements _i1.AppComponent {
  AppComponent$Injector._();

  _i2.HttpClient _singletonHttpClient;

  static _i3.Future<_i1.AppComponent> create() async {
    final injector = AppComponent$Injector._();

    return injector;
  }

  _i4.MyApp _createMyApp() => _i4.MyApp(_createLoginScreen());
  _i5.LoginScreen _createLoginScreen() => _i5.LoginScreen(_createLoginBloc());
  _i6.LoginBloc _createLoginBloc() => _i6.LoginBloc(_createLoginService());
  _i7.LoginService _createLoginService() =>
      _i7.LoginService(_createSharedPreferencesHelper());
  _i8.SharedPreferencesHelper _createSharedPreferencesHelper() =>
      _i8.SharedPreferencesHelper();
  _i2.HttpClient _createHttpClient() =>
      _singletonHttpClient ??= _i2.HttpClient();
  @override
  _i4.MyApp get app => _createMyApp();
  @override
  _i2.HttpClient getHttpClient() => _createHttpClient();
}
