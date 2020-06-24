import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/user/ui/widgets/event_list_item_widget/event_list_item_widget.dart';

// Event and Festivals List has the same layout, we can use the top button as a filter

@provide
class TouristEventListSubScreen extends StatefulWidget {
  // TODO State Indicators, Move to Bloc
  final int KEY_EVENT = 0;
  final int KEY_FESTIVEL = 1;

  @override
  State<StatefulWidget> createState() => _TouristEventListSubScreenState();
}

class _TouristEventListSubScreenState extends State<TouristEventListSubScreen> {
  int activeList = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> pageLayout = [];

    // Title
    pageLayout.add(Text('سياح'));

    // Filter
    pageLayout.add(Flex(
      direction: Axis.horizontal,
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Text(
            S.of(context).events,
            style: TextStyle(
                color: activeList == widget.KEY_EVENT
                    ? Colors.greenAccent
                    : Colors.black),
          ),
        ),
        Flexible(
          flex: 1,
          child: Text(
            S.of(context).festivals,
            style: TextStyle(
                color: activeList == widget.KEY_FESTIVEL
                    ? Colors.greenAccent
                    : Colors.black),
          ),
        ),
      ],
    ));

    // TODO: Add Filters
    List<EventListItemWidget> eventsList = [];


    // TODO: Remove this Mock once design approved
    String activeListString =
        activeList == widget.KEY_FESTIVEL ? S.of(context).festivals : S.of(context).events;

    for (int i = 0; i < 10; i++) {
      eventsList.add(EventListItemWidget(
        image: 'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
        location: 'Damascus',
        status: 'Soon',
        commentNumber: 35,
        time: 'Starts at 21 Jun',
        name: 'Damascus ' + activeListString,
      ));
    }

    return ListView(
      children: pageLayout,
    );
  }
}
