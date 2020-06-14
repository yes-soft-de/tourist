import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:inject/inject.dart';
import 'package:tourists/routes.dart';
import 'package:tourists/ui/screens/account_type_selector/login_type_selector.dart';
import 'package:tourists/ui/screens/login/login.dart';

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

  MyApp(this._loginScreen);

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
        Routes.login: (context) => _loginScreen
      },
      initialRoute: Routes.loginTypeSelector,
      home: LoginTypeSelectorScreen()
    );
  }
}
