import 'dart:convert';

class LocationRes {
  bool? status;
  Data? data;
  String? message;

  LocationRes({
    this.status,
    this.data,
    this.message,
  });

  factory LocationRes.fromJson(String str) => LocationRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LocationRes.fromMap(Map<String, dynamic> json) => LocationRes(
    status: json["status"],
    data: json["data"] == null ? null : Data.fromMap(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "data": data?.toMap(),
    "message": message,
  };
}

class Data {
  int? id;
  String? name;
  String? latitude;
  String? longitude;

  Data({
    this.id,
    this.name,
    this.latitude,
    this.longitude,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    latitude: json["latitude"],
    longitude: json["longitude"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "latitude": latitude,
    "longitude": longitude,
  };
}
