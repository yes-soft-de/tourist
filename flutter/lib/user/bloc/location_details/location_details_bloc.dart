import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tourists/user/models/guide_list_item/guide_list_item.dart';
import 'package:tourists/user/models/location_details/location_details.dart';
import 'package:tourists/user/services/location_details/location_details_service.dart';

@provide
class LocationDetailsBloc {

  final LocationDetailsService _locationDetailsService;

  LocationDetailsBloc(this._locationDetailsService);

  Subject<LocationDetailsBlocModel> locationDetailsSubject= new PublishSubject<LocationDetailsBlocModel>();
  Stream<LocationDetailsBlocModel> get locationDetailsStream => locationDetailsSubject.stream;

  getLocation(String locationId) async {
    LocationDetailsModel model = await _locationDetailsService.getLocationDetails(locationId);
    List<GuideListItemModel> guides = await _locationDetailsService.getGuidesByLocationId(locationId);

    locationDetailsSubject.add(new LocationDetailsBlocModel(locationDetails: model, guides: guides));
  }
}

class LocationDetailsBlocModel {
  LocationDetailsModel locationDetails;
  List<GuideListItemModel> guides;

  LocationDetailsBlocModel({this.locationDetails, this.guides});
}
