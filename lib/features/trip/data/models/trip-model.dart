import 'dart:io';
import 'dart:convert';

ShipmentCheckPoint shipmentCheckPointFromJson(String str) => ShipmentCheckPoint.fromJson(json.decode(str));

String shipmentCheckPointToJson(ShipmentCheckPoint data) => json.encode(data.toJson());

class ShipmentCheckPoint  {
  ShipmentCheckPoint({
    this.shipment,
    this.delivery,
    this.checkPoint,
    this.user,
    this.lat,
    this.long,
    this.image,
  });

  String? shipment;
  String? delivery;
  String? checkPoint;
  String? user;
  String? lat;
  String? long;
  List<String>? image;

  ShipmentCheckPoint copyWith({
    String? shipment,
    String? delivery,
    String? checkPoint,
    String? user,
    String? lat,
    String? long,
    List<String>? image,
  }) =>
      ShipmentCheckPoint(
        shipment: shipment ?? this.shipment,
        delivery: delivery ?? this.delivery,
        checkPoint: checkPoint ?? this.checkPoint,
        user: user ?? this.user,
        lat: lat ?? this.lat,
        long: long ?? this.long,
        image: image ?? this.image,
      );

  factory ShipmentCheckPoint.fromJson(Map<String, dynamic> json) => ShipmentCheckPoint(
    shipment: json["shipment"] == null ? null : json["shipment"],
    delivery: json["delivery"] == null ? null : json["delivery"],
    checkPoint: json["checkPoint"] == null ? null : json["checkPoint"],
    user: json["user"] == null ? null : json["user"],
    lat: json["lat"] == null ? null : json["lat"],
    long: json["long"] == null ? null : json["long"],
    image: json["image"] == null ? null : json["image"],
  );

  Map<String, dynamic> toJson() => {
    "shipment": shipment == null ? null : shipment,
    "delivery": delivery == null ? null : delivery,
    "checkPoint": checkPoint == null ? null : checkPoint,
    "user": user == null ? null : user,
    "lat": lat == null ? null : lat,
    "long": long == null ? null : long,
    "image": image == null ? null : image,
  };
}
