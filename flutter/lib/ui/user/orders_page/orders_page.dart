import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/ui/widgets/order_item_done/order_item_done.dart';
import 'package:tourists/ui/widgets/order_item_ongoing/order_item_ongoing.dart';
import 'package:tourists/ui/widgets/order_item_pending/order_item_pending.dart';
import 'package:tourists/ui/widgets/order_item_request/order_item_request.dart';

@provide
class OrdersScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  PageController _pageController = PageController();
  int activePosition = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> pageLayout = [];

    pageLayout.add(Container(
      height: 36,
    ));

    // Header
    Flex widgetHeader = Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Flexible(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                activePosition = 1;
                _pageController.jumpToPage(1);
                setState(() {});
              },
              child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Sent / Pending',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: activePosition == 3
                            ? Colors.greenAccent
                            : Colors.black),
                  )),
            )),
        Flexible(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                activePosition = 1;
                _pageController.jumpToPage(1);
                setState(() {});
              },
              child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Pending Payment',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: activePosition == 2
                            ? Colors.greenAccent
                            : Colors.black),
                  )),
            )),
        Flexible(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                activePosition = 1;
                _pageController.jumpToPage(1);
                setState(() {});
              },
              child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Payed / On going',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: activePosition == 1
                            ? Colors.greenAccent
                            : Colors.black),
                  )),
            )),
        Flexible(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                activePosition = 0;
                _pageController.jumpToPage(0);
                setState(() {});
              },
              child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Finished Orders',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: activePosition == 0
                            ? Colors.greenAccent
                            : Colors.black),
                  )),
            )),
      ],
    );
    pageLayout.add(widgetHeader);

    // Page 01: Sent Orders.
    // Here we have all the payments that is sent from the user.
    ListView sentOrders = getSentOrdersList();
    ListView pendingPaymentOrders = getPendingPaymentList();
    ListView onGoing = getOnGoingOrdersList();
    ListView done = getFinishedOrdersList();

    PageView orderPages = PageView(
      controller: _pageController,
      onPageChanged: (position) {
        activePosition = position;
        setState(() {});
      },
      children: <Widget>[
        sentOrders,
        pendingPaymentOrders,
        onGoing,
        done
      ],
    );

    pageLayout.add(Expanded(
      child: orderPages,
    ));

    return Scaffold(
        body: WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        return;
      },
      child: Flex(
        direction: Axis.vertical,
        children: pageLayout,
      ),
    ));
  }

  Widget getSentOrdersList() {
    return ListView(
      children: <Widget>[
        OrderItemRequestWidget(
          guideName: 'Mohammad',
          guideLanguage: 'English - العربية',
          guideLocation: 'Aleppo',
          guideImage:
              'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
          stayingDays: '2 Days',
          orderServices: 'Car',
        ),
        OrderItemRequestWidget(
          guideName: 'Mohammad',
          guideLanguage: 'English - العربية',
          guideLocation: 'Aleppo',
          guideImage:
              'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
          stayingDays: '2 Days',
          orderServices: 'Car',
        ),
        OrderItemRequestWidget(
          guideName: 'Mohammad',
          guideLanguage: 'English - العربية',
          guideLocation: 'Aleppo',
          guideImage:
              'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
          stayingDays: '2 Days',
          orderServices: 'Car',
        )
      ],
    );
  }

  ListView getPendingPaymentList() {
    return ListView(
      children: <Widget>[
        OrderItemPendingWidget(
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
        ),
        OrderItemPendingWidget(
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
        ),
        OrderItemPendingWidget(
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
        )
      ],
    );
  }

  ListView getOnGoingOrdersList() {
    return ListView(
      children: <Widget>[
        OrderItemOngoingWidget(
          guideName: 'Mohammad',
          guideLanguage: 'English - العربية',
          guideLocation: 'Aleppo',
          guideImage:
              'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
          stayingDays: '2 Days',
          orderServices: 'Car',
        ),
        OrderItemOngoingWidget(
          guideName: 'Mohammad',
          guideLanguage: 'English - العربية',
          guideLocation: 'Aleppo',
          guideImage:
              'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
          stayingDays: '2 Days',
          orderServices: 'Car',
        ),
        OrderItemOngoingWidget(
          guideName: 'Mohammad',
          guideLanguage: 'English - العربية',
          guideLocation: 'Aleppo',
          guideImage:
              'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
          stayingDays: '2 Days',
          orderServices: 'Car',
        )
      ],
    );
  }

  ListView getFinishedOrdersList() {
    return ListView(
      children: <Widget>[
        OrderItemDoneWidget(
          guideName: 'Mohammad',
          guideLanguage: 'English - العربية',
          guideLocation: 'Aleppo',
          guideImage:
              'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
          stayingDays: '2 Days',
          orderServices: 'Car',
        ),
        OrderItemDoneWidget(
          guideName: 'Mohammad',
          guideLanguage: 'English - العربية',
          guideLocation: 'Aleppo',
          guideImage:
              'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
          stayingDays: '2 Days',
          orderServices: 'Car',
        ),
        OrderItemDoneWidget(
          guideName: 'Mohammad',
          guideLanguage: 'English - العربية',
          guideLocation: 'Aleppo',
          guideImage:
              'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
          stayingDays: '2 Days',
          orderServices: 'Car',
        )
      ],
    );
  }
}
