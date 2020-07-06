import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/user/ui/widgets/guide_list_item/guide_list_item.dart';

@provide
class TouristGuideListSubScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TouristGuideListSubScreenState();
}

class _TouristGuideListSubScreenState extends State<TouristGuideListSubScreen> {
  @override
  Widget build(BuildContext context) {

    List<Widget> guideList = [];

    guideList.add(Text('سياح'));

    for (int i = 0; i < 20; i++) {
      guideList.add(GuideListItemWidget(
        guideCity: 'Damascus',
        guideName: 'Mohammad',
        guideLanguage: 'العربية - English',
        availability: i % 3 == 0,
        rate: 3,
        guideImage:
            'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
      ));
    }

    return ListView(
      children: guideList
    );
  }
}
