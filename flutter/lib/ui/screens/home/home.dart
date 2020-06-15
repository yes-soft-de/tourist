import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/ui/widgets/bottom_navigation_bar/buttom_navigation_bar.dart';
import 'package:tourists/ui/widgets/carousel/carousel.dart';
import 'package:tourists/ui/widgets/carousel_card/carousel_card.dart';
import 'package:tourists/ui/widgets/location_list_item/location_list_item.dart';

@provide
class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    List<Widget> locationCards = [];
    List<CarouselCard> carouselCards = [];

    for (int i = 0; i < 10; i++) {
      locationCards.add(Padding(
        padding: EdgeInsets.all(8),
        child: LocationListItem.createLocationListItem(
            'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
            'title ' + i.toString(),
            'Best in the world!',
            3,
            3),
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

    return Scaffold(
      body: Stack(
        children: <Widget>[
          ListView(
            children: pageLayout,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomBottomNavigationBar(0),
          )
        ],
      ),
    );
  }
}
