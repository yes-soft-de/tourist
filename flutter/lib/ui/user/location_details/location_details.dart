import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inject/inject.dart';
import 'package:tourists/bloc/location_details/location_details_bloc.dart';
import 'package:tourists/components/user/user_routes.dart';
import 'package:tourists/models/guide_list_item/guide_list_item.dart';
import 'package:tourists/models/location_details/location_details.dart';
import 'package:tourists/nav_arguments/request_guide/request_guide_navigation.dart';
import 'package:tourists/ui/widgets/carousel/carousel.dart';
import 'package:tourists/ui/widgets/guide_list_item/guide_list_item.dart';

@provide
class LocationDetailsScreen extends StatefulWidget {
  final LocationDetailsBloc _locationBloc;

  LocationDetailsScreen(this._locationBloc);

  @override
  State<StatefulWidget> createState() => _LocationDetailsScreenState();
}

class _LocationDetailsScreenState extends State<LocationDetailsScreen> {
  int currentStatus = LocationDetailsBloc.STATUS_CODE_INIT;

  LocationDetailsModel _locationDetails;
  List<GuideListItemModel> _guidesList;
  bool commentListCollapsed = false;
  bool guidesListExpanded = false;

  @override
  Widget build(BuildContext context) {
    // Get the Location Id
    final String locationId = ModalRoute.of(context).settings.arguments;

    widget._locationBloc.locationDetailsStream.listen((event) {
      currentStatus = event[LocationDetailsBloc.KEY_STATUS];
      if (currentStatus == LocationDetailsBloc.STATUS_CODE_LOAD_SUCCESS) {
        _locationDetails = event[LocationDetailsBloc.KEY_LOCATION_INFO];
        _guidesList = event[LocationDetailsBloc.KEY_GUIDES];
        setState(() {});
      }
    });

    // Loading Screen
    if (currentStatus == LocationDetailsBloc.STATUS_CODE_INIT) {
      widget._locationBloc.getLocation(locationId);
      return Scaffold(
        body: Center(
          child: Text('Loading'),
        ),
      );
    }

    // Error Screen
    if (currentStatus == LocationDetailsBloc.STATUS_CODE_LOAD_ERROR) {
      return Scaffold(
        body: Center(
          child: Text('Error Loading Info!'),
        ),
      );
    }

    // Details Screen
    if (currentStatus == LocationDetailsBloc.STATUS_CODE_LOAD_SUCCESS) {
      return getLocationScreen();
    }

    return Scaffold(
      body: Center(
        child: Text("Undefined State"),
      ),
    );
  }

  Scaffold getLocationScreen() {
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

    pageLayout.addAll(getCommentList());

    return Scaffold(
      body: ListView(
        children: pageLayout,
      ),
    );
  }

  List<Widget> getGuidesList() {
    List<Widget> guidesList = [];

    List<GuideListItemModel> visibleGuides = guidesListExpanded ? _guidesList : _guidesList.sublist(0, 3);

    // Construct the List into CSV text
    visibleGuides.forEach((guide) {
      String citiesInText = "";
      guide.city.forEach((cityName) {
        citiesInText = citiesInText + " " + cityName;
      });

      // Construct the List into CSV text
      String languagesInText = "";
      guide.language.forEach((language) {
        citiesInText = citiesInText + language + " ";
      });

      guidesList.add(GestureDetector(
        onTap: () {
          Navigator.pushReplacementNamed(
            context,
            UserRoutes.requestGuide,
            arguments: RequestGuideNavigationArguments(
                guideId: guide.user, cityId: _locationDetails.id.toString()),
          );
        },
        child: GuideListItemWidget(
          guideCity: citiesInText,
          guideName: guide.name,
          guideLanguage: languagesInText,
          availability: guide.status,
          rate: 3,
          guideImage: guide.image,
        ),
      ));
    });

    if (guidesListExpanded == false) {
      guidesList.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              guidesListExpanded = true;
              setState(() {});
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.all(Radius.circular(90))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("SHOW MORE"),
              ),
            ),
          )
        ],
      ));
    }

    return guidesList;
  }

  List<Widget> getCommentList() {
    List<Widget> commentsList = [];

    return commentsList;
  }
}
