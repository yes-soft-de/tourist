import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/module_locations/bloc/location_list/location_list_bloc.dart';
import 'package:tourists/module_shared/ui/widgets/carousel/carousel.dart';
import 'package:tourists/module_shared/ui/widgets/carousel_card/carousel_card.dart';

@provide
class LocationCarouselScreen extends StatefulWidget {
  final LocationListBloc bloc;

  LocationCarouselScreen(this.bloc);

  @override
  State<StatefulWidget> createState() => _LocationCarouselScreenState();
}

class _LocationCarouselScreenState extends State<LocationCarouselScreen> {
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
      default:
        return _getErrorScreen();
    }
  }

  Widget _getSuccessScreen() {
    List<Widget> locationWidgetList = [];

    locationList.forEach((location) {
      locationWidgetList.add(CarouselCard(
        title: location.name,
        description: location.description,
        image: location.path[0].path,
        commentsNumber: 2,
        stars: 2,
      ));
    });

    return CarouselWidget(locationWidgetList);
  }

  Widget _getErrorScreen() {
    return Flex(
      direction: Axis.horizontal,
      children: <Widget>[Text(S.of(context).error_fetching_data)],
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
