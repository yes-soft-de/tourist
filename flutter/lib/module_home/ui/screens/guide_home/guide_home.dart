import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/module_home/ui/widget/custom_bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import 'package:tourists/module_locations/ui/screens/location_list/location_list_screen.dart';
import 'package:tourists/module_orders/ui/screen/orders_list/order_list_screen.dart';

@provide
class GuideHomeScreen extends StatefulWidget {
  final OrdersListScreen _ordersListScreen;
  final LocationListScreen _locationListScreen;

  GuideHomeScreen(this._ordersListScreen, this._locationListScreen);

  @override
  State<StatefulWidget> createState() => GuideHomeScreenState(0);
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
                widget._ordersListScreen,
                widget._locationListScreen,
                widget._ordersListScreen,
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