import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/locations_module/ui/screens/location_carousel/location_carousel.dart';
import 'package:tourists/locations_module/ui/screens/location_list/location_list_screen.dart';

@provide
class LocationListSubScreen extends StatefulWidget {
  final LocationListScreen _locationListScreen;
  final LocationCarouselScreen _locationCarouselScreen;

  LocationListSubScreen(this._locationListScreen, this._locationCarouselScreen);

  @override
  State<StatefulWidget> createState() => _LocationListSubScreenState();
}

class _LocationListSubScreenState extends State<LocationListSubScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(S.of(context).title),
      ),
      body: ListView(
        children: <Widget>[
          widget._locationCarouselScreen,
          widget._locationListScreen
        ],
      ),
    );
  }
}
