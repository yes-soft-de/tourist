import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import './subscreens/main/guide_main_subscreen.dart';
import 'package:tourists/ui/widgets/custom_bottom_navigation_bar/custom_bottom_navigation_bar.dart';

@provide
class GuideHomeScreen extends StatefulWidget {
  final GuideMainSubScreen _guideMainSubScreen;

  GuideHomeScreen(this._guideMainSubScreen);

  @override
  State<StatefulWidget> createState() => GuideHomeScreenState(0);

  moveToPage(int position) {
    createState() => GuideHomeScreenState(position);
  }
}

class GuideHomeScreenState extends State<GuideHomeScreen> {
  int position;
  PageController _pageController = PageController();

  GuideHomeScreenState(this.position);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 56,
            child: PageView(
              controller: _pageController,
              children: <Widget>[
                widget._guideMainSubScreen,
                widget._guideMainSubScreen,
                widget._guideMainSubScreen,
              ],
              onPageChanged: (pos) {
                // Update the Home Page
                position = pos;
                setState(() {});
              },
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomGuideBottomNavigationBar(this),
          )
        ],
      ),
    );
  }

  moveToPage(int position) {
    _pageController.jumpToPage(position);
  }
}