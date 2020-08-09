import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tourists/components/user/user_routes.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/nav_arguments/request_guide/request_guide_navigation.dart';

class RequestGuideButton extends StatelessWidget {
  final String cityId;

  RequestGuideButton({this.cityId});

  @override
  Widget build(BuildContext context) {
    String requestGuideMsg = cityId == null
        ? S.of(context).request_guide
        : S.of(context).request_tour;
    return GestureDetector(
      onTap: () {
        log("Request Guide Position");
        Navigator.pushNamed(context, UserRoutes.makeGeneralRequest);
        if (cityId != null) {
          Navigator.pushNamed(context, UserRoutes.requestGuide,
              arguments: RequestGuideNavigationArguments(cityId: cityId));
        }
      },
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  boxShadow: [],
                  color: Color(0xFF58595B),
                  borderRadius: BorderRadius.all(Radius.circular(90))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(90))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.add_circle,
                          color: Color(0x2D00FFA8),
                        ),
                      ),
                    ),
                    Container(
                      width: 16,
                    ),
                    Text(
                      requestGuideMsg,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Container(
                      width: 16,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
