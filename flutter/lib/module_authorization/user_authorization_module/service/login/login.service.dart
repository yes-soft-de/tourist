import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:inject/inject.dart';
import 'package:tourists/module_persistence/sharedpref/shared_preferences_helper.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

@provide
class LoginService {
  final SharedPreferencesHelper _preferencesHelper;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  LoginService(this._preferencesHelper);

  Future<String> login(String username, String password) async {
    // Login User to Firebase
    try {
      var user = await _auth.signInWithEmailAndPassword(
          email: username, password: password);

      if (user.user.uid != null) {
        _cacheLoggedInUser(user.user);
        return user.user.uid;
      } else {
        return null;
      }
    } catch (e) {
      await Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 3000);
      log(e.toString());
      return null;
    }
  }

  Future<String> loginWithGoogle() async {
    // Login User to Firebase
    try {
      GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      AuthCredential credential = await GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await _auth.signInWithCredential(credential);

      var user = _auth.currentUser;

      if (user.uid != null) {
        _cacheLoggedInUser(user);
        return user.uid;
      } else {
        return null;
      }
    } catch (e) {
      await Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 3000);
      log(e.toString());
      return null;
    }
  }

  void _cacheLoggedInUser(User user) {
    _preferencesHelper.setUserUID(user.uid);
  }
}
