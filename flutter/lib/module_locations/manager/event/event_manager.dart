import 'package:inject/inject.dart';
import 'package:tourists/module_locations/repository/event/event_repository.dart';
import 'package:tourists/module_locations/response/event_details/event_details.dart';
import 'package:tourists/module_locations/response/event_list/event_list.dart';

@provide
class EventManager {
  final EventRepository _repository;
  EventManager(this._repository);

  Future<EventListResponse> getAllEvents() {
    return _repository.getAllEvents();
  }

  Future<EventResponse> getEvent(String id) {
    return _repository.getEvent(id);
  }
}