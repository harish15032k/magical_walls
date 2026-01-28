class SupportModel {
  String monthYear;
  List<SupportTicketsModel> supportTickets;

  SupportModel({required this.monthYear, required this.supportTickets});
}

class SupportTicketsModel {
  int? id;
  int? userId;
  String? subject;
  String? message;
  String? status;
  String? createdAt;
  String? updatedAt,monthYear;

  SupportTicketsModel({
    this.id,
    this.userId,
    this.subject,
    this.message,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.monthYear
  });

  SupportTicketsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    subject = json['subject'];
    message = json['message'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    monthYear = json['month_year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['subject'] = subject;
    data['message'] = message;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['month_year'] = monthYear;
    return data;
  }
}
