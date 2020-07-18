import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/bloc/main_home/main_home_bloc.dart';
import 'package:tourists/models/location_list_item/location_list_item.dart';
import 'package:tourists/ui/user/location_details/location_details.dart';
import 'package:tourists/ui/widgets/carousel/carousel.dart';
import 'package:tourists/ui/widgets/carousel_card/carousel_card.dart';
import 'package:tourists/ui/widgets/location_list_item/location_list_item.dart';

@provide
class MainHomeSubScreen extends StatefulWidget {

  final MainHomeBloc _homeBloc;
  final LocationDetailsScreen _detailsScreen;

  @override
  State<StatefulWidget> createState() => _MainHomeSubScreenState();
  MainHomeSubScreen(this._homeBloc, this._detailsScreen);
}

class _MainHomeSubScreenState extends State<MainHomeSubScreen> {
  @override
  Widget build(BuildContext context) {

    widget._homeBloc.requestLocationList();

    return StreamBuilder(
      stream: widget._homeBloc.locationListStream,
      builder: (BuildContext context, AsyncSnapshot<List<LocationListItem>> locationList) {
        if (locationList == null || locationList.data == null) {
          return Center(child: Text(
            'Loading'
          ),);
        }

        List<Widget> locationCards = [];
        List<CarouselCard> carouselCards = [];

        locationList.data.forEach((location) {
          locationCards.add(GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => widget._detailsScreen,
                    settings: RouteSettings(
                      // Replace this with location Id
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
