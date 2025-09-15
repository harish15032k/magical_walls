import 'dart:convert';

class VerifyOtpRes {
  bool? status;
  Data? data;
  String? message;

  VerifyOtpRes({
    this.status,
    this.data,
    this.message,
  });

  factory VerifyOtpRes.fromJson(String str) => VerifyOtpRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VerifyOtpRes.fromMap(Map<String, dynamic> json) => VerifyOtpRes(
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
  String? name;
  String? phone;
  String? token;
  int? isKyc;

  Data({
    this.name,
    this.phone,
    this.token,
    this.isKyc,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    name: json["name"],
    phone: json["phone"],
    token: json["token"],
    isKyc: json["is_kyc"],
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "phone": phone,
    "token": token,
    "is_kyc": isKyc,
  };
}
