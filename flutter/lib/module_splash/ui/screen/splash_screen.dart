import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inject/inject.dart';
import 'package:tourists/consts/urls.dart';
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
    widget._languageHelper.getLanguage();

    if (configLoaded != true) {
      setUpRemoteConfig(context);
    }

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
            )
          ],
        )
      ],
    ));
  }

  Future<void> setUpRemoteConfig(BuildContext context) async {
    try {
      final RemoteConfig remoteConfig = await RemoteConfig.instance;
      await remoteConfig.fetch(expiration: const Duration(seconds: 0));
      await remoteConfig.activateFetched();

      String base = remoteConfig.getString('server');

      if (base == null) {
        await Fluttertoast.showToast(msg: 'Connection Error');
        print('Didn\'t get the Config:(');
        return false;
      } else {
        print('Config: Size: ' + remoteConfig.getAll().length.toString());
        String serverName = remoteConfig.getString('server');
        print('Got this as a Config: Server ' + serverName);
        Urls.baseAPI = serverName;
      }

      Urls.baseAPI = base != null
          ? remoteConfig.getString('server')
          : 'http://35.228.120.165/';
      configLoaded = true;
      await Navigator.of(context)
          .pushNamedAndRemoveUntil(HomeRoutes.home, (r) => false);
    } catch (e) {
      await setUpRemoteConfig(context);
    }
  }
}
