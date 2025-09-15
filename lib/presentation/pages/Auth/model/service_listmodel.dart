import 'dart:convert';

class ServiceListRes {
  bool? status;
  String? message;
  List<Datum>? data;

  ServiceListRes({
    this.status,
    this.message,
    this.data,
  });

  factory ServiceListRes.fromJson(String str) => ServiceListRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ServiceListRes.fromMap(Map<String, dynamic> json) => ServiceListRes(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class Datum {
  int? id;
  String? name;

  Datum({
    this.id,
    this.name,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
  };
}
