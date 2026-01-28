class SupportReasonModel {
  int? id;
  String? reason;
  String? type;
  String? createdAt;
  String? updatedAt;

  SupportReasonModel({
    this.id,
    this.reason,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  SupportReasonModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reason = json['reason'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['reason'] = reason;
    data['type'] = type;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
