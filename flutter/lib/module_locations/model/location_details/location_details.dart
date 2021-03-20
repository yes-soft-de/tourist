import 'dart:developer';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tourists/module_comment/response/comment/comment_response.dart';

class LocationDetailsModel {
  int id;
  String name;
  String description;
  LatLng locationJson;

//  String location;
  List<CommentModel> comments;
  int ratingAverage;
  List<DetailsImagePaths> paths;
  String locationId;

  LocationDetailsModel(
      {this.id,
      this.name,
      this.description,
//      this.location,
      this.comments,
      this.locationId,
      this.ratingAverage,
      this.locationJson,
      this.paths});

  LocationDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    locationId = json['placeId'];
//    location = json['location'];
    ratingAverage = json['ratingAverage'];
    if (json['comments'] != null) {
      comments = <CommentModel>[];
      json['comments'].forEach((v) {
        comments.add(new CommentModel.fromJson(v));
      });
    }
    if (json['regionImage'] != null) {
      paths = <DetailsImagePaths>[];
      json['regionImage'].forEach((v) {
        paths.add(new DetailsImagePaths.fromJson(v));
        log('Added an Image');
      });
    } else {
      log('No Images?!!');
    }
  }
}

class DetailsImagePaths {
  String path;

  DetailsImagePaths({this.path});

  DetailsImagePaths.fromJson(Map<String, dynamic> json) {
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['path'] = this.path;
    return data;
  }
}
