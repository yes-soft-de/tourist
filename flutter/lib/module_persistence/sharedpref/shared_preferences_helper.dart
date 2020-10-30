import 'package:inject/inject.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourists/module_authorization/user_authorization_module/bloc/login/login.bloc.dart';

@provide
class SharedPreferencesHelper {
  Future<void> setCurrentUsername(String username) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    await _sharedPreferences.setString('username', username);
  }

  Future<String> getCurrentUsername() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    return _sharedPreferences.getString('username');
  }

  Future<void> setUserUID(String uid) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    await _sharedPreferences.setString('uid', uid);
  }

  Future<String> getUserUID() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    return _sharedPreferences.getString('uid');
  }

  Future<void> setUsername(String username) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    return _sharedPreferences.setString('username', username);
  }

  Future<String> getUsername() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    return _sharedPreferences.getString('username');
  }

  Future<void> setAuthSource(AUTH_SOURCE source) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    return _sharedPreferences.setInt('source', source.index);
  }

  Future<AUTH_SOURCE> getAuthSource() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    int source = await _sharedPreferences.getInt('source');
    return source as AUTH_SOURCE;
  }

  Future<bool> clearData() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    return _sharedPreferences.clear();
  }

  Future<void> setLoggedInState(LoggedInState state) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    await _sharedPreferences.setString('loggedInState', state.toString());
  }

  Future<LoggedInState> getLoggedInState() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    String loggedInState = _sharedPreferences.getString('loggedInState');
    if (loggedInState == null) return LoggedInState.NOT_LOGGED_ID;
    if (loggedInState == LoggedInState.NOT_LOGGED_ID.toString()) {
      return LoggedInState.NOT_LOGGED_ID;
    }
    if (loggedInState == LoggedInState.TOURISTS.toString()) {
      return LoggedInState.TOURISTS;
    }
    if (loggedInState == LoggedInState.GUIDE.toString()) {
      return LoggedInState.GUIDE;
    }
    return LoggedInState.NOT_LOGGED_ID;
  }

  Future<String> getCurrentLocal() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    return _sharedPreferences.get('local');
  }

  Future<void> setCurrentLocal(String local) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    return _sharedPreferences.setString('local', local);
  }

  Future<void> cacheLoggedInUser(String uid, LoginSource source) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('uid', uid);
    await prefs.setInt('source', source.index);
  }

  Future<void> setLoginPending(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('pending_login', status);
  }

  Future<bool> getLoginPending() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('pending_login');
  }
}

enum LoginSource { APPLE, GOOGLE, EMAIL, PHONE }

enum LoggedInState { NOT_LOGGED_ID, TOURISTS, GUIDE }
