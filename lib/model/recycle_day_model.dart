import 'dart:convert';

Recycle recycleFromJson(String str) => Recycle.fromJson(json.decode(str));

String recycleToJson(Recycle data) => json.encode(data.toJson());

class Recycle {
  Recycle({
    this.introduction,
    this.additionalInformation,
  });

  Introduction? introduction;
  AdditionalInformation? additionalInformation;

  factory Recycle.fromJson(Map<String, dynamic> json) {
    return Recycle(
      introduction: json["introduction"] == null
          ? null
          : Introduction.fromJson(json["introduction"]),
      additionalInformation: json["additionalInformation"] == null
          ? null
          : AdditionalInformation.fromJson(json["additionalInformation"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "introduction": introduction == null ? null : introduction?.toJson(),
        "additionalInformation": additionalInformation == null
            ? null
            : additionalInformation!.toJson(),
      };
}

class AdditionalInformation {
  AdditionalInformation({
    this.acceptableMaterials,
    this.purchaseBags,
    this.dropOffCenters,
  });

  AcceptableMaterials? acceptableMaterials;
  PurchaseBags? purchaseBags;
  List<DropOffCenter>? dropOffCenters;

  factory AdditionalInformation.fromJson(Map<String, dynamic> json) =>
      AdditionalInformation(
        acceptableMaterials: json["acceptableMaterials"] == null
            ? null
            : AcceptableMaterials.fromJson(json["acceptableMaterials"]),
        purchaseBags: json["purchaseBags"] == null
            ? null
            : PurchaseBags.fromJson(json["purchaseBags"]),
        dropOffCenters: json["dropOffCenters"] == null
            ? null
            : List<DropOffCenter>.from(
                json["dropOffCenters"].map((x) => DropOffCenter.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "acceptableMaterials":
            acceptableMaterials == null ? null : acceptableMaterials!.toJson(),
        "purchaseBags": purchaseBags == null ? null : purchaseBags!.toJson(),
        "dropOffCenters": dropOffCenters == null
            ? null
            : List<dynamic>.from(dropOffCenters!.map((x) => x.toJson())),
      };
}

class AcceptableMaterials {
  AcceptableMaterials({
    this.text,
    this.materials,
  });

  String? text;
  List<String>? materials;

  factory AcceptableMaterials.fromJson(Map<String, dynamic> json) =>
      AcceptableMaterials(
        text: json["text"] == null ? null : json["text"],
        materials: json["materials"] == null
            ? null
            : List<String>.from(json["materials"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "text": text == null ? null : text,
        "materials": materials == null
            ? null
            : List<dynamic>.from(materials!.map((x) => x)),
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
        links: json["links"] == null
            ? null
            : List<LinkElement>.from(
                json["links"].map((x) => LinkElement.fromJson(x))),
        notes: json["notes"] == null ? null : json["notes"],
      );

  Map<String, dynamic> toJson() => {
        "text": text == null ? null : text,
        "links": links == null
            ? null
            : List<dynamic>.from(links!.map((x) => x.toJson())),
        "notes": notes == null ? null : notes,
      };
}

class LinkElement {
  LinkElement({
    this.location,
    this.address,
    this.city,
    this.phone,
    this.url,
  });

  String? location;
  String? address;
  String? city;
  String? phone;
  String? url;

  factory LinkElement.fromJson(Map<String, dynamic> json) => LinkElement(
        location: json["location"] == null ? null : json["location"],
        address: json["address"] == null ? null : json["address"],
        city: json["city"] == null ? null : json["city"],
        phone: json["phone"] == null ? null : json["phone"],
        url: json["url"] == null ? null : json["url"],
      );

  Map<String, dynamic> toJson() => {
        "location": location == null ? null : location,
        "address": address == null ? null : address,
        "city": city == null ? null : city,
        "phone": phone == null ? null : phone,
        "url": url == null ? null : url,
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
        trashBags:
            json["trashBags"] == null ? null : Bags.fromJson(json["trashBags"]),
        blueBags:
            json["blueBags"] == null ? null : Bags.fromJson(json["blueBags"]),
        links: json["links"] == null
            ? null
            : List<LinkElement>.from(
                json["links"].map((x) => LinkElement.fromJson(x))),
        blueBagsCost: json["blueBagsCost"] == null
            ? null
            : BlueBagsCost.fromJson(json["blueBagsCost"]),
      );

  Map<String, dynamic> toJson() => {
        "trashBags": trashBags == null ? null : trashBags!.toJson(),
        "blueBags": blueBags == null ? null : blueBags!.toJson(),
        "links": links == null
            ? null
            : List<dynamic>.from(links!.map((x) => x.toJson())),
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
        costs: json["costs"] == null
            ? null
            : List<String>.from(json["costs"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "text": text == null ? null : text,
        "costs":
            costs == null ? null : List<dynamic>.from(costs!.map((x) => x)),
      };
}

class Introduction {
  Introduction({
    this.text,
    this.link,
  });

  String? text;
  IntroductionLink? link;

  factory Introduction.fromJson(Map<String, dynamic> json) => Introduction(
        text: json["text"] == null ? null : json["text"],
        link: json["link"] == null
            ? null
            : IntroductionLink.fromJson(json["link"]),
      );

  Map<String, dynamic> toJson() => {
        "text": text == null ? null : text,
        "link": link == null ? null : link!.toJson(),
      };
}

class IntroductionLink {
  IntroductionLink({
    this.text,
    this.url,
  });

  String? text;
  String? url;

  factory IntroductionLink.fromJson(Map<String, dynamic> json) =>
      IntroductionLink(
        text: json["text"] == null ? null : json["text"],
        url: json["url"] == null ? null : json["url"],
      );

  Map<String, dynamic> toJson() => {
        "text": text == null ? null : text,
        "url": url == null ? null : url,
      };
}
