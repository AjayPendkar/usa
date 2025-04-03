import 'dart:convert';

Trash trashFromJson(String str) => Trash.fromJson(json.decode(str));

String trashToJson(Trash data) => json.encode(data.toJson());

class Trash {
  Trash({
     this.introduction,
     this.additionalInformation,
  });

  Introduction? introduction;
  AdditionalInformation? additionalInformation;

  factory Trash.fromJson(Map<String, dynamic> json)
  {
    return Trash(
      introduction: json["introduction"] == null ? null : Introduction.fromJson(
          json["introduction"]),
      additionalInformation: json["additionalInformation"] == null
          ? null
          : AdditionalInformation.fromJson(json["additionalInformation"]),
    );
  }
  Map<String, dynamic> toJson() => {
    "introduction": introduction == null ? null : introduction?.toJson(),
    "additionalInformation": additionalInformation == null ? null : additionalInformation!.toJson(),
  };
}

class AdditionalInformation {
  AdditionalInformation({
    this.collectionPoint,
    this.setOutTime,
    this.purchaseBags,
    this.householdHazardousWaste,
    this.dropOffCenters,
    this.holidayInformation,
  });

  String? collectionPoint;
  String? setOutTime;
  PurchaseBags? purchaseBags;
  HouseholdHazardousWaste? householdHazardousWaste;
  List<DropOffCenter>? dropOffCenters;
  String? holidayInformation;

  factory AdditionalInformation.fromJson(Map<String, dynamic> json) => AdditionalInformation(
    collectionPoint: json["collectionPoint"] == null ? null : json["collectionPoint"],
    setOutTime: json["setOutTime"] == null ? null : json["setOutTime"],
    purchaseBags: json["purchaseBags"] == null ? null : PurchaseBags.fromJson(json["purchaseBags"]),
    householdHazardousWaste: json["householdHazardousWaste"] == null ? null : HouseholdHazardousWaste.fromJson(json["householdHazardousWaste"]),
    dropOffCenters: json["dropOffCenters"] == null ? null : List<DropOffCenter>.from(json["dropOffCenters"].map((x) => DropOffCenter.fromJson(x))),
    holidayInformation: json["holidayInformation"] == null ? null : json["holidayInformation"],
  );

  Map<String, dynamic> toJson() => {
    "collectionPoint": collectionPoint == null ? null : collectionPoint,
    "setOutTime": setOutTime == null ? null : setOutTime,
    "purchaseBags": purchaseBags == null ? null : purchaseBags!.toJson(),
    "householdHazardousWaste": householdHazardousWaste == null ? null : householdHazardousWaste!.toJson(),
    "dropOffCenters": dropOffCenters == null ? null : List<dynamic>.from(dropOffCenters!.map((x) => x.toJson())),
    "holidayInformation": holidayInformation == null ? null : holidayInformation,
  };
}

class DropOffCenter {
  DropOffCenter({
     this.text,
     this.links,
     this.notes,
  });

  String? text;
  List<LinkElement>? links;
  String? notes;

  factory DropOffCenter.fromJson(Map<String, dynamic> json) => DropOffCenter(
    text: json["text"] == null ? null : json["text"],
    links: json["links"] == null ? null : List<LinkElement>.from(json["links"].map((x) => LinkElement.fromJson(x))),
    notes: json["notes"] == null ? null : json["notes"],
  );

  Map<String, dynamic> toJson() => {
    "text": text == null ? null : text,
    "links": links == null ? null : List<dynamic>.from(links!.map((x) => x.toJson())),
    "notes": notes == null ? null : notes,
  };
}

class LinkElement {
  LinkElement({
     this.location,
     this.address,
     this.city,
     this.firm,
     this.phone,
     this.url,
  });

  String? location;
  String? city;
  String? address;
  String? firm;
  String? phone;
  String? url;

  factory LinkElement.fromJson(Map<String, dynamic> json) => LinkElement(
    location: json["location"] == null ? null : json["location"],
    address: json["address"] == null ? null : json["address"],
    city: json["city"] == null ? null : json["city"],
    firm: json["firm"] == null ? null : json["firm"],
    phone: json["phone"] == null ? null : json["phone"],
    url: json["url"] == null ? null : json["url"],
  );

  Map<String, dynamic> toJson() => {
    "location": location == null ? null : location,
    "address": address == null ? null : address,
    "city": city == null ? null : city,
    "firm": firm == null ? null : firm,
    "phone": phone == null ? null : phone,
    "url": url == null ? null : url,
  };
}

