import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/module_guide/ui/screen/guide_list/guide_list_screen.dart';
import 'package:tourists/module_home/home_routes.dart';
import 'package:tourists/module_home/ui/widget/bottom_navigation_bar/buttom_navigation_bar.dart';
import 'package:tourists/module_locations/ui/screens/event_list/event_list.dart';
import 'package:tourists/module_locations/ui/screens/location_carousel/location_carousel.dart';
import 'package:tourists/module_locations/ui/screens/location_list/location_list_screen.dart';
import 'package:tourists/module_persistence/sharedpref/shared_preferences_helper.dart';
import 'package:tourists/utils/auth_guard/auth_gard.dart';

@provide
class HomeScreen extends StatefulWidget {
  final GuideListScreen _guideListScreen;
  final EventListScreen _eventListScreen;
  final LocationListScreen _locationListScreen;
  final LocationCarouselScreen _locationCarouselScreen;
  final AuthGuard _authGuard;

  final SharedPreferencesHelper _preferencesHelper;

  HomeScreen(
      this._locationListScreen,
      this._guideListScreen,
      this._eventListScreen,
      this._preferencesHelper,
      this._authGuard,
      this._locationCarouselScreen);

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int position;
  bool loggedIn;
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    if (loggedIn == null)
      widget._authGuard.isLoggedIn().then((value) {
        loggedIn = value;
        return _getUI();
      });

    return Container();
  }

  _getUI() {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('سياح'),
          actions: <Widget>[
            GestureDetector(
                onTap: () {
                  widget._preferencesHelper.getLoggedInState().then((value) {
                    if (value != null) if (value == LoggedInState.GUIDE) {
                      Navigator.of(context).pushNamed(HomeRoutes.guideHome);
                    }
                  });
                },
                child: Icon(loggedIn ? Icons.person : Icons.perm_identity))
          ],
        ),
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
                  ListView(
                    children: <Widget>[
                      widget._locationCarouselScreen,
                      widget._locationListScreen,
                    ],
                  ),
                  ListView(
                    children: <Widget>[widget._guideListScreen],
                  ),
                  widget._eventListScreen
                ],
                onPageChanged: (pos) {
                  _changePosition(pos);
                },
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: CustomBottomNavigationBar(
                activePosition: position != null ? position : 0,
                context: context,
                isLoggedIn: loggedIn,
                onLocationChanged: (int position) {
                  _changePosition(position);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  _changePosition(position) {
    if (position < 3) _pageController.jumpToPage(position);
    setState(() {
      this.position = position;
    });
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
