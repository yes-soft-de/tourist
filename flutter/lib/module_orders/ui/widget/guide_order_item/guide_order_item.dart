import 'package:flutter/material.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/module_chat/chat_routes.dart';
import 'package:tourists/module_orders/model/order/order_model.dart';

class GuideOrderItemWidget extends StatelessWidget {
  final OrderModel orderModel;
  final Function(OrderModel) onAcceptOrder;
  final Function(OrderModel) onAcceptAvailableOrder;
  final Function(OrderModel) onPayOrder;
  final Function(OrderModel) onPayAvailableOrder;

  final _priceController = TextEditingController();

  GuideOrderItemWidget(
    this.orderModel, {
    this.onAcceptOrder,
    this.onPayAvailableOrder,
    this.onAcceptAvailableOrder,
    this.onPayOrder,
  });

  @override
  Widget build(BuildContext context) {
    // This will be the children of the flex
    List<Widget> widgetLayout = [];

    // If there is guide assigned, Show Multiple Choices
    if (orderModel.guidUserID != null) {
      if (orderModel.status == 'pending') {
        widgetLayout.add(_getPendingOrder(orderModel, context));
      } else if (orderModel.status == 'onGoing') {
        // There is a chat here
        widgetLayout.add(_getOnGoingOrder(orderModel, context));
      } else if (orderModel.status == 'finished') {
        widgetLayout.add(_getFinishedOrder(orderModel, context));
      }
    } else {
      _priceController.text = '${orderModel?.cost}';
      widgetLayout.add(_getAvailableOrder(orderModel, context));
    }

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

  Widget _getAvailableOrder(OrderModel orderModel, BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: <Widget>[
        Text(S.of(context).proposal),
        Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Container(
                height: 72,
                width: 72,
                decoration: BoxDecoration(),
                child: Image.asset('resources/images/logo.jpg'),
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
                          child: Text('|'),
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
                child: Text(DateTime.fromMillisecondsSinceEpoch(
                        orderModel.date.timestamp * 1000)
                    .toIso8601String()
                    .toString()
                    .substring(5, 10)))
          ],
        ),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _priceController,
                decoration: InputDecoration(
                  hintText: S.of(context).priceProposal,
                  labelText: S.of(context).priceProposal,
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  orderModel.cost = _priceController.text;
                  onAcceptAvailableOrder(orderModel);
                }),
          ],
        ),
      ],
    );
  }

  Widget _getPendingOrder(OrderModel orderModel, BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        Text(S.of(context).pending),
        Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Container(
                  height: 72,
                  width: 72,
                  alignment: Alignment.center,
                  child: Image.asset(
                    'resources/images/logo.jpg',
                    fit: BoxFit.contain,
                  )),
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
                      orderModel.guideInfo == null
                          ? orderModel.touristUserID
                              .substring(orderModel.touristUserID.length)
                          : orderModel.guideInfo.name,
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
                child: Text(DateTime.fromMillisecondsSinceEpoch(
                        orderModel.date.timestamp * 1000)
                    .toString()
                    .substring(5, 10)))
          ],
        ),
      ],
    );
  }

  Widget _getOnGoingOrder(OrderModel orderModel, BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        Text(S.of(context).onGoing),
        Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Container(
                  height: 72,
                  width: 72,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Colors.greenAccent),
                  child: Image.asset(
                    'resources/images/logo.jpg',
                    fit: BoxFit.contain,
                  )),
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
                      orderModel.guideInfo == null
                          ? orderModel.touristUserID
                          : orderModel.guideInfo.name,
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
                child: Text(DateTime.fromMillisecondsSinceEpoch(
                        orderModel.date.timestamp * 1000)
                    .toString()
                    .substring(5, 10)))
          ],
        ),
        RaisedButton(
          child: Text(S.of(context).openChat),
          onPressed: () {
            Navigator.of(context)
                .pushNamed(ChatRoutes.chatRoute, arguments: orderModel.roomID);
          },
        )
      ],
    );
  }

  Widget _getFinishedOrder(OrderModel orderModel, BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Text(S.of(context).finished),
        Flexible(
          flex: 1,
          child: Container(
              height: 72,
              width: 72,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: Colors.greenAccent),
              child: Image.asset(
                'resources/images/logo.jpg',
                fit: BoxFit.contain,
              )),
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
                  orderModel.guideInfo == null
                      ? orderModel.touristUserID
                          .substring(orderModel.touristUserID.length - 4)
                      : orderModel.guideInfo.name,
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
            child: Text(DateTime.fromMillisecondsSinceEpoch(
                    orderModel.date.timestamp * 1000)
                .toString()
                .substring(5, 10)))
      ],
    );
  }
}
