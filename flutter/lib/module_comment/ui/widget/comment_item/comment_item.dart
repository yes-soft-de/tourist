import 'package:flutter/material.dart';

class CommentItemWidget extends StatelessWidget {
  final String userName;
  final String userImage;
  final DateTime commentDate;
  final String comment;
  final String role;

  CommentItemWidget(
      {Key key, this.comment, this.commentDate, this.userImage, this.userName,this.role});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        child: Flex(
          direction: Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // User image and name
                Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.all(Radius.circular(100))),
                      child: Center(
                          child: Text(
                        userName.substring(0, 1).toUpperCase(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Flex(
                        direction: Axis.vertical,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            userName,
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(comment,
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 20))
                        ],
                      ),
                    ),
                    if(role=='guid')  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.security,
                        color:  Colors.greenAccent,
                      ),
                    ),
                  ],
                ),
                // Post Data
                Text(this.commentDate.toIso8601String().substring(0, 10))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
