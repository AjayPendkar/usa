
import 'dart:convert';

PlaceMap placeMapFromJson(String str) => PlaceMap.fromJson(json.decode(str));

String placeMapToJson(PlaceMap data) => json.encode(data.toJson());

class PlaceMap {
  PlaceMap({
    this.address,
    this.location,
  });

  Address? address;
  Location? location;

  factory PlaceMap.fromJson(Map<String, dynamic> json) => PlaceMap(
    address: json["address"] == null ? null : Address.fromJson(json["address"]),
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
  );

  Map<String, dynamic> toJson() => {
    "address": address == null ? null : address!.toJson(),
    "location": location == null ? null : location!.toJson(),
  };
}

class Address {
  Address({
    this.street,
    this.city,
    this.zip,
    this.locName,
  });

  String? street;
  String? city;
  String? zip;
  String? locName;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    street: json["Street"] == null ? null : json["Street"] ,
    city: json["City"] == null ? null : json["City"],
    zip: json["ZIP"] == null ? null : json["ZIP"],
    locName: json["Loc_name"] == null ? null : json["Loc_name"],
  );

  Map<String, dynamic> toJson() => {
    "Street": street == null ? null : street,
    "City": city == null ? null : city,
    "ZIP": zip == null ? null : zip,
    "Loc_name": locName == null ? null : locName,
  };
}

class Location {
  Location({
    this.x,
    this.y,
    this.spatialReference,
  });

  double? x;
  double? y;
  SpatialReference? spatialReference;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    x: json["x"] == null ? null : json["x"].toDouble(),
    y: json["y"] == null ? null : json["y"].toDouble(),
    spatialReference: json["spatialReference"] == null ? null : SpatialReference.fromJson(json["spatialReference"]),
  );

  Map<String, dynamic> toJson() => {
    "x": x == null ? null : x,
    "y": y == null ? null : y,
    "spatialReference": spatialReference == null ? null : spatialReference!.toJson(),
  };
}

class SpatialReference {
  SpatialReference({
    this.wkid,
    this.latestWkid,
  });

  int? wkid;
  int? latestWkid;

  factory SpatialReference.fromJson(Map<String, dynamic> json) => SpatialReference(
    wkid: json["wkid"] == null ? null : json["wkid"],
    latestWkid: json["latestWkid"] == null ? null : json["latestWkid"],
  );

  Map<String, dynamic> toJson() => {
    "wkid": wkid == null ? null : wkid,
    "latestWkid": latestWkid == null ? null : latestWkid,
  };
}
