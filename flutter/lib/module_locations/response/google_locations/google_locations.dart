class GoogleLocationsResponse {
  List<Features> features;
  String type;

  GoogleLocationsResponse({this.features, this.type});

  GoogleLocationsResponse.fromJson(Map<String, dynamic> json) {
    if (json['features'] != null) {
      features = new List<Features>();
      json['features'].forEach((v) {
        features.add(new Features.fromJson(v));
      });
    }
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.features != null) {
      data['features'] = this.features.map((v) => v.toJson()).toList();
    }
    data['type'] = this.type;
    return data;
  }
}

class Features {
  Geometry geometry;
  String type;
  Properties properties;

  Features({this.geometry, this.type, this.properties});

  Features.fromJson(Map<String, dynamic> json) {
    geometry = json['geometry'] != null
        ? new Geometry.fromJson(json['geometry'])
        : null;
    type = json['type'];
    properties = json['properties'] != null
        ? new Properties.fromJson(json['properties'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.geometry != null) {
      data['geometry'] = this.geometry.toJson();
    }
    data['type'] = this.type;
    if (this.properties != null) {
      data['properties'] = this.properties.toJson();
    }
    return data;
  }
}

class Geometry {
  List<double> coordinates;
  String type;

  Geometry({this.coordinates, this.type});

  Geometry.fromJson(Map<String, dynamic> json) {
    coordinates = json['coordinates'].cast<double>();
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coordinates'] = this.coordinates;
    data['type'] = this.type;
    return data;
  }
}

class Properties {
  int osmId;
  String osmType;
  String country;
  String osmKey;
  String countrycode;
  String osmValue;
  String postcode;
  String name;
  String state;
  String type;
  List<double> extent;
  String city;
  String housenumber;
  String street;
  String district;
  String locality;

  Properties(
      {this.osmId,
      this.osmType,
      this.country,
      this.osmKey,
      this.countrycode,
      this.osmValue,
      this.postcode,
      this.name,
      this.state,
      this.type,
      this.extent,
      this.city,
      this.housenumber,
      this.street,
      this.district,
      this.locality});

  Properties.fromJson(Map<String, dynamic> json) {
    osmId = json['osm_id'];
    osmType = json['osm_type'];
    country = json['country'];
    osmKey = json['osm_key'];
    countrycode = json['countrycode'];
    osmValue = json['osm_value'];
    postcode = json['postcode'];
    name = json['name'];
    state = json['state'];
    type = json['type'];
    extent = json['extent'].cast<double>();
    city = json['city'];
    housenumber = json['housenumber'];
    street = json['street'];
    district = json['district'];
    locality = json['locality'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['osm_id'] = this.osmId;
    data['osm_type'] = this.osmType;
    data['country'] = this.country;
    data['osm_key'] = this.osmKey;
    data['countrycode'] = this.countrycode;
    data['osm_value'] = this.osmValue;
    data['postcode'] = this.postcode;
    data['name'] = this.name;
    data['state'] = this.state;
    data['type'] = this.type;
    data['extent'] = this.extent;
    data['city'] = this.city;
    data['housenumber'] = this.housenumber;
    data['street'] = this.street;
    data['district'] = this.district;
    data['locality'] = this.locality;
    return data;
  }
}
