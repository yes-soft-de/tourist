import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/ui/widgets/event_list_item_widget/event_list_item_widget.dart';

// Event and Festivals List has the same layout, we can use the top button as a filter

@provide
class TouristEventListSubScreen extends StatefulWidget {
  // TODO State Indicators, Move to Bloc
  static const int KEY_EVENT = 0;
  static const int KEY_FESTIVEL = 1;

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

    pageLayout.add(Container(
      width: double.infinity,
      height: 2,
      color: Colors.black45,
    ));

    // Filter
    pageLayout.add(Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Container(
            width: double.infinity,
            alignment: Alignment.center,
            height: 48,
            child: Text(
              S.of(context).events,
              style: TextStyle(
                  color: activeList == TouristEventListSubScreen.KEY_EVENT
                      ? Colors.greenAccent
                      : Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Container(
          height: 30,
          width: 2,
          color: Colors.black45,
        ),
        Flexible(
          flex: 1,
          child: Container(
            width: double.infinity,
            height: 48,
            alignment: Alignment.center,
            child: Text(
              S.of(context).festivals,
              style: TextStyle(
                  color: activeList == TouristEventListSubScreen.KEY_FESTIVEL
                      ? Colors.greenAccent
                      : Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    ));

    pageLayout.add(Container(
      width: double.infinity,
      height: 2,
      color: Colors.black45,
    ));

    // TODO: Remove this Mock once design approved
    String activeListString = activeList == TouristEventListSubScreen.KEY_FESTIVEL
        ? S.of(context).festivals
        : S.of(context).events;

    for (int i = 0; i < 10; i++) {
      pageLayout.add(EventListItemWidget(
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
