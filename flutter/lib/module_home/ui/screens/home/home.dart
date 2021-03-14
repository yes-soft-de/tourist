import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/module_auth/authorization_routes.dart';
import 'package:tourists/module_auth/service/auth_service/auth_service.dart';
import 'package:tourists/module_guide/ui/screen/guide_list/guide_list_screen.dart';
import 'package:tourists/module_home/home_routes.dart';
import 'package:tourists/module_locations/ui/screens/event_list/event_list.dart';
import 'package:tourists/module_locations/ui/screens/location_carousel/location_carousel.dart';
import 'package:tourists/module_locations/ui/screens/location_list/location_list_screen.dart';
import 'package:tourists/module_orders/orders_routes.dart';
import 'package:tourists/module_persistence/sharedpref/shared_preferences_helper.dart';
import 'package:tourists/module_profile/profile_routes.dart';
import 'package:tourists/module_search/search_routes.dart';
import 'package:tourists/module_settings/settings_routes.dart';
import 'package:tourists/module_shared/ui/widgets/request_guide_button/request_guide_button.dart';

@provide
class HomeScreen extends StatefulWidget {
  final GuideListScreen _guideListScreen;
  final EventListScreen _eventListScreen;
  final LocationListScreen _locationListScreen;
  final LocationCarouselScreen _locationCarouselScreen;
  final AuthService _authService;

  HomeScreen(
    this._locationListScreen,
    this._guideListScreen,
    this._eventListScreen,
    this._authService,
    this._locationCarouselScreen,
  );

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int position;
  bool loggedIn;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    if (loggedIn == null) {
      widget._authService.isLoggedIn.then((value) {
        loggedIn = value;
        setState(() {});
      });
    }

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: PageView(
              controller: _pageController,
              children: <Widget>[
                Stack(children: [
                  Positioned.fill(
                    child: ListView(
                      children: <Widget>[
                        AppBar(
                          backgroundColor: Colors.white,
                          centerTitle: true,
                          title: Text('سياح'),
                          actions: [
                            IconButton(
                              icon: Icon(Icons.search),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(SearchRoutes.ROUTE_SEARCH);
                              },
                            ),
                          ],
                        ),
                        widget._locationCarouselScreen,
                        widget._locationListScreen,
                        Container(height: 112,),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          _changePosition(1);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RequestGuideButton(),
                        ),
                      ),
                    ),
                  ),
                ]),
                widget._guideListScreen,
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
            child: position == 3 ? moreColumn() : Container(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: position ?? 0,
          selectedIconTheme:
              IconThemeData(color: Theme.of(context).primaryColor),
          unselectedIconTheme: IconThemeData(color: Colors.grey),
          unselectedItemColor: Colors.grey,
          unselectedLabelStyle: TextStyle(color: Colors.grey),
          selectedItemColor: Theme.of(context).primaryColor,
          selectedLabelStyle: TextStyle(color: Theme.of(context).primaryColor),
          onTap: (pos) {
            _changePosition(pos);
            return true;
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: S.of(context).home,
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle), label: S.of(context).guides),
            BottomNavigationBarItem(
                icon: Icon(Icons.event), label: S.of(context).events),
            BottomNavigationBarItem(
                icon: Icon(Icons.more_horiz), label: S.of(context).more),
          ]),
    );
  }

  Flex moreColumn() {
    return Flex(
      direction: Axis.vertical,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(OrdersRoutes.ordersList);
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
            Navigator.of(context).pushNamed(SettingsRoute.settingsRoutes);
          },
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Icon(Icons.settings),
                  Container(
                    width: 16,
                  ),
                  Text(S.of(context).settings),
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, ProfileRoutes.MY_ROUTE_PROFILE);
          },
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Icon(Icons.person),
                  Container(
                    width: 16,
                  ),
                  Text(S.of(context).profile)
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
              Navigator.pushNamed(context, AuthorizationRoutes.LOGIN_SCREEN);
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
                  GestureDetector(
                      onTap: () {
                        if (loggedIn == true) {
                          widget._authService.logout().then((value) {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                HomeRoutes.home, (route) => false);
                          });
                        } else {
                          Navigator.of(context)
                              .pushNamed(AuthorizationRoutes.LOGIN_SCREEN);
                        }
                      },
                      child: Text(loggedIn == true
                          ? S.of(context).logout
                          : S.of(context).login)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _changePosition(position) {
    if (position < 3) _pageController.jumpToPage(position);
    setState(() {
      this.position = position;
    });
  }
}
