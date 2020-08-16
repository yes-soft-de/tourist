import 'package:inject/inject.dart';
import 'package:tourists/module_locations/manager/event/event_manager.dart';
import 'package:tourists/module_locations/model/event/event_model.dart';
import 'package:tourists/module_locations/response/event_details/event_details.dart';
import 'package:tourists/module_locations/response/event_list/event_list.dart';

@provide
class EventService {
  final EventManager _manager;

  EventService(this._manager);

  Future<List<EventModel>> getAllEvents() async {
    EventListResponse response = await _manager.getAllEvents();

    if (response == null) {
      return [];
    }

    List<EventModel> eventList = [];
    response.data.forEach((element) {
      eventList.add(EventModel(
          id: element.id,
          name: element.name,
          type: element.type,
          subType: element.subType,
          description: element.description,
          date: element.date,
          images: element.images,
          status: element.status));
    });

    return eventList;
  }

  Future<EventModel> getEvent(String id) async {
    EventResponse response = await _manager.getEvent(id);

    if (response != null)
      return EventModel(
          id: response.data.id,
          name: response.data.name,
          type: response.data.type,
          subType: response.data.subType,
          description: response.data.description,
          images: response.data.images,
          date: response.data.date,
          status: response.data.status);
    return null;
  }
}
