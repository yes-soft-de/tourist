import 'package:flutter/material.dart';
import 'package:tourists/generated/l10n.dart';

import '../../../../module_forms/forms_routes.dart';
import '../../../../module_guide/model/guide_list_item/guide_list_item.dart';
import '../../../../module_guide/nav_arguments/request_guide/request_guide_navigation.dart';
import '../../../../module_guide/ui/widget/guide_list_item/guide_list_item.dart';

class GuidesListWidget extends StatefulWidget {
  final List<GuideListItemModel> guides;
  List<GuideListItemModel> displayedGuides= [];
 final  int cityId;



  GuidesListWidget(this.guides,this.cityId){
    displayedGuides = (guides.length > 3)
        ? guides.sublist(0, 3)
        : guides;
  }

  @override
  State<StatefulWidget> createState() => _GuidesListWidgetState();
}

class _GuidesListWidgetState extends State<GuidesListWidget> {

  @override
  Widget build(BuildContext context) {
    if (widget.guides == null) return Container();



    return Column(
      children: [
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.displayedGuides.length,
            itemBuilder: (BuildContext context, int index){

              // Construct the List into CSV text
              String citiesInText = '';
              widget.displayedGuides[index].city.forEach((cityName) {
                citiesInText = citiesInText + ' ' + cityName;
              });

              // Construct the List into CSV text
              String languagesInText = '';
              widget.displayedGuides[index].language.forEach((language) {
                languagesInText = languagesInText + language + ' ';
              }
              );
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    FormsRoutes.requestGuideForm,
                    arguments: RequestGuideNavigationArguments(
                        guideId:  widget.displayedGuides[index].user, cityId: widget.cityId.toString()),
                  );
                },
                child: GuideListItemWidget(
                  guideCity: citiesInText,
                  guideName:  widget.displayedGuides[index].name,
                  guideLanguage: languagesInText,
                  availability:  widget.displayedGuides[index].status,
                  rate: 3,
                  guideImage:  widget.displayedGuides[index].image,
                ),
              );
            }
        ),
        if(widget.guides.length > widget.displayedGuides.length)
          RaisedButton(
              onPressed: (){
                setState(() {

                  int startIndex = widget.displayedGuides.length-1;
                  widget.displayedGuides.addAll((widget.guides.length -widget. displayedGuides.length >3)
                      ? widget.guides.sublist(startIndex,startIndex+3)
                      :widget.guides.sublist(startIndex));
                });
              },
              child:Text(
                  S.of(context).show_more
              )
          )
      ],
    );
  }
}
