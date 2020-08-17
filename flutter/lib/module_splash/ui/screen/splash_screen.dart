import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/consts/urls.dart';
import 'package:tourists/module_home/home_routes.dart';

@provide
class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    setUpRemoteConfig().then((value) {
      if (value)
        Future.delayed(Duration(seconds: 3), () {
          Navigator.of(context).pushReplacementNamed(HomeRoutes.home);
        });
    });

    return Scaffold(
        body: Column(
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
    ));
  }

  Future<bool> setUpRemoteConfig() async {
    final RemoteConfig remoteConfig = await RemoteConfig.instance;
    await remoteConfig.fetch(expiration: const Duration(seconds: 0));
    await remoteConfig.activateFetched();

    String base = remoteConfig.getString('server');

    if (base == null) {
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

    return true;
  }
}
