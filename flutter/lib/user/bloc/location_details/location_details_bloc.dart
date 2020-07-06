import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tourists/user/models/location_details/location_details.dart';
import 'package:tourists/user/services/location_details/location_details_service.dart';

@provide
class LocationDetailsBloc {

  final LocationDetailsService _locationDetailsService;

  LocationDetailsBloc(this._locationDetailsService);

  Subject<LocationDetailsModel> locationDetailsSubject= new PublishSubject<LocationDetailsModel>();
  Stream<LocationDetailsModel> get locationDetailsStream => locationDetailsSubject.stream;

  getLocation(String locationId) async {
    LocationDetailsModel model = await _locationDetailsService.getLocationDetails(locationId);
    locationDetailsSubject.add(model);
  }
}