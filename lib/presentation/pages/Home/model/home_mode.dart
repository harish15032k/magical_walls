import 'dart:convert';

class OrderUpcomingRes {
  bool? status;
  String? filter;
  List<Datum>? data;
  String? message;

  OrderUpcomingRes({
    this.status,
    this.filter,
    this.data,
    this.message,
  });

  factory OrderUpcomingRes.fromJson(String str) => OrderUpcomingRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrderUpcomingRes.fromMap(Map<String, dynamic> json) => OrderUpcomingRes(
    status: json["status"],
    filter: json["filter"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "filter": filter,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    "message": message,
  };
}

class Datum {
  int? bookingId;
  String? serviceType;
  String? bookingDate;
  dynamic startTime;
  dynamic endTime;
  String? timeSlot;
  String? duration;
  String? customerName;
  String? customerPhoneNumber;
  Address? address;
  String? status;
  List<dynamic>? toolsRequired;
  String? servicePrice;
  String? assignedTechnician;

  Datum({
    this.bookingId,
    this.serviceType,
    this.bookingDate,
    this.startTime,
    this.endTime,
    this.timeSlot,
    this.duration,
    this.customerName,
    this.customerPhoneNumber,
    this.address,
    this.status,
    this.toolsRequired,
    this.servicePrice,
    this.assignedTechnician,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    bookingId: json["booking_id"],
    serviceType: json["service_type"],
    bookingDate: json["booking_date"],
    startTime: json["start_time"],
    endTime: json["end_time"],
    timeSlot: json["time_slot"],
    duration: json["duration"],
    customerName: json["customer_name"],
    customerPhoneNumber: json["customer_phone_number"],
    address: json["address"] == null ? null : Address.fromMap(json["address"]),
    status: json["status"],
    toolsRequired: json["tools_required"] == null ? [] : List<dynamic>.from(json["tools_required"]!.map((x) => x)),
    servicePrice: "${json["service_price"]}",
    assignedTechnician: json["assigned_technician"],
  );

  Map<String, dynamic> toMap() => {
    "booking_id": bookingId,
    "service_type": serviceType,
    "booking_date": bookingDate,
    "start_time": startTime,
    "end_time": endTime,
    "time_slot": timeSlot,
    "duration": duration,
    "customer_name": customerName,
    "customer_phone_number": customerPhoneNumber,
    "address": address?.toMap(),
    "status": status,
    "tools_required": toolsRequired == null ? [] : List<dynamic>.from(toolsRequired!.map((x) => x)),
    "service_price": servicePrice,
    "assigned_technician": assignedTechnician,
  };
}

class Address {
  String? address;
  String? city;
  String? pinCode;
  String? state;
  String? country;
  String? latitude;
  String? longitude;

  Address({
    this.address,
    this.city,
    this.pinCode,
    this.state,
    this.country,
    this.latitude,
    this.longitude,
  });

  factory Address.fromJson(String str) => Address.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Address.fromMap(Map<String, dynamic> json) => Address(
    address: json["address"],
    city: json["city"],
    pinCode: json["pin_code"],
    state: json["state"],
    country: json["country"],
    latitude: json["latitude"],
    longitude: json["longitude"],
  );

  Map<String, dynamic> toMap() => {
    "address": address,
    "city": city,
    "pin_code": pinCode,
    "state": state,
    "country": country,
    "latitude": latitude,
    "longitude": longitude,
  };
}
