import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:inject/inject.dart';
import 'package:tourists/module_authorization/authprization_module.dart';
import 'package:tourists/module_forms/forms_module.dart';
import 'package:tourists/module_guide/guide_list_module.dart';
import 'package:tourists/module_home/home_module.dart';
import 'package:tourists/module_locations/location_module.dart';
import 'package:tourists/module_orders/order_module.dart';
import 'package:tourists/module_settings/settings_module.dart';
import 'package:tourists/module_settings/settings_routes.dart';
import 'package:tourists/utils/language/language.dart';

import 'di/components/app.component.dart';
import 'generated/l10n.dart';
import 'module_chat/chat_module.dart';
import 'module_splash/splash_module.dart';

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
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  final AuthorizationModule _authorizationModule;
  final HomeModule _homeModule;
  final ChatModule _chatModule;
  final FormsModule _formsModule;
  final GuideListModule _guideListModule;
  final LocationModule _locationModule;
  final OrderModule _orderModule;
  final SplashModule _splashModule;
  final SettingsModule _settingsModule;

  final LanguageHelper _languageHelper;

  MyApp(
    this._languageHelper,
    this._authorizationModule,
    this._settingsModule,
    this._homeModule,
    this._splashModule,
    this._chatModule,
    this._locationModule,
    this._guideListModule,
    this._orderModule,
    this._formsModule,
  );

  @override
  Widget build(BuildContext context) {
    Map<String, WidgetBuilder> fullRoutesList = {};

    fullRoutesList.addAll(_authorizationModule.getRoutes());
    fullRoutesList.addAll(_homeModule.getRoutes());
    fullRoutesList.addAll(_chatModule.getRoutes());
    fullRoutesList.addAll(_formsModule.getRoutes());
    fullRoutesList.addAll(_locationModule.getRoutes());
    fullRoutesList.addAll(_guideListModule.getRoutes());
    fullRoutesList.addAll(_orderModule.getRoutes());
    fullRoutesList.addAll(_settingsModule.getRoutes());
    fullRoutesList.addAll(_splashModule.getRoutes());

    return StreamBuilder(
      stream: _languageHelper.languageStream,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        String currentLang;
        if (snapshot.hasData) {
          if (snapshot.data != null) {
            currentLang = snapshot.data;
          } else {
            currentLang = 'en';
          }
        } else {
          currentLang = 'en';
        }

        return MaterialApp(
            navigatorObservers: <NavigatorObserver>[observer],
            locale: Locale(currentLang),
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            theme: ThemeData(
                primaryColor: Colors.greenAccent,
                accentColor: Colors.greenAccent),
            supportedLocales: S.delegate.supportedLocales,
            title: 'Soyah',
            routes: fullRoutesList,
            initialRoute: SettingsRoute.settingsRoutes);
      },
    );
  }
}
