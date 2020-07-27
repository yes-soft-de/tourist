import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/bloc/guide_list/guide_list_bloc.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/models/guide_list_item/guide_list_item.dart';
import 'package:tourists/nav_arguments/request_guide/request_guide_navigation.dart';
import 'package:tourists/ui/user/request_guide/request_guide_screen.dart';
import 'package:tourists/ui/widgets/guide_list_item/guide_list_item.dart';

@provide
class TouristGuideListSubScreen extends StatefulWidget {
  final GuideListBloc _guideListBloc;
  final RequestGuideScreen _requestGuideScreen;

  TouristGuideListSubScreen(this._guideListBloc, this._requestGuideScreen);

  @override
  State<StatefulWidget> createState() => _TouristGuideListSubScreenState();
}

class _TouristGuideListSubScreenState extends State<TouristGuideListSubScreen> {
  int currentStatus = GuideListBloc.STATUS_CODE_INIT;
  List<GuideListItemModel> _guidesList;

  @override
  Widget build(BuildContext context) {
    widget._guideListBloc.guidesStream.listen((guidesListEvent) {
      currentStatus = guidesListEvent.first;
      if (currentStatus == GuideListBloc.STATUS_CODE_LOAD_SUCCESS) {
        _guidesList = guidesListEvent.last;
        setState(() {});
      }
    });

    if (currentStatus == GuideListBloc.STATUS_CODE_INIT) {
      widget._guideListBloc.getAllGuides();
      return Center(
        child: Text(S.of(context).loading),
      );
    }

    if (currentStatus == GuideListBloc.STATUS_CODE_LOAD_ERROR) {
      widget._guideListBloc.getAllGuides();
      return Center(
        child: Text(S.of(context).error_fetching_data),
      );
    }

    if (currentStatus == GuideListBloc.STATUS_CODE_LOAD_SUCCESS) {
      List<Widget> pageLayout = [];

      pageLayout.add(AppBar(
        title: Text('سياح'),
        backgroundColor: Colors.white,
      ));

      return ListView(children: getGuidesList());
    }

    return Center(
      child: Text("Unidentified State!"),
    );
  }

  List<Widget> getGuidesList() {
    List<Widget> guidesList = [];

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

      guidesList.add(GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => widget._requestGuideScreen,
                settings: RouteSettings(
                  // Replace this with location Id
                  arguments: RequestGuideNavigationArguments(
                      guideId: guide.user, cityId: null),
                ),
              ));
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

    return guidesList;
  }
}