class HouseholdHazardousWaste {
  HouseholdHazardousWaste({
    this.text,
    this.links,
  });

  String? text;
  List<LinkElement>? links;

  factory HouseholdHazardousWaste.fromJson(Map<String, dynamic> json) => HouseholdHazardousWaste(
    text: json["text"] == null ? null : json["text"],
    links: json["links"] == null ? null : List<LinkElement>.from(json["links"].map((x) => LinkElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "text": text == null ? null : text,
    "links": links == null ? null : List<dynamic>.from(links!.map((x) => x.toJson())),
  };
}

class PurchaseBags {
  PurchaseBags({
     this.trashBags,
     this.blueBags,
     this.links,
     this.blueBagsCost,
  });

  Bags? trashBags;
  Bags? blueBags;
  List<LinkElement>? links;
  BlueBagsCost? blueBagsCost;

  factory PurchaseBags.fromJson(Map<String, dynamic> json) => PurchaseBags(
    trashBags: json["trashBags"] == null ? null : Bags.fromJson(json["trashBags"]),
    blueBags: json["blueBags"] == null ? null : Bags.fromJson(json["blueBags"]),
    links: json["links"] == null ? null : List<LinkElement>.from(json["links"].map((x) => LinkElement.fromJson(x))),
    blueBagsCost: json["blueBagsCost"] == null ? null : BlueBagsCost.fromJson(json["blueBagsCost"]),
  );

  Map<String, dynamic> toJson() => {
    "trashBags": trashBags == null ? null : trashBags!.toJson(),
    "blueBags": blueBags == null ? null : blueBags!.toJson(),
    "links": links == null ? null : List<dynamic>.from(links!.map((x) => x.toJson())),
    "blueBagsCost": blueBagsCost == null ? null : blueBagsCost!.toJson(),
  };
}

class Bags {
  Bags({
     this.label,
     this.text,
  });

  String? label;
  String? text;

  factory Bags.fromJson(Map<String, dynamic> json) => Bags(
    label: json["label"] == null ? null : json["label"],
    text: json["text"] == null ? null : json["text"],
  );

  Map<String, dynamic> toJson() => {
    "label": label == null ? null : label,
    "text": text == null ? null : text,
  };
}

class BlueBagsCost {
  BlueBagsCost({
     this.text,
     this.costs,
  });

  String? text;
  List<String>? costs;

  factory BlueBagsCost.fromJson(Map<String, dynamic> json) => BlueBagsCost(
    text: json["text"] == null ? null : json["text"],
    costs: json["costs"] == null ? null : List<String>.from(json["costs"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "text": text == null ? null : text,
    "costs": costs == null ? null : List<dynamic>.from(costs!.map((x) => x)),
  };
}

class Introduction {
  Introduction({
     this.text,
     this.link,
     this.trashDays,
  });

  String? text;
  IntroductionLink? link;
  List<TrashDay>? trashDays;

  factory Introduction.fromJson(Map<String, dynamic> json) => Introduction(
    text: json["text"] == null ? null : json["text"],
    link: json["link"] == null ? null : IntroductionLink.fromJson(json["link"]),
    trashDays: json["trashDays"] == null ? null : List<TrashDay>.from(json["trashDays"].map((x) => TrashDay.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "text": text == null ? null : text,
    "link": link == null ? null : link!.toJson(),
    "trashDays": trashDays == null ? null : List<dynamic>.from(trashDays!.map((x) => x.toJson())),
  };
}

class IntroductionLink {
  IntroductionLink({
    this.text,
    this.url,
  });

  String? text;
  String? url;

  factory IntroductionLink.fromJson(Map<String, dynamic> json) => IntroductionLink(
    text: json["text"] == null ? null : json["text"],
    url: json["url"] == null ? null : json["url"],
  );

  Map<String, dynamic> toJson() => {
    "text": text == null ? null : text,
    "url": url == null ? null : url,
  };
}

class TrashDay {
  TrashDay({
     this.location,
     this.text,
  });

  String? location;
  String? text;

  factory TrashDay.fromJson(Map<String, dynamic> json) => TrashDay(
    location: json["location"] == null ? null : json["location"],
    text: json["text"] == null ? null : json["text"],
  );

  Map<String, dynamic> toJson() => {
    "location": location == null ? null : location,
    "text": text == null ? null : text,
  };
}
