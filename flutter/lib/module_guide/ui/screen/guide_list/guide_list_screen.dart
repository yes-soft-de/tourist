import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/module_forms/forms_routes.dart';
import 'package:tourists/module_guide/bloc/guide_list/guide_list_bloc.dart';
import 'package:tourists/module_guide/model/guide_list_item/guide_list_item.dart';
import 'package:tourists/module_guide/nav_arguments/request_guide/request_guide_navigation.dart';
import 'package:tourists/module_guide/ui/widget/guide_list_item/guide_list_item.dart';

@provide
class GuideListScreen extends StatefulWidget {
  final GuideListBloc _guideListBloc;

  GuideListScreen(this._guideListBloc);

  @override
  State<StatefulWidget> createState() => _GuideListScreenState();
}

class _GuideListScreenState extends State<GuideListScreen> {
  int currentStatus = GuideListBloc.STATUS_CODE_INIT;
  List<GuideListItemModel> _guidesList;

  @override
  Widget build(BuildContext context) {
    widget._guideListBloc.guidesStream.listen((guidesListEvent) {
      currentStatus = guidesListEvent.first;
      if (currentStatus == GuideListBloc.STATUS_CODE_LOAD_SUCCESS) {
        _guidesList = guidesListEvent.last;
      }
      if (this.mounted) setState(() {});
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

      return Flex(direction: Axis.vertical, children: getGuidesList());
    }

    return Center(
      child: Text("Unidentified State!"),
    );
  }

  List<Widget> getGuidesList() {
    List<Widget> guidesList = [];

    // Construct the List into CSV text
    _guidesList.forEach((guide) {
      String citiesInText = " ";
      guide.city.forEach((cityName) {
        citiesInText = citiesInText + cityName + " ";
      });
      print(citiesInText);

      // Construct the List into CSV text
      String languagesInText = " ";
      guide.language.forEach((language) {
        languagesInText = languagesInText + language + " ";
      });

      guidesList.add(GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(FormsRoutes.requestGuideForm,
              arguments: RequestGuideNavigationArguments(guideId: guide.user));
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
