import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tourists/ui/widgets/carousel/carousel.dart';

class LocationDetailsScreen extends StatefulWidget {

  String _locationId;

  LocationDetailsScreen() {
  }

  @override
  State<StatefulWidget> createState() => _LocationDetailsScreenState();
}

class _LocationDetailsScreenState extends State<LocationDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    // Get the Location Id
    final String locationId = ModalRoute.of(context).settings.arguments;


    return Scaffold(
      body: Column(
        children: <Widget>[
          CarouselWidget([
            Image.network('Some Image'),
            Image.network('Some Image'),
            Image.network('Some Image'),
            Image.network('Some Image'),
          ]),
          Text('Description'),
          Row(
            children: <Widget>[
              Container(
                child: Text('Evaluate'),
              ),
              // TODO Add Stars Bar
            ],
          ),
          Text('Guides who operates here'),
          ListView(
            children: getGuidesList(),
          )
        ],
      ),
    );
  }

  List<Widget> getGuidesList() {
    List<Widget> guidesList = [];

    // TODO: Create Guides List
    guidesList.add(createGuideCard(null, null, null, null));
    guidesList.add(createGuideCard(null, null, null, null));
    guidesList.add(createGuideCard(null, null, null, null));
    guidesList.add(createGuideCard(null, null, null, null));

    return guidesList;
  }

  Widget createGuideCard(
      String image, String guideName, String languages, int stars) {
    return Flex(
      direction: Axis.horizontal,
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(90))),
              child: Image.network(
                image,
                fit: BoxFit.contain,
              )),
        ),
        Flexible(
          flex: 3,
          child: Column(
            children: <Widget>[
              Text(
                guideName,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(languages),
              // TODO Add Star Line
            ],
          ),
        ),
        Flexible(
          flex: 1,
          child: GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(90))),
              color: Colors.greenAccent,
              child: Text(
                '+',
                style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        )
      ],
    );
  }
}
