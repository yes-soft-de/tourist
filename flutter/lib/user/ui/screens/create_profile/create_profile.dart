import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/user/bloc/create_profile/create_profile_bloc.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/user/persistence/sharedpref/shared_preferences_helper.dart';
import 'package:tourists/user/user_routes.dart';

@provide
class CreateProfileScreen extends StatefulWidget {
  final CreateProfileBloc _profileBloc;
  final SharedPreferencesHelper _preferencesHelper;

  CreateProfileScreen(this._profileBloc, this._preferencesHelper);

  @override
  State<StatefulWidget> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  String _guideLanguage;

  @override
  Widget build(BuildContext context) {
    widget._profileBloc.profileStatus.listen((event) {
      if (widget != null) {
        Navigator.pushReplacementNamed(context, UserRoutes.intentionProfile);
      }
    });

    widget._preferencesHelper.getUserUID().then((value) {
      log('UserID: ' + value);
    });

    return Scaffold(
      body: ListView(
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
                      color: Colors.green),
                ),
                Image.asset('logo.png', fit: BoxFit.contain,)
              ],
            ),
          ),
          // Divider
          Container(
            height: 56,
          ),
          Container(
            width: 156,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Name'),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    DropdownButtonFormField(
                      items: <DropdownMenuItem<String>>[
                        DropdownMenuItem(
                          value: null,
                          child: Text('Select a Language'),
                        ),
                        DropdownMenuItem(
                          value: 'en',
                          child: Text('English'),
                        ),
                        DropdownMenuItem(
                          value: 'ar',
                          child: Text('العربية'),
                        ),
                      ],
                      onChanged: (String value) {
                        this._guideLanguage = value;
                      },
                    ),
                    TextFormField(
                      controller: _genderController,
                      decoration:
                      const InputDecoration(labelText: 'Gender'),
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
                      onTap: () {
                        _createProfile();
                      },
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Container(
                          height: 40,
                          width: 160,
                          alignment: Alignment.center,
                          child: Text(S
                              .of(context)
                              .next),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _createProfile() {
    if (_guideLanguage == null) {
      log('Null Language');
      return;
    }

    log('Language is ' + _guideLanguage);

    widget._profileBloc.createProfile(
        _nameController.text, _genderController.text, _guideLanguage);
  }
}
