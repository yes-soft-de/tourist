import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:inject/inject.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/module_comment/ui/widget/comment_list/comment_list.dart';
import 'package:tourists/module_comment/ui/widget/new_comment/new_comment_widget.dart';
import 'package:tourists/module_forms/forms_routes.dart';
import 'package:tourists/module_guide/model/guide_list_item/guide_list_item.dart';
import 'package:tourists/module_guide/nav_arguments/request_guide/request_guide_navigation.dart';
import 'package:tourists/module_guide/ui/widget/guide_list_item/guide_list_item.dart';
import 'package:tourists/module_locations/bloc/location_details/location_details_bloc.dart';
import 'package:tourists/module_locations/model/location_details/location_details.dart';
import 'package:tourists/module_shared/ui/widgets/carousel/carousel.dart';
import 'package:tourists/module_shared/ui/widgets/request_guide_button/request_guide_button.dart';
import 'package:tourists/utils/auth_guard/auth_gard.dart';

@provide
class LocationDetailsScreen extends StatefulWidget {
  final LocationDetailsBloc _locationBloc;
  final AuthGuard _authGuard;

  LocationDetailsScreen(this._locationBloc, this._authGuard);

  @override
  State<StatefulWidget> createState() => _LocationDetailsScreenState();
}

class _LocationDetailsScreenState extends State<LocationDetailsScreen> {
  int currentStatus = LocationDetailsBloc.STATUS_CODE_INIT;

  LocationDetailsModel _locationDetails;
  List<GuideListItemModel> _guidesList;
  bool commentListCollapsed = false;
  bool guidesListExpanded = false;
  bool canSendComments = true;
  ScrollController pageScrollController = ScrollController();
  double scrollPosition = 0;
  String locationId;

  int currentRate;

  @override
  Widget build(BuildContext context) {
    // Get the Location Id
    locationId = ModalRoute.of(context).settings.arguments;

    if (canSendComments == null) {
      widget._authGuard.isLoggedIn().then((value) {
        canSendComments = value;
        if (this.mounted) setState(() {});
      });
    }

    widget._locationBloc.locationDetailsStream.listen((event) {
      currentStatus = event[LocationDetailsBloc.KEY_STATUS];
      if (currentStatus == LocationDetailsBloc.STATUS_CODE_LOAD_SUCCESS) {
        if (this.mounted) {
          setState(() {
            _locationDetails = event[LocationDetailsBloc.KEY_LOCATION_INFO];
            _guidesList = event[LocationDetailsBloc.KEY_GUIDES];
          });
        }
      }
    });

    // Loading Screen
    if (currentStatus == LocationDetailsBloc.STATUS_CODE_INIT) {
      widget._locationBloc.getLocation(locationId);
      return Scaffold(
        body: Center(
          child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
              Container(
                height: 16,
              ),
              Text(S.of(context).loading)
            ],
          ),
        ),
      );
    }

    // Error Screen
    if (currentStatus == LocationDetailsBloc.STATUS_CODE_LOAD_ERROR) {
      return Scaffold(
        body: Center(
          child: Text(S.of(context).error_fetching_data),
        ),
      );
    }

    // Details Screen
    if (currentStatus == LocationDetailsBloc.STATUS_CODE_LOAD_SUCCESS) {
      return getLocationScreen();
    }

    return Scaffold(
      body: Center(
        child: Text('Undefined State'),
      ),
    );
  }

  double lastLocation = 0.0;

  Scaffold getLocationScreen() {
    List<Widget> carouselList = [];

    if (_locationDetails.paths != null) {
      _locationDetails.paths.forEach((path) {
        carouselList.add(Image.network(
          path.path,
          fit: BoxFit.fitWidth,
        ));
      });
    }

    List<Widget> pageLayout = [
      AppBar(
        title: Text(
          _locationDetails.name,
          style: TextStyle(
              color: Colors.black45, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        backgroundColor: Colors.white,
      ),
      CarouselWidget(carouselList),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(_locationDetails.description),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          S.of(context).guides,
          style: TextStyle(
              fontSize: 24, color: Colors.black45, fontWeight: FontWeight.bold),
        ),
      )
    ];

    pageLayout.addAll(getGuidesList());

    pageLayout.add(NewCommentWidget(
      active: canSendComments,
      onCommentAdded: (String msg) {
        createComment(msg);
      },
    ));

    pageLayout.add(CommentListWidget(_locationDetails.comments));

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: NotificationListener(
              onNotification: (t) {
                if (t is ScrollEndNotification) {
                  print(lastLocation > t.metrics.pixels ? 'up' : 'down');
                  scrollPosition = lastLocation > t.metrics.pixels ? 1 : -1;
                  lastLocation = t.metrics.pixels;
                  setState(() {});
                }
                return true;
              },
              child: ListView(
                controller: pageScrollController,
                children: pageLayout,
              ),
            ),
          ),
          scrollPosition > 0 || lastLocation == 0
              ? Positioned(
                  bottom: 16,
                  left: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        FormsRoutes.requestGuideForm,
                        arguments: RequestGuideNavigationArguments(
                            cityId: this.locationId),
                      );
                    },
                    child: RequestGuideButton(
                      cityId: this._locationDetails.id.toString(),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  List<Widget> getGuidesList() {
    List<Widget> guidesList = [];

    List<GuideListItemModel> visibleGuides;

    // No Expansion Needed
    if (_guidesList.isNotEmpty) guidesListExpanded = true;

    if (_guidesList.length > 3) {
      visibleGuides =
          guidesListExpanded ? _guidesList : _guidesList.sublist(0, 3);
    } else {
      visibleGuides = _guidesList;
    }

    // Construct the List into CSV text
    visibleGuides.forEach((guide) {
      String citiesInText = '';
      guide.city.forEach((cityName) {
        citiesInText = citiesInText + ' ' + cityName;
      });

      // Construct the List into CSV text
      String languagesInText = '';
      guide.language.forEach((language) {
        languagesInText = languagesInText + language + ' ';
      });

      guidesList.add(GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            FormsRoutes.requestGuideForm,
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
                child: Text(S.of(context).show_more),
              ),
            ),
          )
        ],
      ));
    }

    return guidesList;
  }

  void createComment(String newComment) {
    widget._locationBloc
        .postComment(newComment, locationId)
        .then((createSuccess) {
      widget._locationBloc.getLocation(locationId);
    });
  }

  Widget getEvaluationBar() {
    List<Widget> stars = [];

    if (currentRate == null) {
      for (int i = 0; i < 5; i++) {
        stars.add(GestureDetector(
          onTap: () {
            widget._locationBloc.createRate(i, locationId);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.star_border),
          ),
        ));
      }
    } else {
      for (int i = 0; i <= currentRate; i++) {
        stars.add(Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.star),
        ));
      }
    }

    return Flex(
      direction: Axis.horizontal,
      children: stars,
    );
  }
}
