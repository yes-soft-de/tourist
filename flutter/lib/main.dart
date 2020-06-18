import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:inject/inject.dart';
import 'package:tourists/routes.dart';
import 'package:tourists/ui/screens/account_type_selector/login_type_selector.dart';
import 'package:tourists/ui/screens/create_profile/create_profile.dart';
import 'package:tourists/ui/screens/home/home.dart';
import 'package:tourists/ui/screens/intention_profile/intention_profile.dart';
import 'package:tourists/ui/screens/login/login.dart';
import 'package:tourists/ui/screens/register/register.dart';

import 'di/components/app.component.dart';
import 'generated/l10n.dart';

typedef Provider<T> = T Function();

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]).then((_) async {
    final container = await AppComponent.create();
    runApp(container.app);
  });
}

@provide
class MyApp extends StatelessWidget {

  // This Screens is here because it needs to be injected!
  final LoginScreen _loginScreen;
  final RegisterScreen _registerScreen;
  final CreateProfileScreen _createProfileScreen;
  final IntentionProfileScreen _intentionProfileScreen;
  final HomeScreen _homeScreen;

  MyApp(this._loginScreen, this._registerScreen, this._createProfileScreen, this._homeScreen, this._intentionProfileScreen);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      title: 'Tourists',
      routes: {
        Routes.loginTypeSelector: (context) => LoginTypeSelectorScreen(),
        Routes.login: (context) => _loginScreen,
        Routes.register: (context) => _registerScreen,
        Routes.createProfile: (context) => _createProfileScreen,
        Routes.intentionProfile: (context) => _intentionProfileScreen,
        Routes.home: (context) => _homeScreen,
      },
      initialRoute: Routes.intentionProfile,
      home: LoginTypeSelectorScreen()
    );
  }
}
