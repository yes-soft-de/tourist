import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/module_locations/bloc/location_details/location_details_bloc.dart';
import 'package:tourists/module_locations/ui/states/location_details_state/location_details_state.dart';
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
  LocationDetailsState _currentState;

  @override
  void initState() {
    super.initState();
    widget._locationBloc.stateStream.stream.listen((event) {
      _currentState = event;
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_currentState == null) {
      var locationId = ModalRoute.of(context).settings.arguments;
      widget._locationBloc.getLocation(locationId);
    }
    return Scaffold(body: _currentState?.getUI(context));
  }

// LocationDetailsModel _locationDetails;
// List<GuideListItemModel> _guidesList;
// bool commentListCollapsed = false;
// bool guidesListExpanded = false;
// bool canSendComments = true;
// ScrollController pageScrollController = ScrollController();
// double scrollPosition = 0;
// String locationId;
// int currentRate;

// @override
// Widget build(BuildContext context) {
//   // Get the Location Id
//   locationId = ModalRoute.of(context).settings.arguments;
//
//   if (canSendComments == null) {
//     widget._authGuard.isLoggedIn().then((value) {
//       canSendComments = value;
//       if (this.mounted) setState(() {});
//     });
//   }
//
//   widget._locationBloc.locationDetailsStream.listen((event) {
//     currentStatus = event[LocationDetailsBloc.KEY_STATUS];
//     if (currentStatus == LocationDetailsBloc.STATUS_CODE_LOAD_SUCCESS) {
//       if (this.mounted) {
//         setState(() {
//           _locationDetails = event[LocationDetailsBloc.KEY_LOCATION_INFO];
//           _guidesList = event[LocationDetailsBloc.KEY_GUIDES];
//         });
//       }
//     }
//   });

// Loading Screen
//   if (currentStatus == LocationDetailsBloc.STATUS_CODE_INIT) {
//     widget._locationBloc.getLocation(locationId);
//     return Scaffold(
//       body: Center(
//         child: Flex(
//           direction: Axis.vertical,
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             CircularProgressIndicator(),
//             Container(
//               height: 16,
//             ),
//             Text(S.of(context).loading)
//           ],
//         ),
//       ),
//     );
//   }
//
//   // Error Screen
//   if (currentStatus == LocationDetailsBloc.STATUS_CODE_LOAD_ERROR) {
//     return Scaffold(
//       body: Center(
//         child: Text(S.of(context).error_fetching_data),
//       ),
//     );
//   }
//
//   // Details Screen
//   if (currentStatus == LocationDetailsBloc.STATUS_CODE_LOAD_SUCCESS) {
//     return getLocationScreen();
//   }
//
//   return Scaffold(
//     body: Center(
//       child: Text('Undefined State'),
//     ),
//   );
// }
//
// double lastLocation = 0.0;
//
// Scaffold getLocationScreen() {
//
//   List<Widget> pageLayout = [
//     // _getCarousel(),
//     Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Text(_locationDetails.description),
//     ),
//     _guidesList.isNotEmpty ?
//       Padding(gu
//         padding: const EdgeInsets.all(8.0),
//         child: Text(
//           S.of(context).guides,
//           style: TextStyle(
//               fontSize: 24,
//               color: Colors.black45,
//               fontWeight: FontWeight.bold),
//         ),
//       ) : Container(),
//   ];
//
//  // pageLayout.addAll(getGuidesList());
//
//   // pageLayout.add(GuidesListWidget(_guidesList, _locationDetails.id));
//   // pageLayout.add(NewCommentWidget(
//   //   active: canSendComments,
//   //   onCommentAdded: (String msg) {
//   //     createComment(msg);
//   //   },
//   // ));
//
//   // pageLayout.add(CommentListWidget(_locationDetails.comments));
//   // pageLayout.add(SizedBox(
//   //   height: 80,
//   // ));
//
//   return Scaffold(
//     appBar: AppBar(
//       centerTitle: true,
//       title: Text(
//         _locationDetails.name,
//         style: TextStyle(
//             color: Colors.black45, fontWeight: FontWeight.bold, fontSize: 24),
//       ),
//       backgroundColor: Colors.white,
//     ),
//     body: Column(
//       children: <Widget>[
//         Expanded(
//           child: ListView(
//             controller: pageScrollController,
//             children: pageLayout,
//           ),
//         ),
//         GestureDetector(
//           onTap: () {
//             Navigator.of(context).pushNamed(
//               FormsRoutes.requestGuideForm,
//               arguments: RequestGuideNavigationArguments(
//                   cityId: this.locationId),
//             );
//           },
//           child: RequestGuideButton(
//             cityId: this._locationDetails.id.toString(),
//           ),
//         )
//       ],
//     ),
//   );
// }
//
// List<Widget> getGuidesList() {
//   List<Widget> guidesList = [];
//
//   List<GuideListItemModel> visibleGuides;
//
//   // No Expansion Needed
//   if (_guidesList.isNotEmpty) guidesListExpanded = true;
//
//   if (_guidesList.length > 3) {
//     visibleGuides =
//         guidesListExpanded ? _guidesList : _guidesList.sublist(0, 3);
//   } else {
//     visibleGuides = _guidesList;
//   }
//
//   // Construct the List into CSV text
//   visibleGuides.forEach((guide) {
//     String citiesInText = '';
//     guide.city.forEach((cityName) {
//       citiesInText = citiesInText + ' ' + cityName;
//     });
//
//     // Construct the List into CSV text
//     String languagesInText = '';
//     guide.language.forEach((language) {
//       languagesInText = languagesInText + language + ' ';
//     });
//
//     guidesList.add(GestureDetector(
//       onTap: () {
//         Navigator.of(context).pushNamed(
//           FormsRoutes.requestGuideForm,
//           arguments: RequestGuideNavigationArguments(
//               guideId: guide.user, cityId: _locationDetails.id.toString()),
//         );
//       },
//       child: GuideListItemWidget(
//         guideCity: citiesInText,
//         guideName: guide.name,
//         guideLanguage: languagesInText,
//         availability: guide.status,
//         rate: 3,
//         guideImage: guide.image,
//       ),
//     ));
//   });
//
//   if (guidesListExpanded == false) {
//     guidesList.add(Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         GestureDetector(
//           onTap: () {
//             guidesListExpanded = true;
//             setState(() {});
//           },
//           child: Container(
//             decoration: BoxDecoration(
//                 border: Border.all(),
//                 borderRadius: BorderRadius.all(Radius.circular(90))),
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(S.of(context).show_more),
//             ),
//           ),
//         )
//       ],
//     ));
//   }
//
//   return (_guidesList.isNotEmpty) ? guidesList : [];
// }
//
// void createComment(String newComment) {
//   widget._locationBloc
//       .postComment(newComment, locationId)
//       .then((createSuccess) {
//     widget._locationBloc.getLocation(locationId);
//   });
// }
//
// Widget _getCarousel() {
//   List<Widget> carouselList = [];
//
//   if (_locationDetails.paths != null) {
//     _locationDetails.paths.forEach((path) {
//       carouselList.add(Image.network(
//         '${path.path}'.contains('http')
//             ? '${path.path}'.substring(path.path.lastIndexOf('http'))
//             : path.path,
//         errorBuilder: (c, e, s) {
//           print('Got Error Loading Image');
//           return Image.asset('resources/images/logo.png');
//         },
//       ));
//     });
//   }
//
//   return carouselList.isEmpty
//       ? Container()
//       : CarouselWidget(carouselList);
// }
//
// Widget getEvaluationBar() {
//   List<Widget> stars = [];
//
//   if (currentRate == null) {
//     for (int i = 0; i < 5; i++) {
//       stars.add(GestureDetector(
//         onTap: () {
//           widget._locationBloc.createRate(i, locationId);
//         },
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Icon(Icons.star_border),
//         ),
//       ));
//     }
//   } else {
//     for (int i = 0; i <= currentRate; i++) {
//       stars.add(Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Icon(Icons.star),
//       ));
//     }
//   }
//
//   return Flex(
//     direction: Axis.horizontal,
//     children: stars,
//   );
// }
}
