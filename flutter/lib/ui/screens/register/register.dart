import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/bloc/login/login.bloc.dart';
import 'package:tourists/bloc/register/register.bloc.dart';
import 'package:tourists/routes.dart';
import 'package:tourists/services/login/login.service.dart';

@provide
class RegisterScreen extends StatefulWidget {
  final RegisterBloc _registerBloc;

  RegisterScreen(this._registerBloc);

  @override
  State<StatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _error;
  String _userEmail;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget._registerBloc.registerStatus,
      initialData: null,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.data != null && snapshot.data.length > 0) {
          // Login Success
          Navigator.pushReplacementNamed(context, Routes.createProfile);
          return null;
        }
        return Scaffold(
          body: Form(
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
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  alignment: Alignment.center,
                  child: RaisedButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        _register();
                      }
                    },
                    child: const Text('Submit'),
                  ),
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
        );
      },
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _register() {
    widget._registerBloc.register(_emailController.value.toString(),
        _passwordController.value.toString());
  }
}
