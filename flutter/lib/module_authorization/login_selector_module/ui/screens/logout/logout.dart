import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/module_home/home_routes.dart';
import 'package:tourists/module_persistence/sharedpref/shared_preferences_helper.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

@provide
class LogoutScreen extends StatelessWidget {
  final SharedPreferencesHelper _preferencesHelper;

  LogoutScreen(this._preferencesHelper);

  @override
  Widget build(BuildContext context) {
    _auth.signOut().then((value) {
      _preferencesHelper
          .setLoggedInState(LoggedInState.NOT_LOGGED_ID)
          .then((value) {
        _preferencesHelper.setUserUID(null).then((value) {
          Navigator.pushNamedAndRemoveUntil(
              context, HomeRoutes.home, (route) => false);
        });
      });
    });

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          Text(S.of(context).signing_out)
        ],
      ),
    );
  }
}
