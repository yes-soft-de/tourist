import 'package:flutter/material.dart';

class ChatBubbleWidget extends StatefulWidget {
  final bool showImage;
  final String message;
  final DateTime sentDate;
  final bool me;

  ChatBubbleWidget({
    Key key,
    @required this.message,
    @required this.sentDate,
    @required this.me,
    this.showImage,
  });

  @override
  State<StatefulWidget> createState() => ChatBubbleWidgetState();
}

class ChatBubbleWidgetState extends State<ChatBubbleWidget> {
  bool focused = false;

  @override
  Widget build(BuildContext context) {
    List<Widget> rowLayout = [];

    if (widget.me) {
      rowLayout.add(GestureDetector(
        onTap: () {
          if (focused == null) {
            focused = true;
            setState(() {});
            return;
          }
          focused = !focused;
          setState(() {});
        },
        child: Flex(
          direction: Axis.horizontal,
          children: <Widget>[
            Flexible(
              flex: 3,
              child: Container(
                color: widget.me ? Colors.white70 : Colors.greenAccent,
                child: Text(widget.message),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(),
            )
          ],
        ),
      ));
    } else {
      rowLayout.add(GestureDetector(
        onTap: () {
          if (focused == null) {
            focused = true;
            setState(() {});
            return;
          }
          focused = !focused;
          setState(() {});
        },
        child: Flex(
          direction: Axis.horizontal,
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Container(),
            ),
            Flexible(
              flex: 3,
              child: Container(
                color: widget.me ? Colors.white70 : Colors.greenAccent,
                child: Text(widget.message),
              ),
            ),
          ],
        ),
      ));
    }

    // Divider
    rowLayout.add(Container(
      width: 8,
    ));

    // Message
    rowLayout.add(Container(
      child: Text(widget.message),
      decoration:
          BoxDecoration(color: focused ? Colors.greenAccent : Colors.white10),
    ));

    Widget widgetLayout = Flex(
      direction: Axis.vertical,
      children: <Widget>[
        Row(
          children: rowLayout,
        ),
        focused == true ? Text(widget.sentDate.toIso8601String()) : null
      ],
    );

    return widgetLayout;
  }
}
