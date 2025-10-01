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
  Location? location;
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
    location: json["location"] == null ? null : Location.fromMap(json["location"]),
    notifyAt: json["notify_at"] == null ? null : DateTime.parse(json["notify_at"]),
  );

  Map<String, dynamic> toMap() => {
    "type": type,
    "service": service,
    "datetime": datetime,
    "location": location?.toMap(),
    "notify_at": notifyAt?.toIso8601String(),
  };
}

class Location {
  int? id;
  String? city;
  dynamic state;
  dynamic country;
  int? userId;
  String? latitude;
  String? pinCode;
  String? longitude;
  DateTime? createdAt;
  int? isDefault;
  DateTime? updatedAt;
  String? addressLine1;
  dynamic addressLine2;

  Location({
    this.id,
    this.city,
    this.state,
    this.country,
    this.userId,
    this.latitude,
    this.pinCode,
    this.longitude,
    this.createdAt,
    this.isDefault,
    this.updatedAt,
    this.addressLine1,
    this.addressLine2,
  });

  factory Location.fromJson(String str) => Location.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Location.fromMap(Map<String, dynamic> json) => Location(
    id: json["id"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    userId: json["user_id"],
    latitude: json["latitude"],
    pinCode: json["pin_code"],
    longitude: json["longitude"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    isDefault: json["is_default"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    addressLine1: json["address_line1"],
    addressLine2: json["address_line2"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "city": city,
    "state": state,
    "country": country,
    "user_id": userId,
    "latitude": latitude,
    "pin_code": pinCode,
    "longitude": longitude,
    "created_at": createdAt?.toIso8601String(),
    "is_default": isDefault,
    "updated_at": updatedAt?.toIso8601String(),
    "address_line1": addressLine1,
    "address_line2": addressLine2,
  };
}
