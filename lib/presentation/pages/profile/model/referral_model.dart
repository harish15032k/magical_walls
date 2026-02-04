

import 'package:magical_walls/presentation/pages/profile/model/referral_history_model.dart';

class ReferralModel {
  List<ReferralHistoryModel>? referralHistory;
  String? referralEarnings;
  String? referralCode;

  ReferralModel(
      {this.referralHistory, this.referralEarnings, this.referralCode});

  ReferralModel.fromJson(Map<String, dynamic> json) {
    if (json['referral_history'] != null) {
      referralHistory = <ReferralHistoryModel>[];
      json['referral_history'].forEach((v) {
        referralHistory!.add(ReferralHistoryModel.fromJson(v));
      });
    }
    referralEarnings = "${json['referral_earnings'] ??"0"}";
    referralCode = json['referral_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (referralHistory != null && referralHistory?.isNotEmpty == true) {
      data['referral_history'] =
          referralHistory!.map((v) => v.toJson()).toList();
    }
    data['referral_earnings'] = referralEarnings;
    data['referral_code'] = referralCode;
    return data;
  }
}