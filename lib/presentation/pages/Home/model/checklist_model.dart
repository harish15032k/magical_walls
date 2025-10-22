import 'dart:convert';

class CheckListRes {
  bool? status;
  String? message;
  List<Datum>? data;

  CheckListRes({
    this.status,
    this.message,
    this.data,
  });

  factory CheckListRes.fromJson(String str) => CheckListRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CheckListRes.fromMap(Map<String, dynamic> json) => CheckListRes(
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
  String? status;

  Datum({
    this.id,
    this.name,
    this.status,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    status: json["status"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "status": status,
  };
}
