import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/module_locations/bloc/location_details/location_details_bloc.dart';
import 'package:tourists/module_locations/ui/states/location_details_state/location_details_state.dart';
import 'package:tourists/utils/auth_guard/auth_gard.dart';

@provide
class LocationDetailsScreen extends StatefulWidget {
  final LocationDetailsBloc _locationBloc;
  final AuthGuard _authGuard;

  LocationDetailsScreen(this._locationBloc, this._authGuard);

  @override
  State<StatefulWidget> createState() => _LocationDetailsScreenState();
}

class _LocationDetailsScreenState extends State<LocationDetailsScreen> {
  LocationDetailsState _currentState;

  @override
  void initState() {
    super.initState();
    widget._locationBloc.stateStream.stream.listen((event) {
      _currentState = event;
      if (mounted) setState(() {});
    });
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_currentState == null) {
      var locationId = ModalRoute.of(context).settings.arguments;
      widget._locationBloc.getLocation(locationId);
    }
    return Scaffold(body: _currentState?.getUI(context));
  }
}
