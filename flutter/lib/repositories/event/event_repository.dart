import 'dart:convert';

import 'package:inject/inject.dart';
import 'package:tourists/consts/urls.dart';
import 'package:tourists/network/http_client/http_client.dart';
import 'package:tourists/responses/event_details/event_details.dart';
import 'package:tourists/responses/event_list/event_list.dart';

@provide
class EventRepository {
  HttpClient _httpClient;
  EventRepository(this._httpClient);

  Future<EventListResponse> getAllEvents() async {
    String response = await _httpClient.get(Urls.event);

    if (response != null) {
      return EventListResponse.fromJson(jsonDecode(response));
    }

    return null;
  }

  Future<EventResponse> getEvent(String id) async {
    String response  = await _httpClient.get(Urls.event + '/' + id);

    if (response != null) {
      return EventResponse.fromJson(jsonDecode(response));
    }

    return null;
  }
}