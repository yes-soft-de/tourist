import 'package:flutter/material.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/module_comment/response/comment/comment_response.dart';
import 'package:tourists/module_comment/ui/widget/comment_item/comment_item.dart';
import 'package:tourists/utils/time/time_formatter.dart';

class CommentListWidget extends StatefulWidget {
  final List<CommentModel> comments;

  CommentListWidget(this.comments);

  @override
  State<StatefulWidget> createState() => _CommentListWidgetState();
}

class _CommentListWidgetState extends State<CommentListWidget> {
  bool commentListCollapsed = true;

  _CommentListWidgetState();

  @override
  Widget build(BuildContext context) {
    if (widget.comments == null) return Container();

    List<Widget> comments = [];
    List<CommentModel> allComments = [];

    if (widget.comments.length > 2 && commentListCollapsed) {
      allComments = widget.comments.sublist(0, 2);
    } else {
      allComments = widget.comments;
    }

    allComments.forEach((element) {
      comments.add(CommentItemWidget(
        comment: element.comment,
        userName: element.userName,
        commentDate: TimeFormatter.getDartDate(element.date),
      ));
    });

    comments.add(RaisedButton(
      child: Text(
        commentListCollapsed ? S.of(context).show_more : S.of(context).showLess,
      ),
      onPressed: () {
        commentListCollapsed = !commentListCollapsed;
        setState(() {});
      },
    ));

    return Flex(
      direction: Axis.vertical,
      children: comments,
    );
  }
}
