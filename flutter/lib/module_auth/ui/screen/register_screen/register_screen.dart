import 'package:tourists/module_auth/enums/user_type.dart';
import 'package:tourists/module_auth/state_manager/register_state_manager/register_state_manager.dart';
import 'package:tourists/module_auth/ui/states/register_states/register_state.dart';
import 'package:tourists/module_auth/ui/states/register_states/register_state_init.dart';
import 'package:tourists/module_home/home_routes.dart';
import 'package:tourists/module_orders/orders_routes.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class RegisterScreen extends StatefulWidget {
  final RegisterStateManager _stateManager;

  RegisterScreen(this._stateManager);

  @override
  State<StatefulWidget> createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  RegisterState _currentState;
  UserRole currentUserRole;

  @override
  void initState() {
    super.initState();

    _currentState = RegisterStateInit(this);
    widget._stateManager.stateStream.listen((event) {
      if (this.mounted) {
        setState(() {
          _currentState = event;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _currentState.getUI(context),
      ),
    );
  }

  void refresh() {
    if (mounted) setState(() {});
  }

  void registerCaptain(String phoneNumber) {
    currentUserRole = UserRole.ROLE_GUIDE;
    widget._stateManager.registerCaptain(phoneNumber, this);
  }

  void registerOwner(String email, String username, String password) {
    currentUserRole = UserRole.ROLE_TOURIST;
    widget._stateManager.registerOwner(email, username, password, this);
  }

  void confirmCaptainSMS(String smsCode) {
    currentUserRole = UserRole.ROLE_GUIDE;
    widget._stateManager.confirmCaptainCode(smsCode);
  }

  void retryPhone() {
    currentUserRole = UserRole.ROLE_GUIDE;
    _currentState = RegisterStateInit(this);
  }

  void moveToNext() {
    switch (currentUserRole) {
      case UserRole.ROLE_GUIDE:
        Navigator.of(context).pushNamedAndRemoveUntil(
            HomeRoutes.guideHome, (r) => false);
        break;
      case UserRole.ROLE_TOURIST:
        Navigator.of(context).pushNamedAndRemoveUntil(
            HomeRoutes.home, (r) => false);
        break;
    }
  }
}
