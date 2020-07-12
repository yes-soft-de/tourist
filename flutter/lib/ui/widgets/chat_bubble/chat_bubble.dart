import 'package:flutter/material.dart';

class ChatBubbleWidget extends StatefulWidget {
  final bool showImage;
  final String userProfileImage;
  final String message;
  final DateTime sentDate;

  ChatBubbleWidget({
    Key key,
    @required this.userProfileImage,
    @required this.message,
    @required this.sentDate,
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

    if (widget.showImage == true) {
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
        child: Container(
          decoration:
              BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(90))),
          child: Image.network(
            widget.userProfileImage,
            fit: BoxFit.contain,
          ),
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
