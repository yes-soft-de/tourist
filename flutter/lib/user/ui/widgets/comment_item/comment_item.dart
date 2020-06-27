import 'package:flutter/material.dart';

class CommentItemWidget extends StatelessWidget {
  final String userName;
  final String userImage;
  final DateTime commentDate;
  final String comment;

  CommentItemWidget(
      {Key key, this.comment, this.commentDate, this.userImage, this.userName});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // User image and name
              Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Container(
                    height: 72,
                    width: 72,
                    child: Image.network(userImage),
                  ),
                  Text(userName),
                ],
              ),
              // Post Data
              Text(this.commentDate.toIso8601String())
            ],
          ),
          Text(comment)
        ],
      ),
    );
  }
}
