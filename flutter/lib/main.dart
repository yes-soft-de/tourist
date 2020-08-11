import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:inject/inject.dart';
import 'package:tourists/guide_authorization_module/guide_authorization_module.dart';
import 'package:tourists/guide_home_module/guide_module.dart';
import 'package:tourists/locations_module/location_module.dart';
import 'package:tourists/user_authorization_module/user_auth.dart';
import 'package:tourists/user_home_module/user_component.dart';

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
  final UserAuthorizationModule _userAuthModule;
  final GuideAuthorizationModule _guideAuthModule;
  final UserHomeModule _userHomeModule;
  final GuideHomeModule _guideHomeModule;
  final LocationModule _locationModule;

  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  MyApp(this._userAuthModule, this._guideAuthModule, this._userHomeModule,
      this._guideHomeModule, this._locationModule);

  @override
  Widget build(BuildContext context) {
    Map<String, WidgetBuilder> fullRoutesList = Map();

    fullRoutesList.addAll(_userAuthModule.getRoutes());
    fullRoutesList.addAll(_guideAuthModule.getRoutes());
    fullRoutesList.addAll(_userHomeModule.getRoutes());
    fullRoutesList.addAll(_guideHomeModule.getRoutes());

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
        title: 'Soyah',
        routes: fullRoutesList,
        initialRoute: UserRoutes.home);
  }
}
