import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tourists/user/ui/widgets/carousel/carousel.dart';
import 'package:tourists/user/ui/widgets/carousel_card/carousel_card.dart';
import 'package:tourists/user/ui/widgets/guide_list_item/guide_list_item.dart';

class LocationDetailsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LocationDetailsScreenState();
}

class _LocationDetailsScreenState extends State<LocationDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    // Get the Location Id
    final String locationId = ModalRoute.of(context).settings.arguments;

    // Get Location Details From Network

    List<Widget> pageLayout = [
      CarouselWidget([
        CarouselCard(
          title: 'title ',
          description: 'Best location in the World!',
          image:
              'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
          commentsNumber: 3,
          stars: 3,
        ),
        CarouselCard(
          title: 'title ',
          description: 'Best location in the World!',
          image:
              'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
          commentsNumber: 3,
          stars: 3,
        ),
        CarouselCard(
          title: 'title ',
          description: 'Best location in the World!',
          image:
              'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
          commentsNumber: 3,
          stars: 3,
        ),
        CarouselCard(
          title: 'title ',
          description: 'Best location in the World!',
          image:
              'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
          commentsNumber: 3,
          stars: 3,
        ),
        CarouselCard(
          title: 'title ',
          description: 'Best location in the World!',
          image:
              'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
          commentsNumber: 3,
          stars: 3,
        ),
      ]),
      Text('Description'),
      Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Container(
            child: Text('Evaluate'),
          ),
          // TODO Add Stars Bar
        ],
      ),
      Text('Guides who operates here')
    ];

    pageLayout.addAll(getGuidesList());

    return Scaffold(
      body: ListView(
        children: pageLayout,
      ),
    );
  }

  List<GuideListItemWidget> getGuidesList() {
    List<GuideListItemWidget> guidesList = [];

    // TODO: Create Guides List
    for (int i = 0; i < 20; i++) {
      guidesList.add(GuideListItemWidget(
        guideCity: 'Damascus',
        guideName: 'Mohammad',
        guideLanguage: 'العربية - English',
        availability: i % 3 == 0,
        rate: 3,
        guideImage:
            'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
      ));
    }

    return guidesList;
  }
}
