import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/module_locations/location_routes.dart';
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
      appBar: AppBar(
        title: TextFormField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: S.of(context).search,
            labelText: S.of(context).search,
          ),
          onChanged: (query) {
            if (query.isNotEmpty) {
              showPredictions = true;
              widget.bloc.getPredictions(query);
            }
          },
        ),
      ),
      body: Column(
        children: [
          buildPredictionList(predictions),
        ],
      ),
    );
  }

  Widget buildPredictionList(Map<String, String> predictions) {
    var tiles = <Widget>[];

    predictions.forEach((key, value) {
      tiles.add(Card(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(LocationRoutes.locationDetails, arguments: value);
            if (mounted) setState(() {});
          },
          child: ListTile(
            title: Text(' ' + key),
            trailing: Icon(Icons.navigate_next),
          ),
        ),
      ));
    });

    return Flex(
      direction: Axis.vertical,
      children: tiles,
    );
  }
}
