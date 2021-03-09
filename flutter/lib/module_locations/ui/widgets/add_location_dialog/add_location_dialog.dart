import 'package:flutter/material.dart';
import 'package:tourists/module_search/bloc/search_bloc/search_bloc.dart';

class AddLocationDialog extends StatefulWidget {
  final SearchBloc predictionProvider;

  AddLocationDialog(this.predictionProvider);

  @override
  State<StatefulWidget> createState() => _AddLocationDialogState();
}

class _AddLocationDialogState extends State<AddLocationDialog> {
  String currentLocation;
  bool showPredictions = true;
  Map<String, String> predictions = {};

  final _searchController = TextEditingController();

  @override
  void initState() {
    widget.predictionProvider.predictionStream.listen((event) {
      predictions = event;
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Flex(
        direction: Axis.vertical,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _searchController,
              onChanged: (query) {
                if (query.isNotEmpty) {
                  showPredictions = true;
                  widget.predictionProvider.getPredictions(query);
                }
              },
            ),
          ),
          showPredictions ? buildPredictionList(predictions) : Container(),
          // TODO: Show result
        ],
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
