

import 'dart:convert';

List<IssueType> issueTypeFromJson(String str) => List<IssueType>.from(json.decode(str).map((x) => IssueType.fromJson(x)));

String issueTypeToJson(List<IssueType> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class IssueType {
  IssueType({
    this.href,
    this.link,
    this.entryid,
    this.unid,
    this.noteid,
    this.position,
    this.siblings,
    this.departmentName,
    this.issueType,
    this.issueDescription,
    this.issueUnid,
    this.cityworksIssue,
    this.cityworksProblemSid,
    this.promptUrl,
    this.promptMessage,
    this.issueCount,
  });

  String? href;
  Link? link;
  String? entryid;
  String? unid;
  String? noteid;
  String? position;
  int? siblings;
  String? departmentName;
  String? issueType;
  String? issueDescription;
  String? issueUnid;
  String? cityworksIssue;
  String? cityworksProblemSid;
  String? promptUrl;
  String? promptMessage;
  int? issueCount;

  factory IssueType.fromJson(Map<String, dynamic> json) => IssueType(
    href: json["@href"] == null ? null : json["@href"],
    link: json["@link"] == null ? null : Link.fromJson(json["@link"]),
    entryid: json["@entryid"] == null ? null : json["@entryid"],
    unid: json["@unid"] == null ? null : json["@unid"],
    noteid: json["@noteid"] == null ? null : json["@noteid"],
    position: json["@position"] == null ? null : json["@position"],
    siblings: json["@siblings"] == null ? null : json["@siblings"],
    departmentName: json["departmentName"] == null ? null : json["departmentName"],
    issueType: json["issueType"] == null ? null : json["issueType"],
    issueDescription: json["issueDescription"] == null ? null : json["issueDescription"],
    issueUnid: json["issueUNID"] == null ? null : json["issueUNID"],
    cityworksIssue: json["cityworksIssue"] == null ? null : json["cityworksIssue"],
    cityworksProblemSid: json["cityworksProblemSid"] == null ? null : json["cityworksProblemSid"],
    promptUrl: json["promptURL"] == null ? null : json["promptURL"],
    promptMessage: json["promptMessage"] == null ? null : json["promptMessage"],
    issueCount: json["issueCount"] == null ? null : json["issueCount"],
  );

  Map<String, dynamic> toJson() => {
    "@href": href == null ? null : href,
    "@link": link == null ? null : link!.toJson(),
    "@entryid": entryid == null ? null : entryid,
    "@unid": unid == null ? null : unid,
    "@noteid": noteid == null ? null : noteid,
    "@position": position == null ? null : position,
    "@siblings": siblings == null ? null : siblings,
    "departmentName": departmentName == null ? null : departmentName,
    "issueType": issueType == null ? null : issueType,
    "issueDescription": issueDescription == null ? null : issueDescription,
    "issueUNID": issueUnid == null ? null : issueUnid,
    "cityworksIssue": cityworksIssue == null ? null : cityworksIssue,
    "cityworksProblemSid": cityworksProblemSid == null ? null : cityworksProblemSid,
    "promptURL": promptUrl == null ? null : promptUrl,
    "promptMessage": promptMessage == null ? null : promptMessage,
    "issueCount": issueCount == null ? null : issueCount,
  };
}

enum Issue { ISSUES }

final issueValues = EnumValues({
  "Issues": Issue.ISSUES
});

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

final relValues = EnumValues({
  "document": Rel.DOCUMENT
});

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
