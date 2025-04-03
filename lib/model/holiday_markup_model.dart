
import 'dart:convert';

List<HolidayMarkUp> holidayMarkUpFromJson(String str) => List<HolidayMarkUp>.from(json.decode(str).map((x) => HolidayMarkUp.fromJson(x)));

String holidayMarkUpToJson(List<HolidayMarkUp> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HolidayMarkUp {
  HolidayMarkUp({
    this.href,
    this.link,
    this.entryid,
    this.unid,
    this.noteid,
    this.position,
    this.siblings,
    this.form,
    this.holidayName,
    this.holidayDate,
    this.recyclingDay,
    this.makeupDay,
    this.notes,
  });

  String? href;
  Link? link;
  String? entryid;
  String? unid;
  String? noteid;
  String? position;
  int? siblings;
  Form? form;
  String? holidayName;
  DateTime? holidayDate;
  DateTime? recyclingDay;
  DateTime? makeupDay;
  String? notes;

  factory HolidayMarkUp.fromJson(Map<String, dynamic> json) => HolidayMarkUp(
    href: json["@href"] == null ? null : json["@href"],
    link: json["@link"] == null ? null : Link.fromJson(json["@link"]),
    entryid: json["@entryid"] == null ? null : json["@entryid"],
    unid: json["@unid"] == null ? null : json["@unid"],
    noteid: json["@noteid"] == null ? null : json["@noteid"],
    position: json["@position"] == null ? null : json["@position"],
    siblings: json["@siblings"] == null ? null : json["@siblings"],
    form: json["@form"] == null ? null : formValues.map[json["@form"]],
    holidayName: json["holidayName"] == null ? null : json["holidayName"],
    holidayDate: json["holidayDate"] == null ? null : DateTime.parse(json["holidayDate"]),
    recyclingDay: json["recyclingDay"] == null ? null : DateTime.parse(json["recyclingDay"]),
    makeupDay: json["makeupDay"] == null ? null : DateTime.parse(json["makeupDay"]),
    notes: json["notes"] == null ? null : json["notes"],
  );

  Map<String, dynamic> toJson() => {
    "@href": href == null ? null : href,
    "@link": link == null ? null : link!.toJson(),
    "@entryid": entryid == null ? null : entryid,
    "@unid": unid == null ? null : unid,
    "@noteid": noteid == null ? null : noteid,
    "@position": position == null ? null : position,
    "@siblings": siblings == null ? null : siblings,
    "@form": form == null ? null : formValues.reverse![form],
    "holidayName": holidayName == null ? null : holidayName,
    "holidayDate": holidayDate == null ? null : holidayDate!.toIso8601String(),
    "recyclingDay": recyclingDay == null ? null : recyclingDay!.toIso8601String(),
    "makeupDay": makeupDay == null ? null : makeupDay!.toIso8601String(),
    "notes": notes == null ? null : notes,
  };
}

enum Form { RECYCLING_HOLIDAYS }

final formValues = EnumValues({
  "RecyclingHolidays": Form.RECYCLING_HOLIDAYS
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
