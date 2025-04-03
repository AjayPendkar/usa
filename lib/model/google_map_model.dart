import 'dart:convert';

Address addressFromJson(String str) => Address.fromJson(json.decode(str));

String addressToJson(Address data) => json.encode(data.toJson());

class Address {
  Address({
    this.spatialReference,
    this.candidates,
  });

  SpatialReference? spatialReference;
  List<Candidate>? candidates;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    spatialReference: json["spatialReference"] == null ? null : SpatialReference.fromJson(json["spatialReference"]),
    candidates: json["candidates"] == null ? null : List<Candidate>.from(json["candidates"].map((x) => Candidate.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "spatialReference": spatialReference == null ? null : spatialReference!.toJson(),
    "candidates": candidates == null ? null : List<dynamic>.from(candidates!.map((x) => x.toJson())),
  };
}

class Candidate {
  Candidate({
    this.address,
    this.location,
    this.score,
    this.attributes,
  });

  String? address;
  LocationAddress? location;
  double? score;
  Attributes? attributes;

  factory Candidate.fromJson(Map<String, dynamic> json) => Candidate(
    address: json["address"] == null ? null : json["address"],
    location: json["location"] == null ? null : LocationAddress.fromJson(json["location"]),
    score: json["score"] == null ? null : json["score"].toDouble(),
    attributes: json["attributes"] == null ? null : Attributes.fromJson(json["attributes"]),
  );

  Map<String, dynamic> toJson() => {
    "address": address == null ? null : address,
    "location": location == null ? null : location!.toJson(),
    "score": score == null ? null : score,
    "attributes": attributes == null ? null : attributes!.toJson(),
  };
}

class Attributes {
  Attributes();

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
  );

  Map<String, dynamic> toJson() => {
  };
}

class LocationAddress {
  LocationAddress({
    this.x,
    this.y,
  });

  double? x;
  double? y;

  factory LocationAddress.fromJson(Map<String, dynamic> json) => LocationAddress(
    x: json["x"] == null ? null : json["x"].toDouble(),
    y: json["y"] == null ? null : json["y"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "x": x == null ? null : x,
    "y": y == null ? null : y,
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


