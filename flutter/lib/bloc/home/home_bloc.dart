import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tourists/models/location_list_item/location_list_item.dart';
import 'package:tourists/services/location_list/location_list_service.dart';

@provide
class HomeBloc {
  LocationListService _locationListService;

  final _locationsListSubject = new PublishSubject<List<LocationListItem>>();
  get locationListStream => _locationsListSubject.stream;

  HomeBloc(this._locationListService);

  requestLocationList() {
    _locationListService.getLocationList().then((locationList) => _locationsListSubject.add(locationList));
  }

  dispose() {
    _locationsListSubject.close();
  }
}