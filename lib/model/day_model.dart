
import 'dart:convert';

Day dayFromJson(String str) => Day.fromJson(json.decode(str));

String dayToJson(Day data) => json.encode(data.toJson());

class Day {
  Day({
    this.water,
    this.trash,
    this.recycling,
  });

  String? water;
  String? trash;
  String? recycling;

  factory Day.fromJson(Map<String, dynamic> json) => Day(
    water: json["water"] == null ? null : json["water"],
    trash: json["trash"] == null ? null : json["trash"],
    recycling: json["recycling"] == null ? null : json["recycling"],
  );

  Map<String, dynamic> toJson() => {
    "water": water == null ? null : water,
    "trash": trash == null ? null : trash,
    "recycling": recycling == null ? null : recycling,
  };
}
