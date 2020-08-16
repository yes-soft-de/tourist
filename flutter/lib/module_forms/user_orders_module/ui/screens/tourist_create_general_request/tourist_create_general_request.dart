import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/module_guide/ui/screen/guide_list/guide_list_screen.dart';

@provide
class TouristCreateGeneralRequestScreen extends StatefulWidget {
  final GuideListScreen _guideListSubScreen;
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