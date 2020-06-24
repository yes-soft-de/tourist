import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/user/ui/screens/home/subscreens/main/main_home.dart';
import 'package:tourists/user/ui/screens/home/subscreens/tourist_guide_list/tourist_guide_list.dart';
import 'package:tourists/user/ui/widgets/bottom_navigation_bar/buttom_navigation_bar.dart';

@provide
class HomeScreen extends StatefulWidget {
  final MainHomeSubScreen _homeSubScreen;
  final TouristGuideListSubScreen _guideListScreen;
  final TouristGuideListSubScreen _guideListSubScreen;

  HomeScreen(
      this._homeSubScreen, this._guideListScreen, this._guideListSubScreen);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int position;

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
              children: <Widget>[
                widget._homeSubScreen,
                widget._guideListScreen,
                widget._guideListSubScreen
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
            child: CustomBottomNavigationBar(position),
          )
        ],
      ),
    );
  }
}
