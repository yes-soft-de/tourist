import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/user/ui/screens/location_details/location_details.dart';
import 'package:tourists/user/ui/widgets/carousel/carousel.dart';
import 'package:tourists/user/ui/widgets/carousel_card/carousel_card.dart';
import 'package:tourists/user/ui/widgets/location_list_item/location_list_item.dart';

@provide
class MainHomeSubScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainHomeSubScreenState();
}

class _MainHomeSubScreenState extends State<MainHomeSubScreen> {
  @override
  Widget build(BuildContext context) {
    List<Widget> locationCards = [];
    List<CarouselCard> carouselCards = [];

    // TODO Replace this with network source
    for (int i = 0; i < 10; i++) {
      locationCards.add(GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LocationDetailsScreen(),
                settings: RouteSettings(
                  // Replace this with location Id
                  arguments: i,
                ),
              ));
        },
        child: Padding(
          padding: EdgeInsets.all(8),
          child: LocationListItem(
            imageLink:
                'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
            title: 'title ' + i.toString(),
            description: 'Best in the world!',
            rate: 3,
            commentsNumber: 3,
          ),
        ),
      ));
      carouselCards.add(CarouselCard(
          'title ' + i.toString(),
          'Best location in the World!',
          'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
          3,
          3));
    }

    List<Widget> pageLayout = [];

    // Add Carousel
    pageLayout.add(CarouselWidget(carouselCards));

    // Add location Cards
    pageLayout.addAll(locationCards);

    return ListView(
      children: pageLayout,
    );
  }
}
