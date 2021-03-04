import 'package:flutter/material.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/module_comment/response/comment/comment_response.dart';
import 'package:tourists/module_comment/ui/widget/comment_item/comment_item.dart';
import 'package:tourists/utils/time/time_formatter.dart';

class CommentListWidget extends StatefulWidget {
  final List<CommentModel> comments;
  List<CommentModel> displayedComments = [];



  CommentListWidget(this.comments){
    displayedComments = (comments.length > 3)
        ? comments.sublist(0, 3)
        : comments;
  }

  @override
  State<StatefulWidget> createState() => _CommentListWidgetState();
}

class _CommentListWidgetState extends State<CommentListWidget> {
//  bool commentListCollapsed = true;

  _CommentListWidgetState();

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
            itemCount: widget.displayedComments.length,
            itemBuilder: (BuildContext context, int index){
              return CommentItemWidget(
                comment: widget.displayedComments[index].comment,
                userName: widget.displayedComments[index].userName,
                commentDate: TimeFormatter.getDartDate(widget.displayedComments[index].date),
              );
            }
        ),
        if(widget.comments.length > widget.displayedComments.length)
            RaisedButton(
                onPressed: (){
                  setState(() {

                    int startIndex = widget.displayedComments.length-1;
                    widget.displayedComments.addAll((widget.comments.length -widget. displayedComments.length >3)
                        ? widget.comments.sublist(startIndex,startIndex+3)
                        :widget.comments.sublist(startIndex));
                  });
                },
              child:Text(
                  S.of(context).show_more
              )
        )
      ],
    );
  }
}
