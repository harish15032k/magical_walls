import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text.dart';
import 'package:magical_walls/presentation/pages/profile/model/profile_model.dart';
class PersonalInfo extends StatelessWidget {
  Data data;
   PersonalInfo({super.key ,required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Image.asset(
                      'assets/images/arrow-left.png',
                      width: 25,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text("Professional Info", style: CommonTextStyles.medium20),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: CommonColors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: CommonColors.textFieldGrey,
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _twoColumnRow(
                      'Services',
                      data.services?.map((m) => m.serviceName).join(", ") ?? "",
                      'Years of Experience',
                      data.experience??'',
                    ),

                    SizedBox(height: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Documents",
                          style: CommonTextStyles.regular14.copyWith(
                            color: CommonColors.secondary,
                          ),
                        ),
                        SizedBox(height: 3,),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(3),
                          child: Image.network(data.skillCertificate??'',
                            width: 150,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 15,),
                        Container(
                          decoration: BoxDecoration(color: CommonColors.green.withAlpha(30),borderRadius: BorderRadius.circular(30)),
                          padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,

                            children: [
                              Image.asset('assets/images/tick.png',width: 12,),
                              SizedBox(width: 3,),
                              Text("Verified",style: CommonTextStyles.semiBold12.copyWith(color: CommonColors.green),),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _twoColumnRow(
    String leftLabel,
    String leftValue,
    String rightLabel,
    String rightValue,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                leftLabel,
                style: CommonTextStyles.regular14.copyWith(
                  color: CommonColors.secondary,
                ),
              ),
              const SizedBox(height: 2),
              SizedBox(
                width: 120,
                child: Text(leftValue, style: CommonTextStyles.medium14),
              ),
            ],
          ),
        ),
        SizedBox(width: 100),

        /// Right side
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (rightLabel.isNotEmpty) ...[
                Text(
                  rightLabel,
                  style: CommonTextStyles.regular14.copyWith(
                    color: CommonColors.secondary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(rightValue, style: CommonTextStyles.medium14),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
