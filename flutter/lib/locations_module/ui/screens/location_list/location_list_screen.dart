import 'package:flutter/material.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/locations_module/bloc/location_list/location_list_bloc.dart';
import 'package:tourists/locations_module/location_routes.dart';
import 'package:tourists/locations_module/ui/widgets/location_list_item/location_list_item.dart';

class LocationListScreen extends StatefulWidget {
  final LocationListBloc bloc;

  LocationListScreen(this.bloc);

  @override
  State<StatefulWidget> createState() => _LocationListScreenState();
}

class _LocationListScreenState extends State<LocationListScreen> {
  List locationList;
  int currentStatus = -1;

  @override
  Widget build(BuildContext context) {
    widget.bloc.stateStream.listen((event) {
      currentStatus = event[LocationListBloc.KEY_STATUS];

      if (currentStatus == LocationListBloc.STATUS_CODE_LOAD_SUCCESS) {
        locationList = event[LocationListBloc.KEY_PAYLOAD];
      }

      setState(() {});
    });

    switch (currentStatus) {
      case LocationListBloc.STATUS_CODE_INIT:
        widget.bloc.requestLocationList();
        return _getLoadingScreen();
      case LocationListBloc.STATUS_CODE_LOAD_SUCCESS:
        return _getSuccessScreen();
      case LocationListBloc.STATUS_CODE_LOAD_ERROR:
        return _getErrorScreen();
    }
  }

  Widget _getSuccessScreen() {
    List<Widget> locationWidgetList = [];

    locationList.forEach((location) {
      locationWidgetList.add(GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            LocationRoutes.locationDetails,
            arguments: location.id.toString(),
          );
        },
        child: Padding(
          padding: EdgeInsets.all(8),
          child: LocationListItemWidget(
            imageLink: location.path[0].path,
            title: location.name,
            description: location.description,
            rate: 2,
            commentsNumber: 2,
          ),
        ),
      ));
    });

    return Flex(
      direction: Axis.vertical,
      children: locationList,
    );
  }

  Widget _getErrorScreen() {
    return Flex(
      direction: Axis.horizontal,
      children: <Widget>[
        Text(S.of(context).error_fetching_data)
      ],
    );
  }

  Widget _getLoadingScreen() {
    return Flex(
      direction: Axis.vertical,
      children: <Widget>[
        CircularProgressIndicator(),
        Text('Loading Data from Network')
      ],
    );
  }
}
