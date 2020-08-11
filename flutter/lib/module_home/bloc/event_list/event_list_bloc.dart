import 'package:analyzer_plugin/utilities/pair.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tourists/module_locations/model/event/event_model.dart';
import 'package:tourists/module_locations/service/event/event_service.dart';

@provide
class EventListBloc {
  static const STATUS_CODE_INIT = 480;
  static const STATUS_CODE_LOAD_SUCCESS = 490;
  static const STATUS_CODE_LOAD_ERROR = 500;

  final EventService _eventService;

  EventListBloc(this._eventService);

  PublishSubject<Pair<int, List<EventModel>>> _eventSubject =
      new PublishSubject<Pair<int, List<EventModel>>>();

  Stream<Pair<int, List<EventModel>>> get eventStream => _eventSubject.stream;

  getAllEvents() {
    _eventService.getAllEvents().then((value) {
      if (value == null) {
        _eventSubject.add(Pair(STATUS_CODE_LOAD_ERROR, null));
      } else {
        _eventSubject.add(Pair(STATUS_CODE_LOAD_SUCCESS, value));
      }
    });
  }
}
