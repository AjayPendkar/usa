// To parse this JSON data, do
//
//     final address = addressFromJson(jsonString);

import 'dart:convert';

List<Address> addressFromJson(String str) =>
    List<Address>.from(json.decode(str).map((x) => Address.fromJson(x)));

String addressToJson(List<Address> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Address {
  Address({
    this.href,
    this.link,
    this.entryid,
    this.unid,
    this.noteid,
    this.position,
    this.siblings,
    this.fullStreetAddress,
    this.landLocationId,
    this.utilityId,
    this.taxOwnerName,
    this.confidential,
    this.sectionCode,
    this.score,
    this.type,
  });

  String? href;
  Link? link;
  String? entryid;
  String? unid;
  String? noteid;
  String? position;
  int? siblings;
  String? fullStreetAddress;
  String? landLocationId;
  String? utilityId;
  String? taxOwnerName;
  Confidential? confidential;
  SectionCode? sectionCode;
  int? score;
  var type;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        href: json["@href"] == null ? null : json["@href"],
        link: json["@link"] == null ? null : Link.fromJson(json["@link"]),
        entryid: json["@entryid"] == null ? null : json["@entryid"],
        unid: json["@unid"] == null ? null : json["@unid"],
        noteid: json["@noteid"] == null ? null : json["@noteid"],
        position: json["@position"] == null ? null : json["@position"],
        siblings: json["@siblings"] == null ? null : json["@siblings"],
        fullStreetAddress: json["FullStreetAddress"] == null
            ? null
            : json["FullStreetAddress"],
        landLocationId:
            json["LandLocationID"] == null ? null : json["LandLocationID"],
        utilityId: json["UtilityID"] == null ? null : json["UtilityID"],
        taxOwnerName:
            json["TaxOwnerName"] == null ? null : json["TaxOwnerName"],
        confidential: json["Confidential"] == null
            ? null
            : confidentialValues.map[json["Confidential"]],
        sectionCode: json["SectionCode"] == null
            ? null
            : sectionCodeValues.map[json["SectionCode"]],
        score: json["@score"] == null ? null : json["@score"],
        type: json["type"] == null ? null : json["type"],
      );

  Map<String, dynamic> toJson() => {
        "@href": href == null ? null : href,
        "@link": link == null ? null : link!.toJson(),
        "@entryid": entryid == null ? null : entryid,
        "@unid": unid == null ? null : unid,
        "@noteid": noteid == null ? null : noteid,
        "@position": position == null ? null : position,
        "@siblings": siblings == null ? null : siblings,
        "FullStreetAddress":
            fullStreetAddress == null ? null : fullStreetAddress,
        "LandLocationID": landLocationId == null ? null : landLocationId,
        "UtilityID": utilityId == null ? null : utilityId,
        "TaxOwnerName": taxOwnerName == null ? null : taxOwnerName,
        "Confidential": confidential == null
            ? null
            : confidentialValues.reverse![confidential],
        "SectionCode": sectionCode == null
            ? null
            : sectionCodeValues.reverse![sectionCode],
        "@score": score == null ? null : score,
      };
}

enum Confidential { Y }

final confidentialValues = EnumValues({"Y": Confidential.Y});

enum Add { LAND }

final foValues = EnumValues({"Land": Add.LAND});

class Link {
  Link({
    this.rel,
    this.href,
  });

  Rel? rel;
  String? href;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        rel: json["rel"] == null ? null : relValues.map[json["rel"]],
        href: json["href"] == null ? null : json["href"],
      );

  Map<String, dynamic> toJson() => {
        "rel": rel == null ? null : relValues.reverse![rel],
        "href": href == null ? null : href,
      };
}

enum Rel { DOCUMENT }

final relValues = EnumValues({"document": Rel.DOCUMENT});

enum SectionCode { NW, SE }

final sectionCodeValues =
    EnumValues({"NW": SectionCode.NW, "SE": SectionCode.SE});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
