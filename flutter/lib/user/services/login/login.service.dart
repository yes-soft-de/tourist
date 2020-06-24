import 'package:firebase_auth/firebase_auth.dart';
import 'package:inject/inject.dart';
import 'package:tourists/persistence/sharedpref/shared_preferences_helper.dart';
import 'package:tourists/responses/login/login.response.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

@provide
class LoginService {
  SharedPreferencesHelper _preferencesHelper;

  LoginService(this._preferencesHelper);

  Future<String> login(String username, String password) async {
    // Login User to Firebase
    var user = await _auth.signInWithEmailAndPassword(email: username, password: password);

    if (user.user.uid != null) {
      _cacheLoggedInUser(user.user);
      return user.user.uid;
    } else {
      return null;
    }
  }

  _cacheLoggedInUser(FirebaseUser user) {
    _preferencesHelper.setUserUID(user.uid);
  }
}