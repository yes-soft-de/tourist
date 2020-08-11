import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/module_chat/chat_routes.dart';
import 'package:tourists/module_orders/model/order/order_model.dart';

@provide
class OrderItemWidget extends StatelessWidget {
  final OrderModel orderModel;

  OrderItemWidget(this.orderModel);

  @override
  Widget build(BuildContext context) {
    // This will be the children of the flex
    List<Widget> widgetLayout = [];

    // If there is no guide assigned, Just don't show this
    if (orderModel.guidUserID != null)
      widgetLayout.add(Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Flexible(
            flex: 2,
            child: Container(
              height: 72,
              width: 72,
              decoration: BoxDecoration(),
              child: Image.network(orderModel.guideInfo.image),
            ),
          ),
          Flexible(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Flex(
                direction: Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    orderModel.guideInfo.user,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: 8,
                  ),
                  Text(orderModel.city + ' | ' + orderModel.language),
                  Container(
                    height: 8,
                  ),
                ],
              ),
            ),
          ),
          // Order date
          Flexible(
              flex: 1,
              child: Text(getDateTime(orderModel.date.timestamp)
                  .toIso8601String()
                  .substring(0, 10)))
        ],
      ));

    else widgetLayout.add(Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Flexible(
          flex: 2,
          child: Container(
            height: 72,
            width: 72,
            decoration: BoxDecoration(),
            child: Image.asset("resources/images/logo.jpg"),
          ),
        ),
        Flexible(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Flex(
              direction: Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  S.of(context).request_for_guide,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 8,
                ),
                Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(orderModel.city),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text("|"),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(orderModel.language),
                    )
                  ],
                ),
                Container(
                  height: 8,
                ),
              ],
            ),
          ),
        ),
        // Order date
        Flexible(
            flex: 1,
            child: Text(getDateTime(orderModel.date.timestamp)
                .toIso8601String()
                .substring(0, 10)))
      ],
    ));

    widgetLayout.add(Container(
      height: 8,
    ));

    // Services, under each other
    orderModel.services.forEach((service) {
      widgetLayout.add(Text(service));
    });

    // If not Payed, Show Pay Button
    if (orderModel.status == "waitingPayment") {
      widgetLayout.add(Text("Pending Guide"));
    }

    if (orderModel.status == "pendingConformation" &&
        orderModel.guidUserID != null) {
      // This should be, Start Payment Process
      widgetLayout.add(RaisedButton(
        onPressed: () {},
        child: Text("Start Chat"),
      ));
    }

    if (orderModel.status == "onGoing") {
      widgetLayout.add(Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          RaisedButton(
            child: Text("Chat"),
            onPressed: () {
              Navigator.pushNamed(context, ChatRoutes.chatRoute,
                  arguments: orderModel.roomID);
            },
          ),
          RaisedButton(
            child: Text("Complete!"),
            onPressed: () {
              // TODO: Update the Order Request as Completed
            },
          )
        ],
      ));
    }

    if (orderModel.status == "finished") {
      widgetLayout.add(Text("Order Finished at " +
          getDateTime(orderModel.leaveDate.timestamp)
              .toIso8601String()
              .substring(0, 10)));
    }

    widgetLayout.add(Container(height: 16,));

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.black45)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Flex(
            direction: Axis.vertical,
            children: widgetLayout,
          ),
        ),
      ),
    );
  }

  DateTime getDateTime(int seconds) {
    return new DateTime.fromMillisecondsSinceEpoch(orderModel.date.timestamp * 1000);
  }
}
