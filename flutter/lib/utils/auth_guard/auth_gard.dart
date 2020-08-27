import 'dart:developer';

import 'package:inject/inject.dart';
import 'package:tourists/module_persistence/sharedpref/shared_preferences_helper.dart';

@provide
@singleton
class AuthGuard {
  final SharedPreferencesHelper _sharedPreferencesHelper;

  AuthGuard(this._sharedPreferencesHelper);

  Future<bool> isLoggedIn() async {
    LoggedInState state = await _sharedPreferencesHelper.getLoggedInState();

    if (state == null) {
      return false;
    }

    log('Auth Guard' + state.toString());

    if (state == LoggedInState.NOT_LOGGED_ID) {
      return false;
    }

    if (state == LoggedInState.GUIDE || state == LoggedInState.TOURISTS) {
      return true;
    }

    return state != null;
  }

  Future<bool> isGuide() async {
    LoggedInState state = await _sharedPreferencesHelper.getLoggedInState();

    if (state == null) {
      return false;
    }

    return state == LoggedInState.GUIDE;
  }
}
