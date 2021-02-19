import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:inject/inject.dart';
import 'package:tourists/module_search/bloc/search_bloc/search_bloc.dart';

@provide
class SearchScreen extends StatefulWidget {
  final SearchBloc bloc;

  SearchScreen(this.bloc);

  @override
  State<StatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String currentLocation;
  bool showPredictions = true;
  Map<String, String> predictions = {};

  final _searchController = TextEditingController();

  @override
  void initState() {
    widget.bloc.predictionStream.listen((event) {
      predictions = event;
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _searchController,
                onChanged: (query) {
                  if (query.isNotEmpty) {
                    showPredictions = true;
                    widget.bloc.getPredictions(query);
                  }
                },
              ),
            ),
            showPredictions ? buildPredictionList(predictions) : Container(),
          ],
        ),
      ),
    );
  }

  Widget buildPredictionList(Map<String, String> predictions) {
    var tiles = <Widget>[];

    predictions.forEach((key, value) {
      tiles.add(GestureDetector(
        onTap: () {
          showPredictions = false;
          _searchController.text = key;
          if (mounted) setState(() {});
        },
        child: ListTile(
          title: Text(' ' + key),
        ),
      ));
    });

    if (tiles.length > 3) {
      tiles = tiles.sublist(0, 3);
    }

    return Flex(
      direction: Axis.vertical,
      children: tiles,
    );
  }
}
