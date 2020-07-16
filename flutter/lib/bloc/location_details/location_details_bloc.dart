import 'package:analyzer_plugin/utilities/pair.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tourists/models/guide_list_item/guide_list_item.dart';
import 'package:tourists/models/location_details/location_details.dart';
import 'package:tourists/services/location_details/location_details_service.dart';

@provide
class LocationDetailsBloc {
  static const int STATUS_CODE_INIT = 200;
  static const int STATUS_CODE_LOAD_FINISHED = 201;
  static const int STATUS_CODE_LOAD_ERROR = 202;

  final LocationDetailsService _locationDetailsService;

  LocationDetailsBloc(this._locationDetailsService);

  Subject<Pair<int, LocationDetailsBlocModel>> locationDetailsSubject= new PublishSubject<Pair<int, LocationDetailsBlocModel>>();
  Stream<Pair<int, LocationDetailsBlocModel>> get locationDetailsStream => locationDetailsSubject.stream;

  getLocation(String locationId) async {
    LocationDetailsModel model = await _locationDetailsService.getLocationDetails(locationId);
    List<GuideListItemModel> guides = await _locationDetailsService.getGuidesByLocationId(locationId);

    if (model == null || guides == null) {
      locationDetailsSubject.add(new Pair(STATUS_CODE_LOAD_ERROR, LocationDetailsBlocModel(locationDetails: model, guides: guides)));
      return;
    }

    locationDetailsSubject.add(new Pair(STATUS_CODE_LOAD_FINISHED, LocationDetailsBlocModel(locationDetails: model, guides: guides)));
  }
}

class LocationDetailsBlocModel {
  LocationDetailsModel locationDetails;
  List<GuideListItemModel> guides;

  LocationDetailsBlocModel({this.locationDetails, this.guides});
}
