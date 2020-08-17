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
      Navigator.of(context).pushReplacementNamed(HomeRoutes.home);
    });

    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [Image.asset('resources/images/logo.jpg')],
    ));
  }

  Future<void> setUpRemoteConfig() async {
    final RemoteConfig remoteConfig = await RemoteConfig.instance;

    Urls.baseAPI = remoteConfig.getString('server') != null
        ? remoteConfig.getString('server')
        : 'http://35.228.120.165/';

    return;
  }
}
