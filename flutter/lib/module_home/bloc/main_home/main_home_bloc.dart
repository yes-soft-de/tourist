import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tourists/module_locations/model/location_list_item/location_list_item.dart';
import 'package:tourists/module_locations/service/location_list/location_list_service.dart';
import 'package:tourists/utils/logger/logger.dart';

@provide
class MainHomeBloc {
  final LocationListService _locationListService;
  final Logger _logger;
  final String tag = 'MainHomeBloc';
  MainHomeBloc(this._locationListService, this._logger);

  final _locationsListSubject = new PublishSubject<List<LocationListItem>>();
  Stream<List<LocationListItem>> get locationListStream =>
      _locationsListSubject.stream;

  void requestLocationList() {
    _locationListService.getLocationList().then((locationList) {
      if (locationList != null) {
        _locationsListSubject.add(locationList);
      } else {
        _logger.info(tag, 'Null List');
      }
    });
  }

  void dispose() {
    _locationsListSubject.close();
  }
}
