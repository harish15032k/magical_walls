import 'dart:convert';

class GetOtpRes {
  bool? status;
  Data? data;
  String? message;

  GetOtpRes({
    this.status,
    this.data,
    this.message,
  });

  factory GetOtpRes.fromJson(String str) => GetOtpRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetOtpRes.fromMap(Map<String, dynamic> json) => GetOtpRes(
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
  Data();

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
  );

  Map<String, dynamic> toMap() => {
  };
}