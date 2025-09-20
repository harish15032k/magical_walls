import 'dart:convert';

class ProfileRes {
  bool? status;
  Data? data;

  ProfileRes({
    this.status,
    this.data,
  });

  factory ProfileRes.fromJson(String str) => ProfileRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProfileRes.fromMap(Map<String, dynamic> json) => ProfileRes(
    status: json["status"],
    data: json["data"] == null ? null : Data.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "data": data?.toMap(),
  };
}

class Data {
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
  dynamic rememberToken;
  String? fcmToken;
  int? otpCode;
  DateTime? createdAt;
  DateTime? updatedAt;

  Data({
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

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
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
