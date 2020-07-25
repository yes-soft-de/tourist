import 'package:analyzer_plugin/utilities/pair.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tourists/models/guide_list_item/guide_list_item.dart';
import 'package:tourists/models/location_details/location_details.dart';
import 'package:tourists/services/location_details/location_details_service.dart';

@provide
class LocationDetailsBloc {
  static const int STATUS_CODE_INIT = 200;
  static const int STATUS_CODE_LOAD_SUCCESS = 201;
  static const int STATUS_CODE_LOAD_ERROR = 202;

  static const int KEY_STATUS = 321;
  static const int KEY_LOCATION_INFO = 311;
  static const int KEY_COMMENTS = 331;
  static const int KEY_GUIDES = 341;

  final LocationDetailsService _locationDetailsService;

  LocationDetailsBloc(this._locationDetailsService);

  Subject<Map<int, dynamic>> locationDetailsSubject= new PublishSubject<Map<int, dynamic>>();
  Stream<Map<int, dynamic>> get locationDetailsStream => locationDetailsSubject.stream;

  getLocation(String locationId) async {
    LocationDetailsModel model = await _locationDetailsService.getLocationDetails(locationId);
    List<GuideListItemModel> guides = await _locationDetailsService.getGuidesByLocationId(locationId);

    if (model == null || guides == null) {
      locationDetailsSubject.add({
        KEY_STATUS: STATUS_CODE_LOAD_ERROR
      });
      return;
    }

    locationDetailsSubject.add({
      KEY_STATUS: STATUS_CODE_LOAD_SUCCESS,
      KEY_LOCATION_INFO: model,
      KEY_GUIDES: guides
    });
  }
}

