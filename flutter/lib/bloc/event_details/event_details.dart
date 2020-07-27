import 'package:analyzer_plugin/utilities/pair.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tourists/models/event/event_model.dart';
import 'package:tourists/models/event_details/event_details_model.dart';
import 'package:tourists/models/location_list_item/location_list_item.dart';
import 'package:tourists/services/event/event_service.dart';
import 'package:tourists/services/location_list/location_list_service.dart';

@provide
class EventDetailsBloc {
  static const int STATUS_CODE_INIT = 951;
  static const int STATUS_CODE_LOAD_SUCCESS = 961;
  static const int STATUS_CODE_LOAD_ERROR = 971;

  static const int KEY_STATUS = 152;
  static const int KEY_LOCATION = 162;
  static const int KEY_EVENT = 172;

  final EventService _eventService;
  final LocationListService _locationListService;

  EventDetailsBloc(this._eventService, this._locationListService);

  PublishSubject<Map<int, dynamic>> _eventSubject = new PublishSubject();

  Stream<Map<int, dynamic>> get eventStream => _eventSubject.stream;

  getEventDetails(String id) async {
    EventModel eventDetailsModel = await this._eventService.getEvent(id);
    if (eventDetailsModel == null) {
      _eventSubject.add({KEY_STATUS: STATUS_CODE_LOAD_ERROR});
    }

    LocationListItem locationListItem =
        await getLocationByName(eventDetailsModel.location);

    _eventSubject.add({
      KEY_STATUS: STATUS_CODE_LOAD_SUCCESS,
      KEY_LOCATION: locationListItem,
      KEY_EVENT: eventDetailsModel
    });
  }

  Future<LocationListItem> getLocationByName(String name) async {
    List<LocationListItem> locations =
        await _locationListService.getLocationList();
    LocationListItem activeLocation;

    locations.forEach((element) {
      if (element.name == name) activeLocation = element;
    });

    return activeLocation;
  }
}
