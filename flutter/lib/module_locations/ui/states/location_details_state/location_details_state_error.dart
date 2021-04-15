import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:tourists/module_locations/ui/states/location_details_state/location_details_state.dart';

class LocationDetailsStateError extends LocationDetailsState {
  String error;

  LocationDetailsStateError(this.error);

  @override
  Widget getUI(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Lottie.asset('resources/animations/404.json'),
      ),
    );
  }
}
