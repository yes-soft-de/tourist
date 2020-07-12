import 'dart:developer';

import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tourists/models/location_list_item/location_list_item.dart';
import 'package:tourists/services/location_list/location_list_service.dart';

@provide
class MainHomeBloc {
  LocationListService _locationListService;

  final _locationsListSubject = new PublishSubject<List<LocationListItem>>();

  get locationListStream => _locationsListSubject.stream;

  MainHomeBloc(this._locationListService);

  requestLocationList() {
    _locationListService.getLocationList().then((locationList) {
      log('Got this many locations ' + locationList.length.toString());
      _locationsListSubject.add(locationList);
    });
  }

  dispose() {
    _locationsListSubject.close();
  }
}
