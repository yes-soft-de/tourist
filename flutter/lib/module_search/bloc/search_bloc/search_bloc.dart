import 'dart:async';

import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tourists/module_locations/service/google_locations/google_locations_service.dart';
import 'package:tourists/utils/debouncer/debouncer.dart';

@provide
class SearchBloc {
  final _stateSubject = PublishSubject();
  final _searchSuggestionSubject = PublishSubject<Map<String, String>>();

  Stream get stateStream => _stateSubject.stream;

  Stream<Map<String, String>> get predictionStream =>
      _searchSuggestionSubject.stream;

  final GoogleLocationsService _locationsService;

  SearchBloc(this._locationsService);

  Timer _debounce;

  void getPredictions(String query) {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _locationsService.getPredictions(query).then(
        (value) {
          print('New Suggestion Batch');
          _searchSuggestionSubject.add(value);
        },
      );
    });
  }
}
