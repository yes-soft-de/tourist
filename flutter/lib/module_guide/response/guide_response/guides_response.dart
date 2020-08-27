import 'package:tourists/module_guide/model/guide_list_item/guide_list_item.dart';

class GuidesResponse {
  String statusCode;
  String msg;
  List<GuideListItemModel> data;

  GuidesResponse({this.statusCode, this.msg, this.data});

  GuidesResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <GuideListItemModel>[];
      json['data'].forEach((v) {
        if (v != null) data.add(new GuideListItemModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status_code'] = this.statusCode;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
