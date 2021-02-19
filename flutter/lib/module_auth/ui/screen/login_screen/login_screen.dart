import 'dart:async';

import 'package:tourists/module_auth/enums/user_type.dart';
import 'package:tourists/module_auth/state_manager/login_state_manager/login_state_manager.dart';
import 'package:tourists/module_auth/ui/states/login_states/login_state.dart';
import 'package:tourists/module_auth/ui/states/login_states/login_state_init.dart';
import 'package:tourists/module_home/home_routes.dart';
import 'package:tourists/module_orders/orders_routes.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class LoginScreen extends StatefulWidget {
  final LoginStateManager _stateManager;

  LoginScreen(this._stateManager);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  UserRole currentUserRole;
  LoginState _currentStates;

  StreamSubscription _stateSubscription;
  bool deepLinkChecked = false;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void refresh() {
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _currentStates ??= LoginStateInit(this);
    _stateSubscription = widget._stateManager.stateStream.listen((event) {
      if (mounted) {
        setState(() {
          _currentStates = event;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(),
      body: SafeArea(
        child: _currentStates.getUI(context),
      ),
    );
  }

  @override
  void dispose() {
    _stateSubscription.cancel();
    super.dispose();
  }

  void moveToNext() {
    if (currentUserRole == UserRole.ROLE_OWNER) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          HomeRoutes.home, (r) => false);
    } else if (currentUserRole == UserRole.ROLE_GUIDE) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          HomeRoutes.guideHome, (r) => false);
    }
  }

  void loginViaPhone(String phoneNumber) {
    currentUserRole = UserRole.ROLE_OWNER;
    widget._stateManager.loginViaPhoneNumber(phoneNumber, this);
  }

  void loginViaGoogle() {
    currentUserRole = UserRole.ROLE_OWNER;
    widget._stateManager.loginViaGoogle(this, UserRole.ROLE_OWNER);
  }

  void sendLoginLink(String email, UserRole role) {
    print('Sending Email to $email');
    widget._stateManager.sendLoginLink(this, email, role);
  }

  void loginOwner(String email, String password) {
    currentUserRole = UserRole.ROLE_OWNER;
    widget._stateManager.loginViaEmailAndPassword(email, password, this);
  }

  void showSnackBar(String msg) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(msg)));
  }

  void confirmSMS(String smsCode) {
    currentUserRole = UserRole.ROLE_GUIDE;
    widget._stateManager.confirmSMSCode(smsCode, this);
  }

  void retryPhone() {
    _currentStates = LoginStateInit(this);
  }
}
