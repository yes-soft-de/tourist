import 'package:flutter/material.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/module_comment/response/comment/comment_response.dart';
import 'package:tourists/module_comment/ui/widget/comment_item/comment_item.dart';
import 'package:tourists/utils/time/time_formatter.dart';

class CommentListWidget extends StatefulWidget {
  final List<CommentModel> comments;

  CommentListWidget(this.comments);

  @override
  State<StatefulWidget> createState() => _CommentListWidgetState(this.comments);
}

class _CommentListWidgetState extends State<CommentListWidget> {
//  bool commentListCollapsed = true;
  List<CommentModel> displayedComments;

  _CommentListWidgetState(List<CommentModel> comments) {
    displayedComments =
        (comments.length > 3) ? comments.sublist(0, 3) : comments;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.comments == null) return Container();

//    List<Widget> comments = [];

//    if (widget.comments.length > 2 && commentListCollapsed) {
//      allComments = widget.comments.sublist(0, 2);
//    } else {
//      allComments = widget.comments;
//    }
//
//    displayedComments.forEach((element) {
//      comments.add(CommentItemWidget(
//        comment: element.comment,
//        userName: element.userName,
//        commentDate: TimeFormatter.getDartDate(element.date),
//      )
//      );
//    });
//
//    comments.add(
//        RaisedButton(
//      child: Text(
//        /*commentListCollapsed ? */S.of(context).show_more /*: S.of(context).showLess,*/
//      ),
//      onPressed: () {
////        commentListCollapsed = !commentListCollapsed;
//        setState(() {});
//      },
//    ));

    return Column(
//      direction: Axis.vertical,
      children: [
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: displayedComments.length,
            itemBuilder: (BuildContext context, int index) {
              if (displayedComments[index].comment != null &&
                  displayedComments[index].userName != null) {
                return CommentItemWidget(
                  comment: displayedComments[index].comment,
                  userName: displayedComments[index].userName,
                  commentDate: TimeFormatter.getDartDate(
                      displayedComments[index].date),
                );
              } else {
                return Container();
              }
            }),
        if (widget.comments.length > displayedComments.length)
          RaisedButton(
              onPressed: () {
                setState(() {
                  int startIndex = displayedComments.length - 1;
                  displayedComments.addAll((widget.comments.length -
                              displayedComments.length >
                          3)
                      ? widget.comments.sublist(startIndex, startIndex + 3)
                      : widget.comments.sublist(startIndex));
                });
              },
              child: Text(S.of(context).show_more))
      ],
    );
  }
}
