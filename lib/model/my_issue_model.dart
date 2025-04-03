

import 'dart:convert';

List<MyIssue> myIssueFromJson(String str) => List<MyIssue>.from(json.decode(str).map((x) => MyIssue.fromJson(x)));

String myIssueToJson(List<MyIssue> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyIssue {
  MyIssue({
    this.issueId,
    this.issueType,
    this.comments,
    this.issueAddress,
    this.status,
    this.statusDate,
    this.imageUrl,
    this.resolutionDescription,
    this.createdDate,
  });

  String? issueId;
  String? issueType;
  String? comments;
  String? issueAddress;
  String? status;
  String? statusDate;
  String? imageUrl;
  String? resolutionDescription;
  String? createdDate;

  factory MyIssue.fromJson(Map<String, dynamic> json) => MyIssue(
    issueId: json["issueId"] == null ? null : json["issueId"],
    issueType: json["issueType"] == null ? null : json["issueType"],
    comments: json["comments"] == null ? null : json["comments"],
    issueAddress: json["issueAddress"] == null ? null : json["issueAddress"],
    status: json["status"] == null ? null : json["status"],
    statusDate: json["statusDate"] == null ? null : json["statusDate"],
    imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
    resolutionDescription: json["resolutionDescription"] == null ? null : json["resolutionDescription"],
    createdDate: json["createdDate"] == null ? null : json["createdDate"],
  );

  Map<String, dynamic> toJson() => {
    "issueId": issueId == null ? null : issueId,
    "issueType": issueType == null ? null : issueType,
    "comments": comments == null ? null : comments,
    "issueAddress": issueAddress == null ? null : issueAddress,
    "status": status == null ? null : status,
    "statusDate": statusDate == null ? null : statusDate,
    "imageUrl": imageUrl == null ? null : imageUrl,
    "resolutionDescription": resolutionDescription == null ? null : resolutionDescription,
    "createdDate": createdDate == null ? null : createdDate,
  };
}
