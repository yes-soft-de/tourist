import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inject/inject.dart';
import 'package:tourists/bloc/location_details/location_details_bloc.dart';
import 'package:tourists/components/user/user_routes.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/models/guide_list_item/guide_list_item.dart';
import 'package:tourists/models/location_details/location_details.dart';
import 'package:tourists/models/location_list_item/location_list_item.dart';
import 'package:tourists/nav_arguments/request_guide/request_guide_navigation.dart';
import 'package:tourists/responses/comment/comment_response.dart';
import 'package:tourists/ui/widgets/carousel/carousel.dart';
import 'package:tourists/ui/widgets/comment_item/comment_item.dart';
import 'package:tourists/ui/widgets/guide_list_item/guide_list_item.dart';
import 'package:tourists/ui/widgets/request_guide_button/request_guide_button.dart';

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
  bool canSendComments = true;
  ScrollController pageScrollController = ScrollController();
  double scrollPosition = 0;
  String locationId;

  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Get the Location Id
    locationId = ModalRoute.of(context).settings.arguments;

    widget._locationBloc.locationDetailsStream.listen((event) {
      canSendComments = true;
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
          child: Text(S.of(context).loading),
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
      Fluttertoast.showToast(msg: S.of(context).error_no_images);
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

    Flex createCommentRow = Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: commentController,
              decoration: InputDecoration(hintText: 'Comment Here'),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: GestureDetector(
            onTap: () {
              createComment();
            },
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              ),
              decoration: BoxDecoration(
                  color: canSendComments ? Colors.greenAccent : Colors.grey),
            ),
          ),
        )
      ],
    );
    pageLayout.add(createCommentRow);

    pageLayout.add(getCommentList());

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
                  scrollPosition =
                      pageScrollController.position.pixels - scrollPosition;
                  scrollPosition = scrollPosition > 0 ? 1 : -1;
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
          scrollPosition < 0
              ? Positioned(
                  bottom: 16,
                  left: 0,
                  right: 0,
                  child: RequestGuideButton(
                    cityId: this._locationDetails.id.toString(),
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
    if (_guidesList.length > 0) guidesListExpanded = true;

    visibleGuides =
        guidesListExpanded ? _guidesList : _guidesList.sublist(0, 3);

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
                child: Text(S.of(context).show_more),
              ),
            ),
          )
        ],
      ));
    }

    return guidesList;
  }

  Widget getCommentList() {
    if (_locationDetails.comments == null) return null;

    List<Widget> comments = [];
    List<CommentModel> allComments = _locationDetails.comments;

    if (_locationDetails.comments.length > 2 && commentListCollapsed) {
      allComments = allComments.sublist(0, 2);
    }

    allComments.forEach((element) {
      comments.add(CommentItemWidget(
        comment: element.comment,
        userName: element.userName,
        commentDate: getTimeFromTimeStamp(element.date.timestamp),
      ));
    });

    return Flex(
      direction: Axis.vertical,
      children: comments,
    );
  }

  void createComment() {
    if (!canSendComments) {
      return;
    }
    canSendComments = false;
    setState(() {});
    if (commentController.text == null) return;
    if (commentController.text.length > 0) {
      widget._locationBloc
          .postComment(commentController.text, locationId)
          .then((createSuccess) {
        widget._locationBloc.getLocation(locationId);
      });
    }
  }

  DateTime getTimeFromTimeStamp(int timeStamp) {
    return new DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
  }
}
