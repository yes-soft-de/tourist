import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/ui/widgets/order_item_request/order_item_request.dart';

@provide
class GuideMainSubScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _GuideMainSubScreenState();
}

class _GuideMainSubScreenState extends State<GuideMainSubScreen> {
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
        guideImage:
        'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
        stayingDays: '2 Days',
        orderServices: 'Car',
      ));
    }

    return ListView(
      children: pageLayout,
    );

  }
}
