import 'package:flutter/material.dart';

class NewCommentWidget extends StatelessWidget {
  final Function(String) onCommentAdded;
  final bool active;

  final TextEditingController commentController = TextEditingController();

  NewCommentWidget({@required this.onCommentAdded, @required this.active});

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: commentController,
              decoration: InputDecoration(hintText: 'Comment Here'),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: GestureDetector(
            onTap: () {
              createComment();
            },
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              ),
              decoration: BoxDecoration(
                  color: active ? Colors.greenAccent : Colors.grey),
            ),
          ),
        )
      ],
    );
  }

  createComment() {
    if (!active) {
      return;
    }
    if (commentController.text == null) return;
    if (commentController.text.length > 0) {
      onCommentAdded(commentController.text);
    }

    commentController.clear();
  }
}