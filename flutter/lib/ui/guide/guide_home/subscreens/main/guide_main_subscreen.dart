import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

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

    }

    return ListView(
      children: pageLayout,
    );

  }
}
