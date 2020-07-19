import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tourists/components/user/user_routes.dart';
import 'package:tourists/persistence/sharedpref/shared_preferences_helper.dart';
import 'package:tourists/ui/user/home/home.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final HomeScreenState _homeScreenState;
  final Color activeColor = Color(0xFF00FFA8);
  final Color inactiveColor = Colors.black;
  final int pagePosition;

  CustomBottomNavigationBar(this.pagePosition, this._homeScreenState);

  @override
  State<StatefulWidget> createState() =>
      _CustomBottomNavigationBarState(pagePosition);
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int activePosition;

  _CustomBottomNavigationBarState(this.activePosition);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetLayout = [];

    if (activePosition != 3) {
      widgetLayout.add(
        // Request Button
        Container(
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(90))),
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
                        'Request Guid!',
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
    } else {
      widgetLayout.add(Flex(
        direction: Axis.vertical,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, UserRoutes.orderPage);
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
                    Text("Orders"),
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
                Navigator.pushReplacementNamed(
                    context, UserRoutes.loginTypeSelector);
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
                    Text("Logout"),
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
                  activePosition = 0;
                  widget._homeScreenState.moveToPage(0);
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
                  widget._homeScreenState.moveToPage(1);
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
                  widget._homeScreenState.moveToPage(2);
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
