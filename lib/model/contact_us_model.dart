
import 'dart:convert';

List<Contact> contactFromJson(String str) => List<Contact>.from(json.decode(str).map((x) => Contact.fromJson(x)));

String contactToJson(List<Contact> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Contact {
  Contact({
    this.href,
    this.link,
    this.entryid,
    this.unid,
    this.noteid,
    this.position,
    this.siblings,
    this.form,
    this.department,
    this.phoneNumber,
    this.email,
    this.faxNumber,
    this.website,
  });

  String? href;
  Link? link;
  String? entryid;
  String? unid;
  String? noteid;
  String? position;
  int? siblings;
  Form? form;
  String? department;
  String? phoneNumber;
  String? email;
  String? faxNumber;
  String? website;

  factory Contact.fromJson( Map<String, dynamic> json) => Contact(
    href: json["@href"] == null ? null : json["@href"],
    link: json["@link"] == null ? null : Link.fromJson(json["@link"]),
    entryid: json["@entryid"] == null ? null : json["@entryid"],
    unid: json["@unid"] == null ? null : json["@unid"],
    noteid: json["@noteid"] == null ? null : json["@noteid"],
    position: json["@position"] == null ? null : json["@position"],
    siblings: json["@siblings"] == null ? null : json["@siblings"],
    form: json["@form"] == null ? null : formValues.map[json["@form"]],
    department: json["department"] == null ? null : json["department"],
    phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
    email: json["email"] == null ? null : json["email"],
    faxNumber: json["faxNumber"] == null ? null : json["faxNumber"],
    website: json["website"] == null ? null : json["website"],
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
    "department": department == null ? null : department,
    "phoneNumber": phoneNumber == null ? null : phoneNumber,
    "email": email == null ? null : email,
    "faxNumber": faxNumber == null ? null : faxNumber,
    "website": website == null ? null : website,
  };
}

enum Form { MY_RICHARDSON_CONTACT }

final formValues = EnumValues({
  "MyRichardsonContact": Form.MY_RICHARDSON_CONTACT
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

  EnumValues(this.map,);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}

