import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inject/inject.dart';
import 'package:tourists/user/bloc/location_details/location_details_bloc.dart';
import 'package:tourists/user/models/guide_list_item/guide_list_item.dart';
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
  LocationDetailsModel _locationDetails;
  List<GuideListItemModel> _guidesList;

  bool loadingError;

  @override
  Widget build(BuildContext context) {
    // Get the Location Id
    final String locationId = ModalRoute.of(context).settings.arguments;

    widget._locationBloc.locationDetailsStream.listen((locationWithGuides) {
      log('Got Data! -----------------------------------------------');
      if (locationWithGuides != null) {
        _locationDetails = locationWithGuides.locationDetails;
        _guidesList = locationWithGuides.guides;
        loadingError = false;
        setState(() {});
      }
      loadingError = true;
    });

    if (loadingError == null) {
      widget._locationBloc.getLocation(locationId);
      return Scaffold(
        body: Center(
          child: Text('Loading'),
        ),
      );
    }

    if (loadingError == true) {
      if (loadingError == null) {
        return Scaffold(
          body: Center(
            child: Text('Error Loading Info!'),
          ),
        );
      }
    }

    List<Widget> carouselList = [];

    if (_locationDetails.paths != null) {
      _locationDetails.paths.forEach((path) {
        carouselList.add(Image.network(
          path.path,
          fit: BoxFit.fitWidth,
        ));
      });
    } else {
      Fluttertoast.showToast(msg: 'No Images?!!');
    }

    List<Widget> pageLayout = [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          _locationDetails.name,
          style: TextStyle(
              color: Colors.black45, fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      CarouselWidget(carouselList),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(_locationDetails.description),
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
              fontSize: 24, color: Colors.black45, fontWeight: FontWeight.bold),
        ),
      )
    ];

    pageLayout.addAll(getGuidesList());

    return Scaffold(
      body: ListView(
        children: pageLayout,
      ),
    );
  }

  List<GuideListItemWidget> getGuidesList() {
    List<GuideListItemWidget> guidesList = [];

    // Construct the List into CSV text
    _guidesList.forEach((guide) {
      String citiesInText = "";
      guide.city.forEach((cityName) {
        citiesInText = citiesInText + " " + cityName;
      });

      // Construct the List into CSV text
      String languagesInText = "";
      guide.language.forEach((language) {
        citiesInText = citiesInText + language + " ";
      });

      guidesList.add(GuideListItemWidget(
        guideCity: citiesInText,
        guideName: guide.name,
        guideLanguage: languagesInText,
        availability: guide.status,
        rate: 3,
        guideImage: guide.image,
      ));
    });

    return guidesList;
  }
}
