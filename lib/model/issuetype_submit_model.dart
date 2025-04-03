import 'dart:convert';

IssueSubmit issueSubmitFromJson(String str) =>
    IssueSubmit.fromJson(json.decode(str));

String issueSubmitToJson(IssueSubmit data) => json.encode(data.toJson());

class IssueSubmit {
  IssueSubmit({
    this.comments,
    this.email,
    this.issueAddress,
    this.issueType,
    this.issueUnid,
    this.issueLocationX,
    this.issueLocationY,
    this.name,
    this.phone,
    this.testPhoto,
  });

  String? comments;
  String? email;
  String? issueAddress;
  String? issueType;
  String? issueUnid;
  String? issueLocationX;
  String? issueLocationY;
  String? name;
  String? phone;
  TestPhoto? testPhoto;

  factory IssueSubmit.fromJson(Map<String, dynamic> json) => IssueSubmit(
        comments: json["comments"] == null ? null : json["comments"],
        email: json["email"] == null ? null : json["email"],
        issueAddress:
            json["issueAddress"] == null ? null : json["issueAddress"],
        issueType: json["issueType"] == null ? null : json["issueType"],
        issueUnid: json["issueUNID"] == null ? null : json["issueUNID"],
        issueLocationX:
            json["issueLocationX"] == null ? null : json["issueLocationX"],
        issueLocationY:
            json["issueLocationY"] == null ? null : json["issueLocationY"],
        name: json["name"] == null ? null : json["name"],
        phone: json["phone"] == null ? null : json["phone"],
        testPhoto: json["testPhoto"] == null
            ? null
            : TestPhoto.fromJson(json["testPhoto"]),
      );

  Map<String, dynamic> toJson() => {
        "comments": comments == null ? "" : comments,
        "email": email == null ? null : email,
        "issueAddress": issueAddress == null ? null : issueAddress,
        "issueType": issueType == null ? null : issueType,
        "issueUNID": issueUnid == null ? null : issueUnid,
        "issueLocationX": issueLocationX == null ? null : issueLocationX,
        "issueLocationY": issueLocationY == null ? null : issueLocationY,
        "name": name == null ? null : name,
        "phone": phone == null ? null : phone,
        "testPhoto": testPhoto == null ? null : testPhoto!.toJson(),
      };

  Map<String, dynamic> toJsonimage() => {
        "comments": comments == null ? "" : comments,
        "email": email == null ? null : email,
        "issueAddress": issueAddress == null ? null : issueAddress,
        "issueType": issueType == null ? null : issueType,
        "issueUNID": issueUnid == null ? null : issueUnid,
        "issueLocationX": issueLocationX == null ? null : issueLocationX,
        "issueLocationY": issueLocationY == null ? null : issueLocationY,
        "name": name == null ? null : name,
        "phone": phone == null ? null : phone,
        //"testPhoto": testPhoto == null ? null : testPhoto!.toJson(),
      };
}

class TestPhoto {
  TestPhoto({
    this.type,
    this.content,
  });

  String? type;
  List<Content>? content;

  factory TestPhoto.fromJson(Map<String, dynamic> json) => TestPhoto(
        type: json["type"] == null ? null : json["type"],
        content: json["content"] == null
            ? null
            : List<Content>.from(
                json["content"].map((x) => Content.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "content": content == null
            ? null
            : List<dynamic>.from(content!.map((x) => x.toJson())),
      };
}

class Content {
  Content({
    this.contentType,
    this.contentDisposition,
    this.contentTransferEncoding,
    this.data,
    this.boundary,
  });

  String? contentType;
  String? contentDisposition;
  String? contentTransferEncoding;
  String? data;
  String? boundary;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        contentType: json["contentType"] == null ? null : json["contentType"],
        contentDisposition: json["contentDisposition"] == null
            ? null
            : json["contentDisposition"],
        contentTransferEncoding: json["contentTransferEncoding"] == null
            ? null
            : json["contentTransferEncoding"],
        data: json["data"] == null ? null : json["data"],
        boundary: json["boundary"] == null ? null : json["boundary"],
      );

  Map<String, dynamic> toJson() => {
        "contentType": contentType == null ? null : contentType,
        "contentDisposition":
            contentDisposition == null ? null : contentDisposition,
        "contentTransferEncoding":
            contentTransferEncoding == null ? null : contentTransferEncoding,
        "data": data == null ? null : data,
        "boundary": boundary == null ? null : boundary,
      };
}
