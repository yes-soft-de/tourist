import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/module_authorization/user_authorization_module/bloc/create_intentions/create_intention_bloc.dart';
import 'package:tourists/module_home/home_routes.dart';
import 'package:tourists/module_persistence/sharedpref/shared_preferences_helper.dart';

@provide
class IntentionProfileScreen extends StatefulWidget {
  final Map<String, bool> _interests = {
    'Mountains': false,
    'Dessert': false,
    'Malls': false
  };

  final CreateIntentionBloc _createIntentionBloc;
  final SharedPreferencesHelper _preferencesHelper;

  IntentionProfileScreen(this._createIntentionBloc, this._preferencesHelper);

  @override
  State<StatefulWidget> createState() => _IntentionProfileScreenState();
}

class _IntentionProfileScreenState extends State<IntentionProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime _arrivalDate;
  final TextEditingController _arrivalDateField = TextEditingController();
  final TextEditingController _stayingTime = TextEditingController();
  final TextEditingController _arrivalCity = TextEditingController();

  @override
  Widget build(BuildContext context) {
    widget._createIntentionBloc.intentionsCreateStream
        .listen((intentionsCreated) {
      if (intentionsCreated) {
        widget._preferencesHelper
            .setLoggedInState(LoggedInState.TOURISTS)
            .then((value) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(HomeRoutes.home, (r) => false);
        });
      }
    });

    return Scaffold(
      appBar: AppBar(),
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
                      color: Color(0xFF00FFA8)),
                ),
                Image.asset(
                  'resources/images/logo.jpg',
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
          // Divider
          Container(
            height: 56,
          ),
          // Form
          Padding(
            padding: EdgeInsets.all(32),
            child: Form(
              key: _formKey,
              child: Flex(
                direction: Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 16,
                  ),
                  TextFormField(
                    controller: _arrivalCity,
                    decoration:
                        InputDecoration(labelText: S.of(context).targetCity),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return S.of(context).error_null_text;
                      }
                      return null;
                    },
                  ),
                  Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Stack(
                              children: <Widget>[
                                TextFormField(
                                  controller: _arrivalDateField,
                                  decoration: InputDecoration(
                                      labelText: S.of(context).arrivalDate),
                                ),
                                Positioned(
                                  top: 0,
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    child: Container(
                                      color: Color(0x01FFFFFF),
                                    ),
                                    onTap: () {
                                      showDatePicker(
                                        context: context,
                                        firstDate: DateTime.now(),
                                        initialDate: DateTime.now(),
                                        lastDate: DateTime(
                                            DateTime.now().year,
                                            DateTime.now().month + 4,
                                            DateTime.now().day),
                                      ).then((value) {
                                        _arrivalDate = value;
                                        _arrivalDateField.text = _arrivalDate
                                            .toIso8601String()
                                            .substring(0, 10);
                                      });
                                    },
                                  ),
                                )
                              ],
                            ),
                          )),
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Flex(
                            direction: Axis.horizontal,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Flexible(
                                flex: 2,
                                child: TextFormField(
                                  controller: _stayingTime,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      labelText: S.of(context).stayingFor),
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return S.of(context).error_null_text;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 8.0),
                                  child: Text(S.of(context).days),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Flex(
                    direction: Axis.horizontal,
                    children: [Text(S.of(context).iCameFor)],
                  ),
                  Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _createInterestList(),
                  ),
                  Container(
                    height: 16,
                  ),
                  GestureDetector(
                    onTap: _createIntentionProfile,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.greenAccent,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(90))),
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(S.of(context).save),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          // Divider
          Container(
            height: 56,
          ),
          // City
        ],
      ),
    );
  }

  void _createIntentionProfile() {
    List<String> interests = [];
    widget._interests.forEach((key, value) {
      if (value) {
        interests.add(key);
      }
    });

    if (interests.isEmpty) {
      return;
    }

    widget._createIntentionBloc.createIntention(_arrivalCity.text,
        _arrivalDate.toIso8601String(), _stayingTime.text, interests);
  }

  List<Widget> _createInterestList() {
    List<Widget> interestList = [];

    // region Mountains
    interestList.add(Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          widget._interests['Mountains'] = !widget._interests['Mountains'];
          setState(() {});
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(90)),
            color: widget._interests['Mountains']
                ? Colors.greenAccent
                : Colors.white,
            border: Border.all(
                color: widget._interests['Mountains']
                    ? Colors.white
                    : Colors.greenAccent),
          ),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              S.of(context).mountains,
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
    ));
    // endregion

    // region Dessert
    interestList.add(Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          widget._interests['Dessert'] = !widget._interests['Dessert'];
          setState(() {});
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(90)),
            color: widget._interests['Dessert']
                ? Colors.greenAccent
                : Colors.white,
            border: Border.all(
                color: widget._interests['Dessert']
                    ? Colors.white
                    : Colors.greenAccent),
          ),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              S.of(context).dessert,
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
    ));
    // endregion

    // region Malls
    interestList.add(Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          widget._interests['Malls'] = !widget._interests['Malls'];
          setState(() {});
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(90)),
            color:
                widget._interests['Malls'] ? Colors.greenAccent : Colors.white,
            border: Border.all(
                color: widget._interests['Malls']
                    ? Colors.white
                    : Colors.greenAccent),
          ),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              S.of(context).malls,
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
    ));
    // endregion

    return interestList;
  }
}
