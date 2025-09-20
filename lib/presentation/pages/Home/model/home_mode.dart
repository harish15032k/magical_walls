import 'dart:convert';

class OrderListRes {
  bool? status;
  String? filter;
  List<Datum>? data;
  String? message;

  OrderListRes({
    this.status,
    this.filter,
    this.data,
    this.message,
  });

  factory OrderListRes.fromJson(String str) => OrderListRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrderListRes.fromMap(Map<String, dynamic> json) => OrderListRes(
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
  int? id;
  int? customerId;
  dynamic technicianId;
  int? serviceId;
  int? rating;
  dynamic review;
  int? addressId;
  String? paymentStatus;
  dynamic paymentMode;
  dynamic bookingDate;
  DateTime? startDate;
  dynamic startedDate;
  dynamic endedDate;
  dynamic timeSlot;
  dynamic otp;
  dynamic otpExpiresAt;
  dynamic selfieImage;
  dynamic photoOfDoneWork;
  dynamic comments;
  dynamic whatsIncludedDone;
  Booked? status;
  Booked? booked;
  String? price;
  int? quantity;
  dynamic notes;
  dynamic reason;
  dynamic rejectReason;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<WorkChecklist>? workChecklist;
  Service? service;
  User? user;
  Address? address;

  Datum({
    this.id,
    this.customerId,
    this.technicianId,
    this.serviceId,
    this.rating,
    this.review,
    this.addressId,
    this.paymentStatus,
    this.paymentMode,
    this.bookingDate,
    this.startDate,
    this.startedDate,
    this.endedDate,
    this.timeSlot,
    this.otp,
    this.otpExpiresAt,
    this.selfieImage,
    this.photoOfDoneWork,
    this.comments,
    this.whatsIncludedDone,
    this.status,
    this.booked,
    this.price,
    this.quantity,
    this.notes,
    this.reason,
    this.rejectReason,
    this.createdAt,
    this.updatedAt,
    this.workChecklist,
    this.service,
    this.user,
    this.address,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    customerId: json["customer_id"],
    technicianId: json["technician_id"],
    serviceId: json["service_id"],
    rating: json["rating"],
    review: json["review"],
    addressId: json["address_id"],
    paymentStatus: json["payment_status"],
    paymentMode: json["payment_mode"],
    bookingDate: json["booking_date"],
    startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
    startedDate: json["started_date"],
    endedDate: json["ended_date"],
    timeSlot: json["time_slot"],
    otp: json["otp"],
    otpExpiresAt: json["otp_expires_at"],
    selfieImage: json["selfie_image"],
    photoOfDoneWork: json["photo_of_done_work"],
    comments: json["comments"],
    whatsIncludedDone: json["whats_included_done"],
    status: bookedValues.map[json["status"]]!,
    booked: bookedValues.map[json["booked"]]!,
    price: json["price"],
    quantity: json["quantity"],
    notes: json["notes"],
    reason: json["reason"],
    rejectReason: json["reject_reason"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    workChecklist: json["work_checklist"] == null ? [] : List<WorkChecklist>.from(json["work_checklist"]!.map((x) => WorkChecklist.fromMap(x))),
    service: json["service"] == null ? null : Service.fromMap(json["service"]),
    user: json["user"] == null ? null : User.fromMap(json["user"]),
    address: json["address"] == null ? null : Address.fromMap(json["address"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "customer_id": customerId,
    "technician_id": technicianId,
    "service_id": serviceId,
    "rating": rating,
    "review": review,
    "address_id": addressId,
    "payment_status": paymentStatus,
    "payment_mode": paymentMode,
    "booking_date": bookingDate,
    "start_date": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
    "started_date": startedDate,
    "ended_date": endedDate,
    "time_slot": timeSlot,
    "otp": otp,
    "otp_expires_at": otpExpiresAt,
    "selfie_image": selfieImage,
    "photo_of_done_work": photoOfDoneWork,
    "comments": comments,
    "whats_included_done": whatsIncludedDone,
    "status": bookedValues.reverse[status],
    "booked": bookedValues.reverse[booked],
    "price": price,
    "quantity": quantity,
    "notes": notes,
    "reason": reason,
    "reject_reason": rejectReason,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "work_checklist": workChecklist == null ? [] : List<dynamic>.from(workChecklist!.map((x) => x.toMap())),
    "service": service?.toMap(),
    "user": user?.toMap(),
    "address": address?.toMap(),
  };
}

class Address {
  int? id;
  int? userId;
  String? addressLine1;
  dynamic addressLine2;
  String? city;
  dynamic state;
  dynamic country;
  String? pinCode;
  String? latitude;
  String? longitude;
  int? isDefault;
  DateTime? createdAt;
  DateTime? updatedAt;

  Address({
    this.id,
    this.userId,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.state,
    this.country,
    this.pinCode,
    this.latitude,
    this.longitude,
    this.isDefault,
    this.createdAt,
    this.updatedAt,
  });

  factory Address.fromJson(String str) => Address.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Address.fromMap(Map<String, dynamic> json) => Address(
    id: json["id"],
    userId: json["user_id"],
    addressLine1: json["address_line1"],
    addressLine2: json["address_line2"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    pinCode: json["pin_code"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    isDefault: json["is_default"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "user_id": userId,
    "address_line1": addressLine1,
    "address_line2": addressLine2,
    "city": city,
    "state": state,
    "country": country,
    "pin_code": pinCode,
    "latitude": latitude,
    "longitude": longitude,
    "is_default": isDefault,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

enum Booked {
  PENDING
}

final bookedValues = EnumValues({
  "pending": Booked.PENDING
});

class Service {
  int? id;
  String? name;
  dynamic timeSlot;
  dynamic toolsRequired;
  dynamic taskName;
  List<Review>? reviews;
  String? image;
  String? ratings;
  DateTime? startDate;
  DateTime? endDate;
  Booked? status;
  DateTime? acceptedAt;
  dynamic address;
  String? latitude;
  String? longitude;
  int? customerId;
  Booked? booked;
  int? technicianId;
  String? description;
  List<String>? categoriesId;
  List<WhatsIncluded>? whatsIncluded;
  List<WhatsNotIncluded>? whatsNotIncluded;
  String? price;
  int? tax;
  int? discount;
  String? paidAmount;
  String? paymentStatus;
  dynamic paymentMode;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic otp;
  DateTime? otpExpiresAt;
  String? selfieImage;
  dynamic startedAt;
  DateTime? endedAt;
  dynamic photoOfDoneWork;
  List<int>? whatsIncludedDone;
  String? comments;

  Service({
    this.id,
    this.name,
    this.timeSlot,
    this.toolsRequired,
    this.taskName,
    this.reviews,
    this.image,
    this.ratings,
    this.startDate,
    this.endDate,
    this.status,
    this.acceptedAt,
    this.address,
    this.latitude,
    this.longitude,
    this.customerId,
    this.booked,
    this.technicianId,
    this.description,
    this.categoriesId,
    this.whatsIncluded,
    this.whatsNotIncluded,
    this.price,
    this.tax,
    this.discount,
    this.paidAmount,
    this.paymentStatus,
    this.paymentMode,
    this.createdAt,
    this.updatedAt,
    this.otp,
    this.otpExpiresAt,
    this.selfieImage,
    this.startedAt,
    this.endedAt,
    this.photoOfDoneWork,
    this.whatsIncludedDone,
    this.comments,
  });

  factory Service.fromJson(String str) => Service.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Service.fromMap(Map<String, dynamic> json) => Service(
    id: json["id"],
    name: json["name"],
    timeSlot: json["time_slot"],
    toolsRequired: json["tools_required"],
    taskName: json["task_name"],
    reviews: json["reviews"] == null ? [] : List<Review>.from(json["reviews"]!.map((x) => Review.fromMap(x))),
    image: json["image"],
    ratings: json["ratings"],
    startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
    endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
    status: bookedValues.map[json["status"]]!,
    acceptedAt: json["accepted_at"] == null ? null : DateTime.parse(json["accepted_at"]),
    address: json["address"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    customerId: json["customer_id"],
    booked: bookedValues.map[json["booked"]]!,
    technicianId: json["technician_id"],
    description: json["description"],
    categoriesId: json["categories_id"] == null ? [] : List<String>.from(json["categories_id"]!.map((x) => x)),
    whatsIncluded: json["whats_included"] == null ? [] : List<WhatsIncluded>.from(json["whats_included"]!.map((x) => whatsIncludedValues.map[x]!)),
    whatsNotIncluded: json["whats_not_included"] == null ? [] : List<WhatsNotIncluded>.from(json["whats_not_included"]!.map((x) => whatsNotIncludedValues.map[x]!)),
    price: json["price"],
    tax: json["tax"],
    discount: json["discount"],
    paidAmount: json["paid_amount"],
    paymentStatus: json["payment_status"],
    paymentMode: json["payment_mode"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    otp: json["otp"],
    otpExpiresAt: json["otp_expires_at"] == null ? null : DateTime.parse(json["otp_expires_at"]),
    selfieImage: json["selfie_image"],
    startedAt: json["started_at"],
    endedAt: json["ended_at"] == null ? null : DateTime.parse(json["ended_at"]),
    photoOfDoneWork: json["photo_of_done_work"],
    whatsIncludedDone: json["whats_included_done"] == null ? [] : List<int>.from(json["whats_included_done"]!.map((x) => x)),
    comments: json["comments"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "time_slot": timeSlot,
    "tools_required": toolsRequired,
    "task_name": taskName,
    "reviews": reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x.toMap())),
    "image": image,
    "ratings": ratings,
    "start_date": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
    "end_date": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
    "status": bookedValues.reverse[status],
    "accepted_at": acceptedAt?.toIso8601String(),
    "address": address,
    "latitude": latitude,
    "longitude": longitude,
    "customer_id": customerId,
    "booked": bookedValues.reverse[booked],
    "technician_id": technicianId,
    "description": description,
    "categories_id": categoriesId == null ? [] : List<dynamic>.from(categoriesId!.map((x) => x)),
    "whats_included": whatsIncluded == null ? [] : List<dynamic>.from(whatsIncluded!.map((x) => whatsIncludedValues.reverse[x])),
    "whats_not_included": whatsNotIncluded == null ? [] : List<dynamic>.from(whatsNotIncluded!.map((x) => whatsNotIncludedValues.reverse[x])),
    "price": price,
    "tax": tax,
    "discount": discount,
    "paid_amount": paidAmount,
    "payment_status": paymentStatus,
    "payment_mode": paymentMode,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "otp": otp,
    "otp_expires_at": otpExpiresAt?.toIso8601String(),
    "selfie_image": selfieImage,
    "started_at": startedAt,
    "ended_at": endedAt?.toIso8601String(),
    "photo_of_done_work": photoOfDoneWork,
    "whats_included_done": whatsIncludedDone == null ? [] : List<dynamic>.from(whatsIncludedDone!.map((x) => x)),
    "comments": comments,
  };
}

class Review {
  String? comment;
  int? customerId;

  Review({
    this.comment,
    this.customerId,
  });

  factory Review.fromJson(String str) => Review.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Review.fromMap(Map<String, dynamic> json) => Review(
    comment: json["comment"],
    customerId: json["customer_id"],
  );

  Map<String, dynamic> toMap() => {
    "comment": comment,
    "customer_id": customerId,
  };
}

enum WhatsIncluded {
  ASD,
  ASDC,
  SAD
}

final whatsIncludedValues = EnumValues({
  "asd": WhatsIncluded.ASD,
  "asdc": WhatsIncluded.ASDC,
  "sad": WhatsIncluded.SAD
});

enum WhatsNotIncluded {
  ASD,
  DSD,
  SAD
}

final whatsNotIncludedValues = EnumValues({
  "asd": WhatsNotIncluded.ASD,
  "dsd": WhatsNotIncluded.DSD,
  "sad": WhatsNotIncluded.SAD
});

class User {
  int? id;
  String? name;
  String? dob;
  String? technician;
  String? technicianStatus;
  dynamic alternativeNumber;
  dynamic licencesHolder;
  dynamic licencesCertificateFront;
  dynamic licencesCertificateBack;
  dynamic aadharFront;
  dynamic aadharBack;
  String? phone;
  dynamic guidelines;
  String? aadharCard;
  String? panCard;
  String? skillCertificate;
  String? email;
  dynamic emailVerifiedAt;
  String? address;
  String? city;
  String? pinCode;
  int? isDefault;
  String? status;
  dynamic catId;
  dynamic category;
  dynamic rateUser;
  String? rating;
  dynamic state;
  dynamic area;
  dynamic district;
  dynamic wallet;
  String? bankHolderName;
  String? bankName;
  List<dynamic>? spokenLanguages;
  List<dynamic>? service;
  String? gender;
  String? accountNumber;
  String? ifscCode;
  dynamic refer;
  dynamic experience;
  dynamic technicianImage;
  String? latitude;
  String? longitude;
  dynamic workingTime;
  dynamic workingLocation;
  String? rememberToken;
  String? fcmToken;
  int? otpCode;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    this.id,
    this.name,
    this.dob,
    this.technician,
    this.technicianStatus,
    this.alternativeNumber,
    this.licencesHolder,
    this.licencesCertificateFront,
    this.licencesCertificateBack,
    this.aadharFront,
    this.aadharBack,
    this.phone,
    this.guidelines,
    this.aadharCard,
    this.panCard,
    this.skillCertificate,
    this.email,
    this.emailVerifiedAt,
    this.address,
    this.city,
    this.pinCode,
    this.isDefault,
    this.status,
    this.catId,
    this.category,
    this.rateUser,
    this.rating,
    this.state,
    this.area,
    this.district,
    this.wallet,
    this.bankHolderName,
    this.bankName,
    this.spokenLanguages,
    this.service,
    this.gender,
    this.accountNumber,
    this.ifscCode,
    this.refer,
    this.experience,
    this.technicianImage,
    this.latitude,
    this.longitude,
    this.workingTime,
    this.workingLocation,
    this.rememberToken,
    this.fcmToken,
    this.otpCode,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    dob: json["dob"],
    technician: json["technician"],
    technicianStatus: json["technician_status"],
    alternativeNumber: json["alternative_number"],
    licencesHolder: json["licences_holder"],
    licencesCertificateFront: json["licences_certificate_front"],
    licencesCertificateBack: json["licences_certificate_back"],
    aadharFront: json["aadhar_front"],
    aadharBack: json["aadhar_back"],
    phone: json["phone"],
    guidelines: json["guidelines"],
    aadharCard: json["aadhar_card"],
    panCard: json["pan_card"],
    skillCertificate: json["skill_certificate"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    address: json["address"],
    city: json["city"],
    pinCode: json["pin_code"],
    isDefault: json["is_default"],
    status: json["status"],
    catId: json["cat_id"],
    category: json["category"],
    rateUser: json["rate_user"],
    rating: json["rating"],
    state: json["state"],
    area: json["area"],
    district: json["district"],
    wallet: json["wallet"],
    bankHolderName: json["bank_holder_name"],
    bankName: json["bank_name"],
    spokenLanguages: json["spoken_languages"] == null ? [] : List<dynamic>.from(json["spoken_languages"]!.map((x) => x)),
    service: json["service"] == null ? [] : List<dynamic>.from(json["service"]!.map((x) => x)),
    gender: json["gender"],
    accountNumber: json["account_number"],
    ifscCode: json["ifsc_code"],
    refer: json["refer"],
    experience: json["experience"],
    technicianImage: json["technician_image"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    workingTime: json["working_time"],
    workingLocation: json["working_location"],
    rememberToken: json["remember_token"],
    fcmToken: json["fcm_token"],
    otpCode: json["otp_code"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "dob": dob,
    "technician": technician,
    "technician_status": technicianStatus,
    "alternative_number": alternativeNumber,
    "licences_holder": licencesHolder,
    "licences_certificate_front": licencesCertificateFront,
    "licences_certificate_back": licencesCertificateBack,
    "aadhar_front": aadharFront,
    "aadhar_back": aadharBack,
    "phone": phone,
    "guidelines": guidelines,
    "aadhar_card": aadharCard,
    "pan_card": panCard,
    "skill_certificate": skillCertificate,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "address": address,
    "city": city,
    "pin_code": pinCode,
    "is_default": isDefault,
    "status": status,
    "cat_id": catId,
    "category": category,
    "rate_user": rateUser,
    "rating": rating,
    "state": state,
    "area": area,
    "district": district,
    "wallet": wallet,
    "bank_holder_name": bankHolderName,
    "bank_name": bankName,
    "spoken_languages": spokenLanguages == null ? [] : List<dynamic>.from(spokenLanguages!.map((x) => x)),
    "service": service == null ? [] : List<dynamic>.from(service!.map((x) => x)),
    "gender": gender,
    "account_number": accountNumber,
    "ifsc_code": ifscCode,
    "refer": refer,
    "experience": experience,
    "technician_image": technicianImage,
    "latitude": latitude,
    "longitude": longitude,
    "working_time": workingTime,
    "working_location": workingLocation,
    "remember_token": rememberToken,
    "fcm_token": fcmToken,
    "otp_code": otpCode,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class WorkChecklist {
  int? id;
  WhatsIncluded? name;
  Booked? status;

  WorkChecklist({
    this.id,
    this.name,
    this.status,
  });

  factory WorkChecklist.fromJson(String str) => WorkChecklist.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WorkChecklist.fromMap(Map<String, dynamic> json) => WorkChecklist(
    id: json["id"],
    name: whatsIncludedValues.map[json["name"]]!,
    status: bookedValues.map[json["status"]]!,
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": whatsIncludedValues.reverse[name],
    "status": bookedValues.reverse[status],
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
