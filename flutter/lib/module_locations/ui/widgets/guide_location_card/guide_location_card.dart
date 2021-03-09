import 'package:flutter/material.dart';
import 'package:tourists/module_locations/model/location_list_item/location_list_item.dart';

class GuideLocationCard extends StatelessWidget {
  final LocationListItem location;
  final bool selected;

  GuideLocationCard(this.location, this.selected);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      child: Card(
        color: selected ? Theme.of(context).primaryColor : Colors.white,
        child: Column(
          children: [
            Expanded(child: Image.network(location.path[0].path, fit: BoxFit.cover,)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(location.name),
            ),
          ],
        ),
      ),
    );
  }
}
