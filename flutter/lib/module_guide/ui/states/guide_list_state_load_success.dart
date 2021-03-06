import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tourists/module_forms/forms_routes.dart';
import 'package:tourists/module_guide/model/guide_list_item/guide_list_item.dart';
import 'package:tourists/module_guide/nav_arguments/request_guide/request_guide_navigation.dart';
import 'package:tourists/module_guide/ui/screen/guide_list/guide_list_screen.dart';
import 'package:tourists/module_guide/ui/states/guide_list_state.dart';
import 'package:tourists/module_guide/ui/widget/guide_list_item/guide_list_item.dart';

class GuideListStateLoadSuccess extends GuideListState {
  final List<GuideListItemModel> _guidesList;

  GuideListStateLoadSuccess(GuideListScreen screen, this._guidesList)
      : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return Flex(direction: Axis.vertical, children: getGuidesList(context));
  }

  List<Widget> getGuidesList(BuildContext context) {
    List<Widget> guidesList = [];

    // Construct the List into CSV text
    _guidesList.forEach((guide) {
      String citiesInText = ' ';
      guide.city.forEach((cityName) {
        citiesInText = citiesInText + cityName + ' ';
      });
      print(citiesInText);

      // Construct the List into CSV text
      String languagesInText = ' ';
      guide.language.forEach((language) {
        languagesInText = languagesInText + language + ' ';
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
