import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inject/inject.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/module_authorization/guide_authorization_module/guide_authorization_routes.dart';
import 'package:tourists/module_authorization/login_selector_module/ui/widget/navigaton_card/navigation_card.dart';
import 'package:tourists/module_authorization/user_authorization_module/user_auth_routes.dart';

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
                onTap: () => Navigator.pushReplacementNamed(
                    context, UserAuthorizationRoutes.login),
                child: NavigationCard(S.of(context).card_01),
              ),

              // Divider
              Container(
                height: 56,
              ),

              // region Second Card
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, GuideAuthorizationRoutes.guideLogin);
                },
                child: NavigationCard(S.of(context).card_01),
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
