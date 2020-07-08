import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/user/bloc/guide_list/guide_list_bloc.dart';
import 'package:tourists/user/models/guide_list_item/guide_list_item.dart';
import 'package:tourists/user/ui/widgets/guide_list_item/guide_list_item.dart';

@provide
class TouristGuideListSubScreen extends StatefulWidget {
  final GuideListBloc _guideListBloc;

  TouristGuideListSubScreen(this._guideListBloc);

  @override
  State<StatefulWidget> createState() => _TouristGuideListSubScreenState();
}

class _TouristGuideListSubScreenState extends State<TouristGuideListSubScreen> {
  List<GuideListItemModel> _guidesList;
  bool loadingError;

  @override
  Widget build(BuildContext context) {
    widget._guideListBloc.guidesStream.listen((guidesList) {
      _guidesList = guidesList;
      loadingError = false;
      setState(() {});
    });

    if (loadingError == null) {
      widget._guideListBloc.getAllGuides();
      return Center(
        child: Text('Loading'),
      );
    }

    if (loadingError == true || _guidesList == null || _guidesList.length < 1) {
      widget._guideListBloc.getAllGuides();
      return Center(
        child: Text('Error Loading Data!'),
      );
    }

    List<Widget> pageLayout = [];

    pageLayout.add(Text('سياح'));

    return ListView(children: getGuidesList());
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
