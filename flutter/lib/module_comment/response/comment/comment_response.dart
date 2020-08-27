import 'package:tourists/module_shared/model/date/date.dart';

class CommentModel {
  String comment;
  Date date;
  String userName;

  CommentModel({this.comment, this.date, this.userName});

  CommentModel.fromJson(Map<String, dynamic> json) {
    comment = json['comment'];
    date = json['date'] != null ? new Date.fromJson(json['date']) : null;
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['comment'] = this.comment;
    if (this.date != null) {
      data['date'] = this.date.toJson();
    }
    data['userName'] = this.userName;
    return data;
  }
}
