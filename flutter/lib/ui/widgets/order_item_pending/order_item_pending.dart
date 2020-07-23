import 'package:flutter/material.dart';

class OrderItemPendingWidget extends StatelessWidget {
  final String guideName;
  final String guideImage;
  final String guideLanguage;
  final String guideLocation;
  final DateTime orderDate;
  final String status;
  final DateTime paymentDate;
  final String orderServices;
  final String stayingDays;
  final String paymentValue;

  OrderItemPendingWidget(
      {Key key,
      @required this.guideName,
      @required this.guideImage,
      @required this.orderServices,
      @required this.paymentValue,
      @required this.stayingDays,
      @required this.status,
      @required this.guideLanguage,
      @required this.guideLocation,
      @required this.orderDate,
      @required this.paymentDate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration:
            BoxDecoration(border: Border.all(color: Colors.black, width: .5)),
        child: Flex(
          direction: Axis.vertical,
          children: <Widget>[
            // Guide Info
            Container(
              width: double.infinity,
              child: Flex(
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
                      child: Image.network(guideImage),
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
                            guideName,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Container(
                            height: 8,
                          ),
                          Text(guideLocation + ' / ' + guideLanguage),
                          Container(
                            height: 8,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(flex: 1, child: Icon(Icons.chat))
                ],
              ),
            ),
            Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      width: 72,
                    ),
                    Text('Services: ' + orderServices),
                    Container(
                      height: 8,
                    ),
                    Text('Stayed for: ' + stayingDays),
                    Container(
                      height: 8,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 16,
            ),
            Container(
              width: double.infinity,
              child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  RaisedButton(
                    child: Text('Confirm Payment'),
                    onPressed: () {},
                  )
                ],
              ),
            ),
            Container(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
