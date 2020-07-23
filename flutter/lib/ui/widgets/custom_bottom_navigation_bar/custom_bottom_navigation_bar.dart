import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tourists/ui/guide/guide_home/guide_home.dart';

class CustomGuideBottomNavigationBar extends StatelessWidget {
  final int activePosition;
  final GuideHomeScreenState _guideHomeScreenState;
  final Color activeColor = Color(0xFF00FFA8);
  final Color inactiveColor = Colors.black;

  CustomGuideBottomNavigationBar(this.activePosition, this._guideHomeScreenState);

  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
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
                  onTap: (){
                    log('Moving To Page ' + 0.toString());
                    _guideHomeScreenState.moveToPage(0);
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
                            color: activePosition == 0
                                ? activeColor
                                : inactiveColor),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    log('Moving To Page ' + 1.toString());
                    _guideHomeScreenState.moveToPage(1);
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
                            color: activePosition == 1
                                ? activeColor
                                : inactiveColor),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    log('Moving To Page ' + 2.toString());
                    _guideHomeScreenState.moveToPage(2);
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
                            color: activePosition == 2
                                ? activeColor
                                : inactiveColor),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    log('Moving To Page ' + 3.toString());
                    _guideHomeScreenState.moveToPage(3);
                  },
                  child: Column(
                    children: <Widget>[
                      Icon(
                        Icons.payment,
                        color: activePosition == 3 ? activeColor : inactiveColor,
                      ),
                      Text(
                        'Orders',
                        style: TextStyle(
                            color: activePosition == 3
                                ? activeColor
                                : inactiveColor),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}