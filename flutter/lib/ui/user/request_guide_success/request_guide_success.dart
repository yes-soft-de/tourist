import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/components/user/user_routes.dart';

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
                      'Requesting the guide was completed, he/she will contact you as soon as possible'),
                )),
          ),
          RaisedButton(
            child: Text('Return to Home'),
            onPressed: () {
              Navigator.pushReplacementNamed(
                  context, UserRoutes.home);
            },
          )
        ],
      ),
    );
  }
}
