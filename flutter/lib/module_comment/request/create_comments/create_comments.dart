class CreateCommentRequest {
  String comment;
  String region;
  String user;

  CreateCommentRequest({this.comment, this.region, this.user});

  CreateCommentRequest.fromJson(Map<String, dynamic> json) {
    comment = json['comment'];
    region = json['region'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['comment'] = this.comment;
    data['region'] = this.region;
    data['user'] = this.user;
    data['date'] = DateTime.now().toIso8601String();
    return data;
  }
}
