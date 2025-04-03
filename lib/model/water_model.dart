import 'dart:convert';

List<Water> waterFromJson(String str) => List<Water>.from(json.decode(str).map((x) => Water.fromJson(x)));

String waterToJson(List<Water> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Water {
  Water({
    this.href,
    this.link,
    this.entryid,
    this.unid,
    this.noteid,
    this.position,
    this.siblings,
    this.form,
    this.stage,
    this.implementedText,
    this.oddWateringDays,
    this.oddWateringDaysText,
    this.evenWateringDays,
    this.evenWateringDaysText,
    this.wateringDaysText,
    this.additionalRestrictions,
    this.exemptions,
    this.variances,
  });

  String? href;
  Link? link;
  String? entryid;
  String? unid;
  String? noteid;
  String? position;
  int? siblings;
  String? form;
  String? stage;
  String? implementedText;
  List<String>? oddWateringDays;
  String? oddWateringDaysText;
  List<String>? evenWateringDays;
  String? evenWateringDaysText;
  String? wateringDaysText;
  List<String>? additionalRestrictions;
  List<String>? exemptions;
  List<String>? variances;

  factory Water.fromJson(Map<String, dynamic> json) => Water(
    href: json["@href"] == null ? null : json["@href"],
    link: json["@link"] == null ? null : Link.fromJson(json["@link"]),
    entryid: json["@entryid"] == null ? null : json["@entryid"],
    unid: json["@unid"] == null ? null : json["@unid"],
    noteid: json["@noteid"] == null ? null : json["@noteid"],
    position: json["@position"] == null ? null : json["@position"],
    siblings: json["@siblings"] == null ? null : json["@siblings"],
    form: json["@form"] == null ? null : json["@form"],
    stage: json["stage"] == null ? null : json["stage"],
    implementedText: json["implementedText"] == null ? null : json["implementedText"],
    oddWateringDays: json["oddWateringDays"] == null ? null : List<String>.from(json["oddWateringDays"].map((x) => x)),
    oddWateringDaysText: json["oddWateringDaysText"] == null ? null : json["oddWateringDaysText"],
    evenWateringDays: json["evenWateringDays"] == null ? null : List<String>.from(json["evenWateringDays"].map((x) => x)),
    evenWateringDaysText: json["evenWateringDaysText"] == null ? null : json["evenWateringDaysText"],
    wateringDaysText: json["wateringDaysText"] == null ? null : json["wateringDaysText"],
    additionalRestrictions: json["additionalRestrictions"] == null ? null : List<String>.from(json["additionalRestrictions"].map((x) => x)),
    exemptions: json["exemptions"] == null ? null : List<String>.from(json["exemptions"].map((x) => x)),
    variances: json["variances"] == null ? null : List<String>.from(json["variances"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "@href": href == null ? null : href,
    "@link": link == null ? null : link!.toJson(),
    "@entryid": entryid == null ? null : entryid,
    "@unid": unid == null ? null : unid,
    "@noteid": noteid == null ? null : noteid,
    "@position": position == null ? null : position,
    "@siblings": siblings == null ? null : siblings,
    "@form": form == null ? null : form,
    "stage": stage == null ? null : stage,
    "implementedText": implementedText == null ? null : implementedText,
    "oddWateringDays": oddWateringDays == null ? null : List<dynamic>.from(oddWateringDays!.map((x) => x)),
    "oddWateringDaysText": oddWateringDaysText == null ? null : oddWateringDaysText,
    "evenWateringDays": evenWateringDays == null ? null : List<dynamic>.from(evenWateringDays!.map((x) => x)),
    "evenWateringDaysText": evenWateringDaysText == null ? null : evenWateringDaysText,
    "wateringDaysText": wateringDaysText == null ? null : wateringDaysText,
    "additionalRestrictions": additionalRestrictions == null ? null : List<dynamic>.from(additionalRestrictions!.map((x) => x)),
    "exemptions": exemptions == null ? null : List<dynamic>.from(exemptions!.map((x) => x)),
    "variances": variances == null ? null : List<dynamic>.from(variances!.map((x) => x)),
  };
}

class Link {
  Link({
    this.rel,
    this.href,
  });

  String? rel;
  String? href;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    rel: json["rel"] == null ? null : json["rel"],
    href: json["href"] == null ? null : json["href"],
  );

  Map<String, dynamic> toJson() => {
    "rel": rel == null ? null : rel,
    "href": href == null ? null : href,
  };
}
