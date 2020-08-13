import 'package:flutter/material.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/module_authorization/authorization_routes.dart';
import 'package:tourists/module_orders/orders_routes.dart';
import 'package:tourists/module_persistence/sharedpref/shared_preferences_helper.dart';
import 'package:tourists/module_shared/ui/widgets/request_guide_button/request_guide_button.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final Color activeColor = Color(0xFF00FFA8);
  final Color inactiveColor = Colors.black;
  final int activePosition;

  final void Function(int) onLocationChanged;
  final BuildContext context;

  CustomBottomNavigationBar(
      {@required this.activePosition,
      @required this.context,
      @required this.onLocationChanged});

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetLayout = [];

    if (activePosition == 3) {
      widgetLayout.add(moreColumn());
    } else if (activePosition == 0) {
      widgetLayout.add(GestureDetector(
          onTap: () {
            onLocationChanged(1);
          },
          child: RequestGuideButton()));
    }

    widgetLayout.addAll([
      // Divider
      Container(
          height: 16,
          color: activePosition == 3 ? Colors.white : Colors.transparent),

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
        child: Padding(padding: const EdgeInsets.all(8.0), child: baseNavBar()),
      )
    ]);

    return Column(
      children: widgetLayout,
    );
  }

  Widget navItem(String iconName, IconData icon, bool active) {
    return Column(
      children: <Widget>[
        Icon(
          icon,
          color: active ? activeColor : inactiveColor,
        ),
        Text(
          iconName,
          style: TextStyle(color: active ? activeColor : inactiveColor),
        )
      ],
    );
  }

  Widget baseNavBar() {
    return Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        GestureDetector(
            onTap: () {
              onLocationChanged(0);
            },
            child:
                navItem(S.of(context).home, Icons.home, activePosition == 0)),
        GestureDetector(
            onTap: () {
              onLocationChanged(1);
            },
            child: navItem(S.of(context).guides, Icons.account_circle,
                activePosition == 1)),
        GestureDetector(
          onTap: () {
            onLocationChanged(2);
          },
          child:
              navItem(S.of(context).events, Icons.event, activePosition == 2),
        ),
        GestureDetector(
          onTap: () {
            onLocationChanged(3);
          },
          child: navItem(
              S.of(context).more, Icons.more_horiz, activePosition == 3),
        ),
      ],
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
            SharedPreferencesHelper preferencesHelper =
                new SharedPreferencesHelper();
            preferencesHelper.clearData().then((value) {
              Navigator.pushNamed(
                  context, AuthorizationRoutes.loginTypeSelector);
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
                  Text(S.of(context).logout),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
