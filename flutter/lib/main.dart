import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:inject/inject.dart';
import 'package:tourists/guide/guide_component.dart';
import 'package:tourists/guide/guide_routes.dart';
import 'package:tourists/routes.dart';
import 'package:tourists/user/ui/screens/account_type_selector/login_type_selector.dart';
import 'package:tourists/user/ui/screens/create_profile/create_profile.dart';
import 'package:tourists/user/ui/screens/home/home.dart';
import 'package:tourists/user/ui/screens/intention_profile/intention_profile.dart';
import 'package:tourists/user/ui/screens/login/login.dart';
import 'package:tourists/user/ui/screens/register/register.dart';
import 'package:tourists/user/user_component.dart';
import 'package:tourists/user/user_routes.dart';

import 'di/components/app.component.dart';
import 'generated/l10n.dart';

typedef Provider<T> = T Function();

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) async {
    final container = await AppComponent.create();
    runApp(container.app);
  });
}

@provide
class MyApp extends StatelessWidget {
  final UserComponent _userComponent;
  final GuideComponent _guideComponent;

  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
  FirebaseAnalyticsObserver(analytics: analytics);

  MyApp(this._userComponent, this._guideComponent);

  @override
  Widget build(BuildContext context) {
    Map<String, WidgetBuilder> fullRoutesList = Map();

    fullRoutesList.addAll(_userComponent.getRoutes());
    fullRoutesList.addAll(_guideComponent.getRoutes());

    return MaterialApp(
        navigatorObservers: <NavigatorObserver>[
          observer
        ],
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: ThemeData(
            primaryColor: Colors.greenAccent, accentColor: Colors.greenAccent),
        supportedLocales: S.delegate.supportedLocales,
        title: 'Tourists',
        routes: fullRoutesList,
        initialRoute: GuideRoutes.guideLogin,
        home: LoginTypeSelectorScreen());
  }
}
