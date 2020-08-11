import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inject/inject.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/guide_login_module/guide_login_routes.dart';
import 'package:tourists/persistence/sharedpref/shared_preferences_helper.dart';

@provide
class LoginTypeSelectorScreen extends StatefulWidget {

  LoginTypeSelectorScreen();

  @override
  State<StatefulWidget> createState() => _LoginTypeSelectorScreenState();
}

class _LoginTypeSelectorScreenState extends State<LoginTypeSelectorScreen> {
  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
          body: Container(
        width: double.infinity,
        child: Flex(
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
                          color: Colors.green),
                    ),
                    Image.asset(
                      'resources/images/logo.jpg',
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),

              // Welcome Message
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(S.of(context).welcome),
                    Text(
                      S.of(context).title,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),

              // First Card
              GestureDetector(
                onTap: () =>
                    Navigator.pushReplacementNamed(context, UserLoginRoutes.login),
                child: Stack(alignment: Alignment.center, children: <Widget>[
                  // Sizing Container
                  Container(
                    height: 164,
                  ),
                  // Card Content
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Color(0xFFD5F4FE),
                    ),
                    alignment: Alignment.center,
                    height: 128,
                    width: 288,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        S.current.card_01,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                    ),
                  ),
                  // Move Button
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      alignment: Alignment.center,
                      child: Container(
                        height: 40,
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
                              S.of(context).go_to_tourist_login,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ]),
              ),

              // Divider
              Container(
                height: 56,
              ),

              // region Second Card
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, GuideLoginRoutes.guideLogin);
                },
                child: Stack(alignment: Alignment.center, children: <Widget>[
                  // Sizing Container
                  Container(
                    height: 164,
                  ),
                  // Card Content
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Color(0xFFD5F4FE),
                    ),
                    alignment: Alignment.center,
                    height: 128,
                    width: 288,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        S.current.card_01,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                    ),
                  ),
                  // Move Button
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      alignment: Alignment.center,
                      child: Container(
                        height: 40,
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
                              S.of(context).go_to_tourist_login,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ]),
              ),
              // endregion
            ]),
      )),
    );
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text(S.of(context).are_you_sure),
            content: new Text(S.of(context).exit_msg),
            actions: <Widget>[
              new GestureDetector(
                child: Text(S.of(context).no),
              ),
              SizedBox(height: 16),
              new GestureDetector(
                onTap: () => SystemNavigator.pop(),
                child: Text(S.of(context).yes),
              ),
            ],
          ),
        ) ??
        false;
  }
}
