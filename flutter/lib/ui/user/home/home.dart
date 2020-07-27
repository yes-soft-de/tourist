import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/persistence/sharedpref/shared_preferences_helper.dart';
import 'package:tourists/ui/user/home/subscreens/main/main_home.dart';
import 'package:tourists/ui/user/home/subscreens/tourist_event_list/tourist_event_list.dart';
import 'package:tourists/ui/user/home/subscreens/tourist_guide_list/tourist_guide_list.dart';
import 'package:tourists/ui/widgets/bottom_navigation_bar/buttom_navigation_bar.dart';

@provide
class HomeScreen extends StatefulWidget {
  final MainHomeSubScreen _homeSubScreen;
  final TouristGuideListSubScreen _guideListScreen;
  final TouristEventListSubScreen _eventsSubScreen;
  final SharedPreferencesHelper _preferencesHelper;

  HomeScreen(this._homeSubScreen, this._guideListScreen, this._eventsSubScreen,
      this._preferencesHelper);

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int position;

  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {

    Widget bottomNavBar = CustomBottomNavigationBar(
        pagePosition: position != null ? position : 0,
        homeScreenState: this
    );

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
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
                  widget._eventsSubScreen
                ],
                onPageChanged: (pos) {
                  // Update the Home Page
                  position = pos;
                  bottomNavBar = CustomBottomNavigationBar(
                      pagePosition: position != null ? position : 0,
                      homeScreenState: this
                  );
                  setState(() {});
                },
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: bottomNavBar,
            )
          ],
        ),
      ),
    );
  }

  moveToPage(int position) {
    _pageController.jumpToPage(position);
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text(S.of(context).are_you_sure),
            content: new Text(S.of(context).exit_msg),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text(S.of(context).no),
              ),
              SizedBox(height: 16),
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(true),
                child: Text(S.of(context).yes),
              ),
            ],
          ),
        ) ??
        false;
  }
}
