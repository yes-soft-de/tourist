import 'package:inject/inject.dart';
import 'package:flutter/material.dart';
import 'package:tourists/ui/guide/guide_home/guide_home.dart';
import 'package:tourists/persistence/sharedpref/shared_preferences_helper.dart';
import 'package:tourists/components/user/user_routes.dart';

@provide
class CustomGuideBottomNavigationBar extends StatefulWidget {
  final GuideHomeScreenState guideHomeScreenState;

  CustomGuideBottomNavigationBar(this.guideHomeScreenState);

  @override
  State<StatefulWidget> createState() => _CustomGuideBottomNavigatorState();
}

class _CustomGuideBottomNavigatorState
    extends State<CustomGuideBottomNavigationBar> {
  int activePosition = 0;
  final Color activeColor = Color(0xFF00FFA8);
  final Color inactiveColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetLayout = [];

    if (activePosition == 3) {
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

    widgetLayout.add(Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              activePosition = 0;
              widget.guideHomeScreenState.moveToPage(0);
              setState(() {});
            },
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.home,
                  color: activePosition == 0 ? activeColor : inactiveColor,
                ),
                Text(
                  'home',
                  style: TextStyle(
                      color: activePosition == 0 ? activeColor : inactiveColor),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              activePosition = 1;
              widget.guideHomeScreenState.moveToPage(1);
              setState(() {});
            },
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.account_circle,
                  color: activePosition == 1 ? activeColor : inactiveColor,
                ),
                Text(
                  'Guides',
                  style: TextStyle(
                      color: activePosition == 1 ? activeColor : inactiveColor),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              activePosition = 2;
              widget.guideHomeScreenState.moveToPage(2);
              setState(() {});
            },
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.event,
                  color: activePosition == 2 ? activeColor : inactiveColor,
                ),
                Text(
                  'Events',
                  style: TextStyle(
                      color: activePosition == 2 ? activeColor : inactiveColor),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              activePosition = 3;
              setState(() {});
            },
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.more_horiz,
                  color: activePosition == 3 ? activeColor : inactiveColor,
                ),
                Text(
                  'Orders',
                  style: TextStyle(
                      color: activePosition == 3 ? activeColor : inactiveColor),
                )
              ],
            ),
          ),
        ]));

    return Column(
      children: widgetLayout,
    );
  }
}
