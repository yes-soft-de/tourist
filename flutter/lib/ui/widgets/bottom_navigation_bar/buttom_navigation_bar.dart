import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tourists/components/user/user_routes.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/persistence/sharedpref/shared_preferences_helper.dart';
import 'package:tourists/ui/user/home/home.dart';
import 'package:tourists/ui/widgets/request_guide_button/request_guide_button.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final HomeScreenState homeScreenState;
  final Color activeColor = Color(0xFF00FFA8);
  final Color inactiveColor = Colors.black;
  final int pagePosition;
  final String cityId;

  CustomBottomNavigationBar(
      {this.pagePosition, @required this.homeScreenState, this.cityId});

  @override
  State<StatefulWidget> createState() =>
      _CustomBottomNavigationBarState(pagePosition);
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int activePosition = 0;
  bool moreActive = false;

  _CustomBottomNavigationBarState(this.activePosition);

  @override
  Widget build(BuildContext context) {
    activePosition = widget.pagePosition;

    List<Widget> widgetLayout = [];

    if (!moreActive) {
      widgetLayout.add(GestureDetector(child: RequestGuideButton()));
    } else {
      widgetLayout.add(Flex(
        direction: Axis.vertical,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, UserRoutes.orderPage);
            },
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Icon(Icons.credit_card),
                    Container(
                      width: 16,
                    ),
                    Text(S.of(context).orders),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              SharedPreferencesHelper preferencesHelper =
                  new SharedPreferencesHelper();
              preferencesHelper.clearData().then((value) {
                Navigator.pushNamed(context, UserRoutes.loginTypeSelector);
              });
            },
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Icon(Icons.exit_to_app),
                    Container(
                      width: 16,
                    ),
                    Text(S.of(context).logout),
                  ],
                ),
              ),
            ),
          )
        ],
      ));
    }

    widgetLayout.addAll([
      // Divider
      Container(
        height: 16,
      ),

      // Nav bar
      Container(
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              color: Colors.black,
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 20))
        ]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  log('Moving To Page ' + 0.toString());
                  moreActive = false;
                  activePosition = 0;
                  setState(() {});
                  widget.homeScreenState.moveToPage(0);
                },
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.home,
                      color: activePosition == 0
                          ? widget.activeColor
                          : widget.inactiveColor,
                    ),
                    Text(
                      'home',
                      style: TextStyle(
                          color: activePosition == 0
                              ? widget.activeColor
                              : widget.inactiveColor),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  log('Moving To Page ' + 1.toString());
                  activePosition = 1;
                  moreActive = false;
                  setState(() {});
                  widget.homeScreenState.moveToPage(1);
                },
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.account_circle,
                      color: activePosition == 1
                          ? widget.activeColor
                          : widget.inactiveColor,
                    ),
                    Text(
                      'Guides',
                      style: TextStyle(
                          color: activePosition == 1
                              ? widget.activeColor
                              : widget.inactiveColor),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  log('Moving To Page ' + 2.toString());
                  activePosition = 2;
                  moreActive = false;
                  setState(() {});
                  widget.homeScreenState.moveToPage(2);
                },
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.event,
                      color: activePosition == 2
                          ? widget.activeColor
                          : widget.inactiveColor,
                    ),
                    Text(
                      'Events',
                      style: TextStyle(
                          color: activePosition == 2
                              ? widget.activeColor
                              : widget.inactiveColor),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  log('Moving To Page ' + 3.toString());
                  activePosition = 3;
                  moreActive = true;
                  setState(() {});
                },
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.more_horiz,
                      color: activePosition == 3
                          ? widget.activeColor
                          : widget.inactiveColor,
                    ),
                    Text(
                      'More',
                      style: TextStyle(
                          color: activePosition == 3
                              ? widget.activeColor
                              : widget.inactiveColor),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    ]);

    return Column(
      children: widgetLayout,
    );
  }
}
