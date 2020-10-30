import 'dart:developer';

import 'package:inject/inject.dart';
import 'package:tourists/module_persistence/sharedpref/shared_preferences_helper.dart';

@provide
@singleton
class AuthGuard {
  final SharedPreferencesHelper _sharedPreferencesHelper;

  AuthGuard(this._sharedPreferencesHelper);

  Future<bool> isLoggedIn() async {
    String uid = await _sharedPreferencesHelper.getUserUID();

    return uid != null;
  }

  Future<bool> isGuide() async {
    LoggedInState state = await _sharedPreferencesHelper.getLoggedInState();

    if (state == null) {
      return false;
    }

    return state == LoggedInState.GUIDE;
  }
}
