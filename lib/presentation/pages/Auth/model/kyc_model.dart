import 'dart:convert';

class KycRes {
  bool? status;
  Data? data;
  dynamic message; // dynamic to handle String or Map

  KycRes({
    this.status,
    this.data,
    this.message,
  });

  // Updated fromJson to accept Map<String, dynamic>
  factory KycRes.fromJson(Map<String, dynamic> json) => KycRes.fromMap(json);

  // toJson still encodes to String
  String toJson() => json.encode(toMap());

  factory KycRes.fromMap(Map<String, dynamic> json) => KycRes(
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
  dynamic technicianName;
  String? kycStatus;

  Data({
    this.technicianName,
    this.kycStatus,
  });

  // Updated fromJson to accept Map<String, dynamic>
  factory Data.fromJson(Map<String, dynamic> json) => Data.fromMap(json);

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    technicianName: json["technician_name"],
    kycStatus: json["kyc_status"],
  );

  Map<String, dynamic> toMap() => {
    "technician_name": technicianName,
    "kyc_status": kycStatus,
  };
}