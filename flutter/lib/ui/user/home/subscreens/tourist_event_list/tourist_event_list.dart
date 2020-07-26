import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/bloc/event_list/event_list_bloc.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/models/event/event_model.dart';
import 'package:tourists/ui/widgets/event_list_item_widget/event_list_item_widget.dart';

// Event and Festivals List has the same layout, we can use the top button as a filter

@provide
class TouristEventListSubScreen extends StatefulWidget {
  final EventListBloc _bloc;
  static const String KEY_FESTIVAL = 'festival';
  static const String KEY_EVENT = 'event';

  const TouristEventListSubScreen(this._bloc);

  @override
  State<StatefulWidget> createState() => _TouristEventListSubScreenState();
}

class _TouristEventListSubScreenState extends State<TouristEventListSubScreen> {
  int currentStatus = EventListBloc.STATUS_CODE_INIT;
  String activeList = TouristEventListSubScreen.KEY_FESTIVAL;

  List<EventModel> eventList;

  @override
  Widget build(BuildContext context) {
    widget._bloc.eventStream.listen((event) {
      currentStatus = event.first;
      if (currentStatus == EventListBloc.STATUS_CODE_LOAD_SUCCESS) {
        eventList = event.last;
      }
      setState(() {});
    });

    if (currentStatus == EventListBloc.STATUS_CODE_INIT) {
      widget._bloc.getAllEvents();
      return Center(child: Text("Loading"));
    }

    if (currentStatus == EventListBloc.STATUS_CODE_LOAD_ERROR) {
      return Center(child: Text("Error fetching Data"));
    }

    if (currentStatus == EventListBloc.STATUS_CODE_LOAD_SUCCESS) {
      return buildUI();
    }

    return Center(child: Text("Undefined Status"));
  }

  buildUI() {
    List<Widget> pageLayout = [];

    // Title
    pageLayout.add(AppBar(
      backgroundColor: Colors.white,
      title: Text("سياح"),
    ));

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
          child: GestureDetector(
            onTap: () {
              activeList = TouristEventListSubScreen.KEY_EVENT;
              setState(() {});
            },
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
        ),
        Container(
          height: 30,
          width: 2,
          color: Colors.black45,
        ),
        Flexible(
          flex: 1,
          child: GestureDetector(
            onTap: () {
              activeList = TouristEventListSubScreen.KEY_FESTIVAL;
              setState(() {});
            },
            child: Container(
              width: double.infinity,
              height: 48,
              alignment: Alignment.center,
              child: Text(
                S.of(context).festivals,
                style: TextStyle(
                    color: activeList == TouristEventListSubScreen.KEY_FESTIVAL
                        ? Colors.greenAccent
                        : Colors.black,
                    fontWeight: FontWeight.bold),
              ),
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

    List<EventModel> eventsList = getActiveList();

    if (eventsList.length > 0) {
      getActiveList().forEach((event) {
        pageLayout.add(EventListItemWidget(
          image:
              'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
          location: event.location,
          status: event.status,
          commentNumber: 0,
          time: getDate(event.date.timestamp).toString(),
          name: event.name,
        ));
      });
    } else {
      pageLayout.add(Center(
        child: Text("No Events for now!"),
      ));
    }

    return ListView(
      children: pageLayout,
    );
  }

  List<EventModel> getActiveList() {
    List<EventModel> events = [];
    eventList.forEach((element) {
      if (element.type == activeList) events.add(element);
    });
    return events;
  }

  getDate(int timeStamp) {
    return new DateTime.fromMicrosecondsSinceEpoch(timeStamp);
  }
}
