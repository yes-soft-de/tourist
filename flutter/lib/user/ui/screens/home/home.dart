import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/user/ui/screens/home/subscreens/main/main_home.dart';
import 'package:tourists/user/ui/screens/home/subscreens/tourist_event_list/tourist_event_list.dart';
import 'package:tourists/user/ui/screens/home/subscreens/tourist_guide_list/tourist_guide_list.dart';
import 'package:tourists/user/ui/screens/tourist_orders/tourist_order.dart';
import 'package:tourists/user/ui/widgets/bottom_navigation_bar/buttom_navigation_bar.dart';

@provide
class HomeScreen extends StatefulWidget {
  final MainHomeSubScreen _homeSubScreen;
  final TouristGuideListSubScreen _guideListScreen;
  final TouristEventListSubScreen _eventsSubScreen;
  final TouristOrdersScreen _touristOrdersScreen;

  HomeScreen(
      this._homeSubScreen, this._guideListScreen, this._eventsSubScreen, this._touristOrdersScreen);

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int position;

  PageController _pageController = PageController();

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
                widget._homeSubScreen,
                widget._guideListScreen,
                widget._eventsSubScreen,
                widget._touristOrdersScreen
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
            child: CustomBottomNavigationBar(position != null ? position : 0, this),
          )
        ],
      ),
    );
  }

  moveToPage(int position) {
    _pageController.animateToPage(position, duration: Duration(seconds: 1), curve: Curves.easeIn);
  }
}
