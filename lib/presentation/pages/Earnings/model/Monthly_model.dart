import 'dart:convert';

class EarningRes {
  bool? status;
  Data? data;
  String? message;

  EarningRes({
    this.status,
    this.data,
    this.message,
  });

  factory EarningRes.fromJson(String str) => EarningRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EarningRes.fromMap(Map<String, dynamic> json) => EarningRes(
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
  String? totalEarnings;
  int? totalPendingAmount;
  int? completedCount;
  List<CompletedServicesPaid>? completedServicesPaid;

  Data({
    this.totalEarnings,
    this.totalPendingAmount,
    this.completedCount,
    this.completedServicesPaid,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    totalEarnings: json["total_earnings"],
    totalPendingAmount: json["total_pending_amount"],
    completedCount: json["completed_count"],
    completedServicesPaid: json["completed_services_paid"] == null ? [] : List<CompletedServicesPaid>.from(json["completed_services_paid"]!.map((x) => CompletedServicesPaid.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "total_earnings": totalEarnings,
    "total_pending_amount": totalPendingAmount,
    "completed_count": completedCount,
    "completed_services_paid": completedServicesPaid == null ? [] : List<dynamic>.from(completedServicesPaid!.map((x) => x.toMap())),
  };
}

class CompletedServicesPaid {
  int? id;
  int? serviceId;
  String? price;
  String? paidStatus;
  dynamic paidAt;
  String? status;
  Service? service;

  CompletedServicesPaid({
    this.id,
    this.serviceId,
    this.price,
    this.paidStatus,
    this.paidAt,
    this.status,
    this.service,
  });

  factory CompletedServicesPaid.fromJson(String str) => CompletedServicesPaid.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CompletedServicesPaid.fromMap(Map<String, dynamic> json) => CompletedServicesPaid(
    id: json["id"],
    serviceId: json["service_id"],
    price: json["price"],
    paidStatus: json["paid_status"],
    paidAt: json["paid_at"],
    status: json["status"],
    service: json["service"] == null ? null : Service.fromMap(json["service"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "service_id": serviceId,
    "price": price,
    "paid_status": paidStatus,
    "paid_at": paidAt,
    "status": status,
    "service": service?.toMap(),
  };
}

class Service {
  int? id;
  String? name;

  Service({
    this.id,
    this.name,
  });

  factory Service.fromJson(String str) => Service.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Service.fromMap(Map<String, dynamic> json) => Service(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
  };
}
