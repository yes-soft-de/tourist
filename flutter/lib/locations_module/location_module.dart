import 'dart:js';

import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/abstracts/module/yes_module.dart';
import 'package:tourists/locations_module/location_routes.dart';
import 'package:tourists/locations_module/ui/screens/event_details/event_details_screen.dart';
import 'package:tourists/locations_module/ui/screens/location_details/location_details.dart';

@provide
class LocationModule extends YesModule {
  final LocationDetailsScreen _locationDetailsScreen;
  final EventDetailsScreen _eventDetailsScreen;

  LocationModule(
      this._locationDetailsScreen, this._eventDetailsScreen);

  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {
      LocationRoutes.eventDetails: (context) => _eventDetailsScreen,
      LocationRoutes.locationDetails: (context) => _locationDetailsScreen
    };
  }
}
