import 'dart:convert';

List<NotificationModel> notificationFromJson(String str) =>
    List<NotificationModel>.from(
        json.decode(str).map((x) => NotificationModel.fromJson(x)));

String notificationToJson(List<NotificationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotificationModel {
  NotificationModel({
    this.href,
    this.link,
    this.entryid,
    this.unid,
    this.noteid,
    this.position,
    this.siblings,
    this.form,
    this.title,
    this.url,
    this.text,
  });

  String? href;
  Link? link;
  String? entryid;
  String? unid;
  String? noteid;
  String? position;
  int? siblings;
  String? form;
  String? title;
  String? url;
  String? text;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        href: json["@href"] == null ? null : json["@href"],
        link: json["@link"] == null ? null : Link.fromJson(json["@link"]),
        entryid: json["@entryid"] == null ? null : json["@entryid"],
        unid: json["@unid"] == null ? null : json["@unid"],
        noteid: json["@noteid"] == null ? null : json["@noteid"],
        position: json["@position"] == null ? null : json["@position"],
        siblings: json["@siblings"] == null ? null : json["@siblings"],
        form: json["@form"] == null ? null : json["@form"],
        title: json["title"] == null ? null : json["title"],
        url: json["url"] == null ? null : json["url"],
        text: json["text"] == null ? null : json["text"],
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
        "title": title == null ? null : title,
        "url": url == null ? null : url,
        "text": text == null ? null : text,
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
