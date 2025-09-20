import 'dart:convert';

class BarChartRes {
  bool? status;
  List<Datum>? data;
  String? message;

  BarChartRes({
    this.status,
    this.data,
    this.message,
  });

  factory BarChartRes.fromJson(String str) => BarChartRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BarChartRes.fromMap(Map<String, dynamic> json) => BarChartRes(
    status: json["status"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    "message": message,
  };
}

class Datum {
  DateTime? date;
  String? day;
  int? amount;

  Datum({
    this.date,
    this.day,
    this.amount,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    day: json["day"],
    amount: json["amount"],
  );

  Map<String, dynamic> toMap() => {
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "day": day,
    "amount": amount,
  };
}
