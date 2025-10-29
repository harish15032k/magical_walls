import 'dart:convert';

class OrderCompletedRes {
  bool? status;
  String? filter;
  List<Datum>? data;
  String? message;

  OrderCompletedRes({
    this.status,
    this.filter,
    this.data,
    this.message,
  });

  factory OrderCompletedRes.fromJson(String str) => OrderCompletedRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrderCompletedRes.fromMap(Map<String, dynamic> json) => OrderCompletedRes(
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
  String? startTime;
  String? endTime;
  String? timeSlot;
  String? duration;
  String? completedOn;
  CustomerInformation? customerInformation;
  PaymentInfo? paymentInfo;
  String? technicianNotes;
  List<WorkChecklist>? workChecklist;
  List<String?>? uploadedPhotos;
  CustomerRatingFeedback? customerRatingFeedback;
  String? customerName;
  String? customerPhoneNumber;
  Address? address;
  String? status;
  List<dynamic>? toolsRequired;
  String? servicePrice, totalServicePrice, quantity;
  String? assignedTechnician;
  bool? isAcceptedByYou;

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
    this.isAcceptedByYou, this.totalServicePrice, this.quantity, this.completedOn,
    this.customerInformation,
    this.paymentInfo,
    this.technicianNotes,
    this.workChecklist,
    this.uploadedPhotos,
    this.customerRatingFeedback,
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
      address: json["address"] == null ? null : Address.fromMap(
          json["address"]),
      status: json["status"],
      toolsRequired: json["tools_required"] == null ? [] : List<dynamic>.from(
          json["tools_required"]!.map((x) => x)),
      servicePrice: "${json["service_price"]}",
      assignedTechnician: json["assigned_technician"],
      isAcceptedByYou: json['isAcceptedByYou'],
      completedOn: json["completed_on"],
      customerInformation: json["customer_information"] == null
          ? null
          : CustomerInformation.fromMap(json["customer_information"]),
      paymentInfo: json["payment_info"] == null ? null : PaymentInfo.fromMap(
          json["payment_info"]),
      technicianNotes: json["technician_notes"],
      workChecklist: json["work_checklist"] == null ? [] : List<
          WorkChecklist>.from(
          json["work_checklist"]!.map((x) => WorkChecklist.fromMap(x))),
      uploadedPhotos:  (json['uploaded_photos'] as List?)?.map((e) => e.toString()).toList(),
      customerRatingFeedback: json["customer_rating_feedback"] == null
          ? null
          : CustomerRatingFeedback.fromMap(json["customer_rating_feedback"]),


      totalServicePrice: double
          .tryParse("${json['total_service_price']}")
          ?.toStringAsFixed(2) ?? "${json['total_service_price']}",
      quantity: "${json['quantity']}"
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
    "tools_required": toolsRequired == null ? [] : List<dynamic>.from(
        toolsRequired!.map((x) => x)),
    "service_price": servicePrice,
    "assigned_technician": assignedTechnician,
    'isAcceptedByYou': isAcceptedByYou,
    'total_service_price': totalServicePrice,
    'quantity': quantity,
    "completed_on": completedOn,
    "customer_information": customerInformation?.toMap(),
    "payment_info": paymentInfo?.toMap(),
    "technician_notes": technicianNotes,
    "work_checklist": workChecklist == null ? [] : List<dynamic>.from(workChecklist!.map((x) => x.toMap())),
    "uploaded_photos": uploadedPhotos,
    "customer_rating_feedback": customerRatingFeedback?.toMap(),

  };
}


class CustomerInformation {
  String? name;
  String? phoneNumber;
  Address? address;

  CustomerInformation({
    this.name,
    this.phoneNumber,
    this.address,
  });

  factory CustomerInformation.fromJson(String str) => CustomerInformation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CustomerInformation.fromMap(Map<String, dynamic> json) => CustomerInformation(
    name: json["name"],
    phoneNumber: json["phone_number"],
    address: json["address"] == null ? null : Address.fromMap(json["address"]),
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "phone_number": phoneNumber,
    "address": address?.toMap(),
  };
}

class Address {
  String? address;
  String? city;
  String? pinCode;
  String? latitude;
  String? longitude;
  String? state;
  String? country;

  Address({
    this.address,
    this.city,
    this.pinCode,
    this.latitude,
    this.longitude,
    this.state,
    this.country,
  });

  factory Address.fromJson(String str) => Address.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Address.fromMap(Map<String, dynamic> json) => Address(
    address: json["address"],
    city: json["city"],
    pinCode: json["pin_code"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    state: json["state"],
    country: json["country"],
  );

  Map<String, dynamic> toMap() => {
    "address": address,
    "city": city,
    "pin_code": pinCode,
    "latitude": latitude,
    "longitude": longitude,
    "state": state,
    "country": country,
  };
}

class CustomerRatingFeedback {
  List<RatingText>? ratingText;

  CustomerRatingFeedback({
    this.ratingText,
  });

  factory CustomerRatingFeedback.fromJson(String str) => CustomerRatingFeedback.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CustomerRatingFeedback.fromMap(Map<String, dynamic> json) => CustomerRatingFeedback(
    ratingText: json["rating_text"] == null ? [] : List<RatingText>.from(json["rating_text"]!.map((x) => RatingText.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "rating_text": ratingText == null ? [] : List<dynamic>.from(ratingText!.map((x) => x.toMap())),
  };
}

class RatingText {
  int? id;
  String? rating;
  String? review;
  int? userId;
  int? serviceId;
  DateTime? reviewedDate;

  RatingText({
    this.id,
    this.rating,
    this.review,
    this.userId,
    this.serviceId,
    this.reviewedDate,
  });

  factory RatingText.fromJson(String str) => RatingText.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RatingText.fromMap(Map<String, dynamic> json) => RatingText(
    id: json["id"],
    rating: json["rating"],
    review: json["review"],
    userId: json["user_id"],
    serviceId: json["service_id"],
    reviewedDate: json["reviewed_date"] == null ? null : DateTime.parse(json["reviewed_date"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "rating": rating,
    "review": review,
    "user_id": userId,
    "service_id": serviceId,
    "reviewed_date": reviewedDate?.toIso8601String(),
  };
}

class PaymentInfo {
  String? totalAmount,grantAmount;
  String? paymentMode;
  String? paymentStatus;

  PaymentInfo({
    this.totalAmount,this.grantAmount,
    this.paymentMode,
    this.paymentStatus,
  });

  factory PaymentInfo.fromJson(String str) => PaymentInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PaymentInfo.fromMap(Map<String, dynamic> json) => PaymentInfo(
    totalAmount: json["total_amount"],
    paymentMode: json["payment_mode"],
    paymentStatus: json["payment_status"],
    grantAmount: "${json['grant_amount']}",
  );

  Map<String, dynamic> toMap() => {
    "total_amount": totalAmount,
    "payment_mode": paymentMode,
    "payment_status": paymentStatus,
    'grant_amount' : grantAmount
  };
}

class WorkChecklist {
  int? id;
  String? name;
  String? status;

  WorkChecklist({
    this.id,
    this.name,
    this.status,
  });

  factory WorkChecklist.fromJson(String str) => WorkChecklist.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WorkChecklist.fromMap(Map<String, dynamic> json) => WorkChecklist(
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
