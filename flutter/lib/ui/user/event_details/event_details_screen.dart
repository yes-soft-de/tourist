import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/bloc/event_details/event_details.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/models/event/event_model.dart';
import 'package:tourists/ui/widgets/carousel/carousel.dart';
import 'package:tourists/ui/widgets/request_guide_button/request_guide_button.dart';

@provide
class EventDetailsScreen extends StatefulWidget {
  final EventDetailsBloc _bloc;

  EventDetailsScreen(this._bloc);

  @override
  State<StatefulWidget> createState() => EventDetailsScreenState();
}

class EventDetailsScreenState extends State<EventDetailsScreen> {
  int currentState = EventDetailsBloc.STATUS_CODE_INIT;
  int eventId;
  EventModel eventDetails;
  String locationId;

  @override
  Widget build(BuildContext context) {
    eventId = ModalRoute.of(context).settings.arguments;
    widget._bloc.eventStream.listen((event) {
      currentState = event[EventDetailsBloc.KEY_STATUS];
      if (currentState == EventDetailsBloc.STATUS_CODE_LOAD_SUCCESS) {
        eventDetails = event[EventDetailsBloc.KEY_EVENT];
        if (event[EventDetailsBloc.KEY_LOCATION] != null)
          locationId = event[EventDetailsBloc.KEY_LOCATION].id;
      }
      setState(() {});
    });

    if (currentState == EventDetailsBloc.STATUS_CODE_INIT) {
      widget._bloc.getEventDetails(eventId.toString());
      return Scaffold(
        body: Center(
          child: Text(S.of(context).name),
        ),
      );
    }

    if (currentState == EventDetailsBloc.STATUS_CODE_LOAD_ERROR) {
      return Scaffold(
        body: Center(
          child: Text(S.of(context).error_fetching_data),
        ),
      );
    }

    if (currentState == EventDetailsBloc.STATUS_CODE_LOAD_SUCCESS) {
      return getScaffoldUI();
    }

    return Scaffold(
      body: Center(
        child: Text("Unknown State: " + currentState.toString()),
      ),
    );
  }

  Scaffold getScaffoldUI() {
    List<Widget> pageUI = [];
    List<Widget> carouselCards = [];

    List<String> eventImages = [];
    if (eventDetails.images == null) {
      eventImages = [
        "https://cdn.pixabay.com/photo/2017/07/21/23/57/concert-2527495__340.jpg"
      ];
    } else if (eventDetails.images.length == 0) {
      eventImages = [
        "https://cdn.pixabay.com/photo/2017/07/21/23/57/concert-2527495__340.jpg"
      ];
    } else {
      eventImages = eventDetails.images;
    }

    eventImages.forEach((element) {
      carouselCards.add(Image.network(element));
    });
    CarouselWidget carouselWidget = CarouselWidget(carouselCards);
    pageUI.add(carouselWidget);

    Flex eventInfo = Flex(
      direction: Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(
          flex: 2,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Container(
              color: Colors.greenAccent,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  getTimeFromTimeStamp(eventDetails.date.timestamp)
                      .toIso8601String()
                      .substring(11, 16),
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          ),
        ),
        Flexible(
          flex: 3,
          child: Flex(
            direction: Axis.vertical,
            children: <Widget>[
              Text(eventDetails.description),
            ],
          ),
        )
      ],
    );
    pageUI.add(eventInfo);

    pageUI.add(Container(
      height: 16,
    ));

    pageUI.add(Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(getTimeFromTimeStamp(eventDetails.date.timestamp).toString())
      ],
    ));

    pageUI.add(Container(
      height: 16,
    ));

    pageUI.add(Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.location_on),
        Text(
          eventDetails.location != null ? eventDetails.location : 'Soon',
          style: TextStyle(fontSize: 24),
        )
      ],
    ));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(eventDetails.name),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 56,
            child: ListView(
              children: pageUI,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: this.locationId != null ? RequestGuideButton(
              cityId: this.locationId != null ? this.locationId.toString() : '1',
            ): Container(),
          )
        ],
      ),
    );
  }

  DateTime getTimeFromTimeStamp(int timestamp) {
    print(timestamp);
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    print(date.toString());
    return date;
  }
}
