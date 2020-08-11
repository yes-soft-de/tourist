import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/user_home_module/user_home_routes.dart';

@provide
class RequestGuideSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Center(
                child: Container(
                  width: 240,
                  child: Text(
                      S.of(context).request_guide_msg_success),
                )),
          ),
          RaisedButton(
            child: Text(S.of(context).return_to_home),
            onPressed: () {
              Navigator.pushReplacementNamed(
                  context, UserHomeRoutes.home);
            },
          )
        ],
      ),
    );
  }
}
