import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magical_walls/core/constants/app_colors.dart';
import 'package:magical_walls/core/constants/app_text.dart';
import 'package:magical_walls/presentation/widgets/common_button.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../Home/screens/bottom_bar.dart';

class ProfileUnderReview extends StatefulWidget {
  const ProfileUnderReview({super.key});

  @override
  State<ProfileUnderReview> createState() => _ProfileUnderReviewState();
}

class _ProfileUnderReviewState extends State<ProfileUnderReview> {
  String status = 'approved';

  @override
  void initState() {
    super.initState();

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.white,
      body: ListView(
        children: [
          SizedBox(height: Get.height * 0.04),
          Text(
            status == 'approved'
                ? "Welcome Onboard!"
                : status == 'rejected'
                ? "Profile Rejected"
                : "Profile Under Review",
            style: CommonTextStyles.medium24,
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: Get.height * 0.2),
                status == 'approved'
                    ? Image.asset(
                        'assets/images/review_icon_ok.png',
                        width: 100,
                      )
                    : status == 'rejected'
                    ? Icon(Icons.close, color: Colors.red, size: 100)
                    : Image.asset('assets/images/review_icon.png', width: 100),
                SizedBox(height: Get.height * 0.02),
                Text(
                  status == 'approved'
                      ? "You’re Approved!"
                      : status == 'rejected'
                      ? "Your profile has been rejected."
                      : "You’re Almost There!",
                  style: CommonTextStyles.medium20.copyWith(
                    color: CommonColors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: Get.height * 0.01),
                Text(
                  status == 'approved'
                      ? "Start receiving jobs, grow your reputation, and earn \n more with MagicWall."
                      : status == 'rejected'
                      ? "Please re-upload your documents and try again."
                      : "Your documents are under verification.\nThis usually takes 24-48 hours.\nWe’ll notify you once your profile is approved.",
                  style: CommonTextStyles.regular14.copyWith(
                    color: CommonColors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: Get.height * 0.03),
                if (status == 'approved')
                  CommonButton(text: "Go to Dashboard", onTap: () {Get.to(()=>BottomBar(initialIndex: 0,));},backgroundColor: CommonColors.primaryColor,textColor: CommonColors.white,)
                else if (status == 'rejected')
                  CommonButton(text: "Re-verify KYC", onTap: () {},backgroundColor: CommonColors.primaryColor,textColor: CommonColors.white,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
