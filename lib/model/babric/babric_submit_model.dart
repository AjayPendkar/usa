import 'dart:convert';

List<Babic> babicFromJson(String str) =>
    List<Babic>.from(json.decode(str).map((x) => Babic.fromJson(x)));

String babicToJson(List<Babic> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Babic {
  Babic({
    this.orderNumber,
    this.pickupDate,
    this.pickupAddress,
  });

  String? orderNumber;
  String? pickupDate;
  String? pickupAddress;

  factory Babic.fromJson(Map<String, dynamic> json) => Babic(
    orderNumber: json["orderNumber"] == null ? null : json["orderNumber"],
    pickupDate: json["pickupDate"] == null ? null : json["pickupDate"],
    pickupAddress:
    json["pickupAddress"] == null ? null : json["pickupAddress"],
  );

  Map<String, dynamic> toJson() => {
    "orderNumber": orderNumber == null ? null : orderNumber,
    "pickupDate": pickupDate == null ? null : pickupDate,
    "pickupAddress": pickupAddress == null ? null : pickupAddress,
  };
}
