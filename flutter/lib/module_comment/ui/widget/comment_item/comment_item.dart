import 'package:flutter/material.dart';

class CommentItemWidget extends StatelessWidget {
  final String userName;
  final String userImage;
  final DateTime commentDate;
  final String comment;
  final String role;

  CommentItemWidget({
    Key key,
    this.comment,
    this.commentDate,
    this.userImage,
    this.userName,
    this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                color: Colors.greenAccent,
                shape: BoxShape.circle,
              ),
              child: Center(
                  child: Text(
                userName == null ? ' ' : userName.substring(0, 1).toUpperCase(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              )),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    comment,
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 16),
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ),
          // User image and name
          // Flex(
          //   direction: Axis.vertical,
          //   children: <Widget>[
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Flex(
          //         direction: Axis.vertical,
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: <Widget>[

          //           Expanded(
          //             child:
          //           )
          //         ],
          //       ),
          //     ),
          //     if (role == 'guid')
          //       Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Icon(
          //           Icons.security,
          //           color: Colors.greenAccent,
          //         ),
          //       ),
          //   ],
          // ),
          // // Post Data
          Text(this.commentDate.toIso8601String().substring(0, 10))
        ],
      ),
    );
  }
}
