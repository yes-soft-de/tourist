import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/module_forms/user_orders_module/ui/screens/request_guide/request_guide_screen.dart';

@provide
class TouristGuideListSubScreen extends StatefulWidget {

  final RequestGuideScreen _requestGuideScreen;

  TouristGuideListSubScreen(this._requestGuideScreen);

  @override
  State<StatefulWidget> createState() => _TouristGuideListSubScreenState();
}

class _TouristGuideListSubScreenState extends State<TouristGuideListSubScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
