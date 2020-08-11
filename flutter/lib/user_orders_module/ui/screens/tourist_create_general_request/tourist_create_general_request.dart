import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/ui/user/home/subscreens/tourist_guide_list/tourist_guide_list.dart';

@provide
class TouristCreateGeneralRequestScreen extends StatefulWidget {
  final TouristGuideListSubScreen _guideListSubScreen;
  TouristCreateGeneralRequestScreen(this._guideListSubScreen);

  @override
  State<StatefulWidget> createState() => _TouristCreateGeneralRequestScreenState();
}

class _TouristCreateGeneralRequestScreenState extends State<TouristCreateGeneralRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget._guideListSubScreen,
    );
  }
}