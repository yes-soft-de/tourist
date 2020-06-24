import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventListItemWidget extends StatelessWidget {
  String image;
  String name;
  String time;
  String location;
  String status;
  int commentNumber;

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
    return Container(
      height: 56,
      child: Row(
        children: <Widget>[
          Container(
            height: 56,
            width: 56,
            child: Image.network(
              image,
              fit: BoxFit.contain,
            ),
          ),
          Flex(
            direction: Axis.vertical,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    status,
                    style: TextStyle(color: Colors.greenAccent),
                  ),
                  Flex(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      Icon(Icons.chat),
                      Text('Comment(s)'),
                      Text(commentNumber.toString())
                    ],
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
