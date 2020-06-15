import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/bloc/create_profile/create_profile_bloc.dart';
import 'package:tourists/generated/l10n.dart';

import '../../../routes.dart';

@provide
class CreateProfileScreen extends StatefulWidget {
  CreateProfileBloc _profileBloc;

  CreateProfileScreen(this._profileBloc);

  @override
  State<StatefulWidget> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _languageController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget._profileBloc.profileStatus,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          if (snapshot.data == true) {
            Navigator.pushReplacementNamed(context, Routes.intentionProfile);
            return null;
          }
        }

        return Scaffold(
          body: ListView(
            children: <Widget>[
              Container(
                width: 156,
                child: Form(
                  key: _formKey,
                  child: Column(
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
                      TextFormField(
                        controller: _ageController,
                        decoration: const InputDecoration(labelText: 'Age'),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _languageController,
                        decoration:
                            const InputDecoration(labelText: 'Language'),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _genderController,
                        decoration: const InputDecoration(labelText: 'Gender'),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
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
                            child: Text(S.of(context).next),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  _createProfile() {
    widget._profileBloc.createProfile(_nameController.text, _ageController.text,
        _genderController.text, _languageController.text);
  }
}
