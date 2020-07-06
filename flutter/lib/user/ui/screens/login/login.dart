import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/user/bloc/login/login.bloc.dart';
import 'package:tourists/routes.dart';
import 'dart:developer' as developer;

import 'package:tourists/user/user_routes.dart';

@provide
class LoginScreen extends StatefulWidget {
  final LoginBloc _loginBlock;

  LoginScreen(this._loginBlock);

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _error;
  String _userEmail;

  @override
  Widget build(BuildContext context) {

    widget._loginBlock.loginStatus.listen((event) {
      if (event != null && event.length > 0) {
        Navigator.of(context).pushReplacementNamed(UserRoutes.createProfile);
      }
    });

    return Scaffold(
      body:
      ListView(children: <Widget>[
        Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // LOGO
            Container(
              height: 156,
              width: 156,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    height: 156,
                    width: 156,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(78),
                        color: Color(0xFF00FFA8)),
                  ),
                  Text(
                    'LOGO',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  )
                ],
              ),
            ),
            Container(
              height: 56,
            ),
            Container(
              width: 256,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    Container(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration:
                      const InputDecoration(labelText: 'Password'),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    Container(
                      height: 16,
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
                                borderRadius:
                                BorderRadius.all(Radius.circular(90)),
                                color: Color(0xFF00FFA8),
                              ),
                              child: Text(
                                S.of(context).login,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          )
                      ),
                      onTap: () => _login(),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(_error == null
                          ? ''
                          : (_error
                          ? 'Successfully registered ' + _userEmail
                          : 'Registration failed')),
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: 56,
            ),
            GestureDetector(
              onTap: () {
                developer.log('Register Requested');
                Navigator.pushReplacementNamed(context, UserRoutes.register);
              },
              child: Container(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(S.of(context).move_to_register),
                ),
              ),
            )
          ],
        )
      ]),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    widget._loginBlock.login(_emailController.text,
        _passwordController.text);
  }
}
