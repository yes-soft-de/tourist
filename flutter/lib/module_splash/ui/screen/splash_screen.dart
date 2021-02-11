import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/module_home/home_routes.dart';
import 'package:tourists/utils/language/language.dart';

@provide
class SplashScreen extends StatefulWidget {
  final LanguageHelper _languageHelper;

  SplashScreen(this._languageHelper);

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool configLoaded = false;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(HomeRoutes.home, (r) => false);
    });

    widget._languageHelper.getLanguage();

    return Scaffold(
        body: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 120,
              width: 120,
              alignment: Alignment.center,
              child: Image.asset('resources/images/logo.jpg'),
            ),
          ],
        )
      ],
    ));
  }
}
