import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/ui/widgets/order_item_request/order_item_request.dart';

@provide
class TouristOrdersScreen extends StatefulWidget {
  @override
  _TouristOrdersScreenState createState() => _TouristOrdersScreenState();
}

class _TouristOrdersScreenState extends State<TouristOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    List<Widget> pageLayout = [];

    pageLayout.add(Container(
      height: 36,
    ));

    Flex widgetHeader = Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Flexible(
            flex: 1,
            child: Container(
                alignment: Alignment.center,
                child: Text(
                  'Finished Orders',
                  textAlign: TextAlign.center,
                ))),
        Flexible(
            flex: 1,
            child: Container(
                alignment: Alignment.center,
                child: Text(
                  'Payed',
                  textAlign: TextAlign.center,
                ))),
        Flexible(
            flex: 1,
            child: Container(
                alignment: Alignment.center,
                child: Text(
                  'Pending Payment',
                  textAlign: TextAlign.center,
                ))),
        Flexible(
            flex: 1,
            child: Container(
                alignment: Alignment.center,
                child: Text(
                  'Sent',
                  textAlign: TextAlign.center,
                )))
      ],
    );
    pageLayout.add(widgetHeader);

    for (int i = 0; i < 3; i++) {
      pageLayout.add(OrderItemRequestWidget(
        guideName: 'Mohammad',
        guideLanguage: 'English - العربية',
        guideLocation: 'Aleppo',
        orderDate: DateTime.now(),
        guideImage:
            'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
        status: 'payed',
        paymentDate: DateTime(2020, 4, 24, 10, 14),
        stayingDays: '2 Days',
        paymentValue: '300 USD',
        orderServices: 'Car',
      ));
    }

    return ListView(
      children: pageLayout,
    );
  }
}
