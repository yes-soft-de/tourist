import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tourists/components/user/user_routes.dart';
import 'package:tourists/nav_arguments/request_guide/request_guide_navigation.dart';

class GuideListItemWidget extends StatelessWidget {
  final String guideName;
  final String guideLanguage;
  final String guideImage;
  final String availability;
  final double rate;
  final String guideCity;

  GuideListItemWidget(
      {Key key,
      @required this.guideName,
      @required this.guideImage,
      @required this.guideLanguage,
      @required this.rate,
      @required this.guideCity,
      @required this.availability});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 128,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // TODO: Show Profile when clicking on image
              // Image
              Container(
                height: 96,
                width: 96,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(90))),
                child: Image.network(
                  guideImage,
                  fit: BoxFit.fitHeight,
                ),
              ),
              Container(
                width: 8,
              ),
              // Info
              Flex(
                direction: Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    guideName,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  Text(guideLanguage + guideCity),
                  Flex(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      Text(
                        availability,
                        style: TextStyle(),
                      ),
                      Container(
                        width: 8,
                      ),
                      getStarsLine()
                    ],
                  )
                ],
              ),
              // Divider
              Container(
                width: 8,
              ),
              // Request Button
              GestureDetector(
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(90)),
                      border: Border.all(color: Colors.black)),
                  child: Icon(Icons.add),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getStarsLine() {
    List<Widget> starsLine = [];

    for (int i = 0; i < rate; i++) {
      starsLine.add(Icon(
        Icons.star,
        size: 16,
      ));
    }

    return Flex(
      direction: Axis.horizontal,
      children: starsLine,
    );
  }
}
