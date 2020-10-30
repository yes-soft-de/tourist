import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:inject/inject.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:tourists/module_authorization/user_authorization_module/bloc/login/login.bloc.dart';
import 'package:tourists/module_persistence/sharedpref/shared_preferences_helper.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

@provide
class LoginService {
  final SharedPreferencesHelper _prefsHelper;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  LoginService(this._prefsHelper);

  Future<dynamic> get isLoggedIn => _prefsHelper.getUserUID();

  Future<bool> loginUser(
      String uid, String name, String email, AUTH_SOURCE authSource) async {
    await _prefsHelper.setUserUID(uid);
    await _prefsHelper.setUsername(name);
    await _prefsHelper.setAuthSource(authSource);
    return true;
  }
}
