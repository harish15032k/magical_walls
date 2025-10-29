import 'dart:convert';

class NotiRes {
  bool? status;
  String? message;
  List<Datum>? data;

  NotiRes({
    this.status,
    this.message,
    this.data,
  });

  factory NotiRes.fromJson(String str) => NotiRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NotiRes.fromMap(Map<String, dynamic> json) => NotiRes(
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
  String? title;
  int? bookId;
  int? fromUserId;
  int? toUserId;
  String? fcmToken;
  String? message;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  Data? data;

  Datum({
    this.id,
    this.title,
    this.bookId,
    this.fromUserId,
    this.toUserId,
    this.fcmToken,
    this.message,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.data,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    bookId: json["bookId"],
    fromUserId: json["fromUserId"],
    toUserId: json["toUserId"],
    fcmToken: json["fcmToken"],
    message: json["message"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    data: json["data"] == null ? null : Data.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "bookId": bookId,
    "fromUserId": fromUserId,
    "toUserId": toUserId,
    "fcmToken": fcmToken,
    "message": message,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "data": data?.toMap(),
  };
}

class Data {
  String? type;
  String? service;
  String? datetime;
  String? location;
  DateTime? notifyAt;

  Data({
    this.type,
    this.service,
    this.datetime,
    this.location,
    this.notifyAt,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    type: json["type"],
    service: json["service"],
    datetime: json["datetime"],
    location: json["location"],
    notifyAt: json["notify_at"] == null ? null : DateTime.parse(json["notify_at"]),
  );

  Map<String, dynamic> toMap() => {
    "type": type,
    "service": service,
    "datetime": datetime,
    "location": location,
    "notify_at": notifyAt?.toIso8601String(),
  };
}


