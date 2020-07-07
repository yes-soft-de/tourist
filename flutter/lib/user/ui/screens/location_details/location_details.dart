import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/user/bloc/location_details/location_details_bloc.dart';
import 'package:tourists/user/models/location_details/location_details.dart';
import 'package:tourists/user/ui/widgets/carousel/carousel.dart';
import 'package:tourists/user/ui/widgets/guide_list_item/guide_list_item.dart';

@provide
class LocationDetailsScreen extends StatefulWidget {
  final LocationDetailsBloc _locationBloc;

  LocationDetailsScreen(this._locationBloc);

  @override
  State<StatefulWidget> createState() => _LocationDetailsScreenState();
}

class _LocationDetailsScreenState extends State<LocationDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    // Get the Location Id
    final String locationId = ModalRoute.of(context).settings.arguments;

    widget._locationBloc.getLocation(locationId);

    return StreamBuilder(
      stream: widget._locationBloc.locationDetailsStream,
      builder:
          (BuildContext context, AsyncSnapshot<LocationDetailsModel> snapshot) {
        if (snapshot.data == null) {
          return Scaffold(
            body: Center(
              child: Text('Loading for ' + locationId),
            ),
          );
        }

        List<Widget> carouselList = [];

        snapshot.data.paths.forEach((path) {
          carouselList.add(Image.network(path.path, fit: BoxFit.fitWidth,));
        });

        List<Widget> pageLayout = [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              snapshot.data.name,
              style: TextStyle(
                  color: Colors.black45,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
          ),
          CarouselWidget(carouselList),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(snapshot.data.description),
          ),
          Flex(
            direction: Axis.horizontal,
            children: <Widget>[
//              Container(
//                child: Text('Evaluate'),
//              ),
              // TODO Add Stars Bar
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Guides',
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.black45,
                  fontWeight: FontWeight.bold),
            ),
          )
        ];

        pageLayout.addAll(getGuidesList());

        return Scaffold(
          body: ListView(
            children: pageLayout,
          ),
        );
      },
    );

    // TODO Get Location Details From Network
  }

  List<GuideListItemWidget> getGuidesList() {
    List<GuideListItemWidget> guidesList = [];

    // TODO: Create Guides List
    for (int i = 0; i < 6; i++) {
      guidesList.add(GuideListItemWidget(
        guideCity: 'Damascus',
        guideName: 'Mohammad',
        guideLanguage: 'العربية - English',
        availability: i % 3 == 0,
        rate: 3,
        guideImage:
            'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
      ));
    }

    return guidesList;
  }
}
