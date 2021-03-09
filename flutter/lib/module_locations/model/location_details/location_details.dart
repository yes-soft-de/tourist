import 'dart:developer';

import 'package:tourists/module_comment/response/comment/comment_response.dart';

class LocationDetailsModel {
  int id;
  String name;
  String description;
//  String location;
  List<CommentModel> comments;
  int ratingAverage;
  List<Paths> paths;

  LocationDetailsModel(
      {this.id,
      this.name,
      this.description,
//      this.location,
      this.comments,
      this.ratingAverage,
      this.paths});

  LocationDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
//    location = json['location'];
    ratingAverage = json['ratingAverage'];
    if (json['comments'] != null) {
      comments = <CommentModel>[];
      json['comments'].forEach((v) {
        comments.add(new CommentModel.fromJson(v));
      });
    }
    if (json['regionImage'] != null) {
      paths = <Paths>[];
      json['regionImage'].forEach((v) {
        paths.add(new Paths.fromJson(v));
        log('Added an Image');
      });
    } else {
      log('No Images?!!');
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
//    data['location'] = this.location;
    data['ratingAverage'] = this.ratingAverage;
    if (this.comments != null) {
      data['comments'] = this.comments.map((v) => v.toJson()).toList();
    }
    if (this.paths != null) {
      data['paths'] = this.paths.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Paths {
  String path;

  Paths({this.path});

  Paths.fromJson(Map<String, dynamic> json) {
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['path'] = this.path;
    return data;
  }
}
