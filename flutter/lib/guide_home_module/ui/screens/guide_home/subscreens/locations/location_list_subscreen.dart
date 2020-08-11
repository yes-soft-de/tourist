import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/bloc/guide_location_list/guide_location_list_bloc.dart';
import 'package:tourists/models/location_list_item/location_list_item.dart';
import 'package:tourists/ui/user/location_details/location_details.dart';
import 'package:tourists/ui/widgets/carousel/carousel.dart';
import 'package:tourists/ui/widgets/carousel_card/carousel_card.dart';
import 'package:tourists/ui/widgets/location_list_item/location_list_item.dart';

@provide
class LocationListSubScreen extends StatefulWidget {
  final GuideLocationListBloc _guideLocationListBloc;
  final LocationDetailsScreen _detailsScreen;

  LocationListSubScreen(this._guideLocationListBloc, this._detailsScreen);

  @override
  State<StatefulWidget> createState() => _LocationListSubScreenState();
}

class _LocationListSubScreenState extends State<LocationListSubScreen> {
  @override
  Widget build(BuildContext context) {
    widget._guideLocationListBloc.requestLocationList();

    return StreamBuilder(
      stream: widget._guideLocationListBloc.locationListStream,
      builder: (BuildContext context,
          AsyncSnapshot<List<LocationListItem>> locationList) {
        if (locationList == null || locationList.data == null) {
          return Center(
            child: Text('Loading'),
          );
        }

        log(locationList.data.length.toString() + ' To the UI');

        List<Widget> locationCards = [];
        List<CarouselCard> carouselCards = [];

        locationList.data.forEach((location) {
          locationCards.add(GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                  MaterialPageRoute(
                    builder: (context) => widget._detailsScreen,
                    settings: RouteSettings(
                      arguments: location.id.toString(),
                    ),
                  ));
            },
            child: Padding(
              padding: EdgeInsets.all(8),
              child: LocationListItemWidget(
                imageLink: location.path[0].path,
                title: location.name,
                description: location.description,
                rate: 2,
                commentsNumber: 2,
              ),
            ),
          ));
          carouselCards.add(CarouselCard(
            title: location.name,
            description: location.description,
            image: location.path[0].path,
            commentsNumber: 2,
            stars: 2,
          ));
        });

        List<Widget> pageLayout = [];

        // Add Carousel
        pageLayout.add(CarouselWidget(carouselCards));

        // Add location Cards
        pageLayout.addAll(locationCards);

        return ListView(
          children: pageLayout,
        );
      },
    );
  }
}
