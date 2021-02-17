import 'dart:developer' as developer;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inject/inject.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/module_authorization/user_authorization_module/bloc/login/login.bloc.dart';
import 'package:tourists/module_authorization/user_authorization_module/states/login_state.dart';
import 'package:tourists/module_home/home_routes.dart';
import 'package:tourists/module_persistence/sharedpref/shared_preferences_helper.dart';

import '../../../user_auth_routes.dart';

@provide
class LoginScreen extends StatefulWidget {
  final LoginBloc _loginBlock;
  final SharedPreferencesHelper _preferencesHelper;

  LoginScreen(this._loginBlock, this._preferencesHelper);

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  bool _error;
  String _userEmail;

  bool submitAvailable = true;

  @override
  Widget build(BuildContext context) {
    widget._loginBlock.loginStatus.listen((event) {
      if (event is LoginStateSuccess) {
        widget._preferencesHelper
            .setLoggedInState(LoggedInState.TOURISTS)
            .then((value) {
          Navigator.of(context).pushReplacementNamed(HomeRoutes.home);
        });
      }
      submitAvailable = true;
      setState(() {});
    });

    return Scaffold(
      appBar: AppBar(),
      resizeToAvoidBottomPadding: false,
      body: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // LOGO
          Container(
            height: 156,
            width: 156,
            child: MediaQuery.of(context).viewInsets.bottom == 0
                ? Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Container(
                        height: 156,
                        width: 156,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(78),
                            color: Color(0xFF00FFA8)),
                      ),
                      Image.asset(
                        'resources/images/logo.jpg',
                        fit: BoxFit.contain,
                      ),
                    ],
                  )
                : Container(),
          ),

          // Login Form
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(labelText: 'Send Login Link'),
              validator: (String value) {
                if (value.isEmpty) {
                  return S.of(context).error_null_text;
                }
                return null;
              },
            ),
          ),
          GestureDetector(
            child: Container(
                alignment: Alignment.center,
                child: Container(
                  alignment: Alignment.center,
                  child: Container(
                    height: 40,
                    width: 160,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(90)),
                      color: _emailController.text.isNotEmpty ? Colors.greenAccent : Colors.grey,
                    ),
                    child: Text(
                      S.of(context).login,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )),
            onTap: () => _login(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  border: Border.all(width: 0.5),
                ),
                child: GestureDetector(
                    onTap: () {
                      widget._loginBlock.authWithGoogle();
                    },
                    child: Flex(
                      direction: Axis.horizontal,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 36,
                          width: 36,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(
                              'resources/images/google-logo.svg',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Sign in With Google'),
                        ),
                      ],
                    )),
              ),
            ],
          ),
          Container(
            alignment: Alignment.center,
            child: Text(_error == null
                ? ''
                : (_error
                    ? S.of(context).successfully_registered + _userEmail
                    : S.of(context).registration_failed)),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _emailController.dispose();
    super.dispose();
  }

  void _login() {
    if (submitAvailable && _emailController.text.isNotEmpty) {
      setState(() {});
      widget._loginBlock.sendLoginEmail(_emailController.text.trim());
    } else {
      Fluttertoast.showToast(msg: 'Please Wait...');
    }
  }
}
