// To parse this JSON data, do
//
//     final mapDistance = mapDistanceFromJson(jsonString);

import 'dart:convert';

MapDistance mapDistanceFromJson(String str) =>
    MapDistance.fromJson(json.decode(str));

String mapDistanceToJson(MapDistance data) => json.encode(data.toJson());

class MapDistance {
  MapDistance({
    this.status,
    this.originAddresses,
    this.destinationAddresses,
    this.rows,
  });

  String status;
  List<String> originAddresses;
  List<String> destinationAddresses;
  List<Row> rows;

  factory MapDistance.fromJson(Map<String, dynamic> json) => MapDistance(
        status: json["status"],
        originAddresses:
            List<String>.from(json["origin_addresses"].map((x) => x)),
        destinationAddresses:
            List<String>.from(json["destination_addresses"].map((x) => x)),
        rows: List<Row>.from(json["rows"].map((x) => Row.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "origin_addresses": List<dynamic>.from(originAddresses.map((x) => x)),
        "destination_addresses":
            List<dynamic>.from(destinationAddresses.map((x) => x)),
        "rows": List<dynamic>.from(rows.map((x) => x.toJson())),
      };
}

class Row {
  Row({
    this.elements,
  });

  List<Element> elements;

  factory Row.fromJson(Map<String, dynamic> json) => Row(
        elements: List<Element>.from(
            json["elements"].map((x) => Element.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "elements": List<dynamic>.from(elements.map((x) => x.toJson())),
      };
}

class Element {
  Element({
    this.status,
    this.duration,
    this.distance,
  });

  String status;
  Distance duration;
  Distance distance;

  factory Element.fromJson(Map<String, dynamic> json) => Element(
        status: json["status"],
        duration: Distance.fromJson(json["duration"]),
        distance: Distance.fromJson(json["distance"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "duration": duration.toJson(),
        "distance": distance.toJson(),
      };
}

class Distance {
  Distance({
    this.value,
    this.text,
  });

  int value;
  String text;

  factory Distance.fromJson(Map<String, dynamic> json) => Distance(
        value: json["value"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "text": text,
      };
}
