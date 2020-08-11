import 'package:tourists/module_shared/model/date/date.dart';

class CreateCommentResponse {
  String comment;
  Date date;
  Null region;
  Null user;

  CreateCommentResponse({this.comment, this.date, this.region, this.user});

  CreateCommentResponse.fromJson(Map<String, dynamic> json) {
    comment = json['comment'];
    date = json['date'] != null ? new Date.fromJson(json['date']) : null;
    region = json['region'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comment'] = this.comment;
    if (this.date != null) {
      data['date'] = this.date.toJson();
    }
    data['region'] = this.region;
    data['user'] = this.user;
    return data;
  }
}
