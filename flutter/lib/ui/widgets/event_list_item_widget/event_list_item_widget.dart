import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventListItemWidget extends StatelessWidget {
  final String image;
  final String name;
  final String time;
  final String location;
  final String status;
  final int commentNumber;

  EventListItemWidget(
      {Key key,
      @required this.name,
      @required this.image,
      @required this.location,
      @required this.time,
      @required this.status,
      @required this.commentNumber});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Container(
              height: 96,
              width: 96,
              child: Image.network(
                image,
                fit: BoxFit.contain,
              ),
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
                    name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    time,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(location),
                  Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: Text(
                          status,
                          style: TextStyle(color: Colors.greenAccent),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Flex(
                          direction: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Icon(Icons.chat),
                            Container(
                              width: 8,
                            ),
                            Text(commentNumber.toString() + ' Comment(s)'),

                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )

        ],
      ),
    );
  }
}
