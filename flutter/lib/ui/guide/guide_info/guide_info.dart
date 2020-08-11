import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inject/inject.dart';
import 'package:tourists/bloc/guide_register/guide_register.dart';
import 'package:tourists/components/guide/guide_routes.dart';
import 'package:tourists/persistence/sharedpref/shared_preferences_helper.dart';

@provide
class GuideInfoScreen extends StatefulWidget {
  final GuideRegisterBloc _guideRegisterBloc;
  final SharedPreferencesHelper _preferencesHelper;

  GuideInfoScreen(this._guideRegisterBloc, this._preferencesHelper);

  @override
  State<StatefulWidget> createState() => _GuideInfoScreenState();
}

class _GuideInfoScreenState extends State<GuideInfoScreen> {
  int currentState = GuideRegisterBloc.STATUS_CODE_INIT;
  TextEditingController _nameController = TextEditingController();
  String _motherLanguage;

  @override
  Widget build(BuildContext context) {
    if (currentState == GuideRegisterBloc.STATUS_CODE_INIT)
      widget._guideRegisterBloc.checkIfGuideRegistered();

    widget._guideRegisterBloc.guideStream.listen((event) {
      currentState = event.first;
      if (currentState ==
              GuideRegisterBloc.STATUS_CODE_USER_ALREADY_LOGGED_IN ||
          currentState == GuideRegisterBloc.STATUS_CODE_REGISTER_SUCCESS) {
        widget._preferencesHelper
            .setLoggedInState(LoggedInState.GUIDE)
            .then((value) {
          Navigator.pushReplacementNamed(context, GuideRoutes.guideHome);
        });
      }
      if (currentState == GuideRegisterBloc.STATUS_CODE_REGISTER_ERROR) {
        Fluttertoast.showToast(msg: 'Error Registering User');
      }
    });

    return Scaffold(
      body: Center(
        child: Form(
          child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(hintText: "Your Name Please"),
                controller: _nameController,
              ),
              DropdownButtonFormField(
                value: 'Arabic',
                items: [
                  DropdownMenuItem(value: "Arabic", child: Text("Arabic")),
                  DropdownMenuItem(value: "English", child: Text("English")),
                ],
                onChanged: (value) {
                  _motherLanguage = value;
                },
              ),
              RaisedButton(
                child: Text("Save"),
                onPressed: registerGuide(),
              )
            ],
          ),
        ),
      ),
    );
  }

  registerGuide() {
  }
}
