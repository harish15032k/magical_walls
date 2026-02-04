class ReferralHistoryModel {
  int? id;
  int? userId;
  int? referredUserId;
  String? amount;
  int? credited;
  String? createdAt;
  String? updatedAt,referredName,referredProfileImage;

  ReferralHistoryModel(
      {this.id,
        this.userId,
        this.referredUserId,
        this.amount,
        this.credited,
        this.createdAt,
        this.updatedAt,this.referredName,this.referredProfileImage});

  ReferralHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    referredUserId = json['referred_user_id'];
    amount = "${json['amount']}";
    credited = json['credited'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    referredName = json['referred_name'];
    referredProfileImage = json['referred_profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['referred_user_id'] = referredUserId;
    data['amount'] = amount;
    data['credited'] = credited;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['referred_name'] = referredName;
    data['referred_profile_image'] = referredProfileImage;
    return data;
  }
}