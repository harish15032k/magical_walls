import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magical_walls/core/constants/app_colors.dart';
import 'package:magical_walls/core/constants/app_text.dart';
import 'package:magical_walls/presentation/pages/Auth/controller/auth_controller.dart';
import 'package:magical_walls/presentation/pages/Auth/screens/kyc/service_add.dart';
import 'package:magical_walls/presentation/pages/location/screens/location_access.dart';
import 'package:magical_walls/presentation/widgets/common_button.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../Home/screens/bottom_bar.dart';

class ProfileUnderReview extends StatefulWidget {
  const ProfileUnderReview({super.key});

  @override
  State<ProfileUnderReview> createState() => _ProfileUnderReviewState();
}

class _ProfileUnderReviewState extends State<ProfileUnderReview> {
  AuthController controller = Get.put(AuthController());
  @override
  void initState() {
    super.initState();
    controller.getKycStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.white,
      body: Column(
        children: [
          Obx(() => controller.isLoading.value
              ? Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: const LinearProgressIndicator(),
              )
              : const SizedBox.shrink()),
          Expanded(
            child: StreamBuilder<String>(
              stream: controller.kycStatusStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return  Center(child: SizedBox(width: 20,height: 20, child: CircularProgressIndicator(strokeWidth: 2,color: CommonColors.primaryColor,)));
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text("Error: ${snapshot.error}"),
                  );
                }

                String status = snapshot.data ?? '';

                return ListView(
                  children: [
                    SizedBox(height: Get.height * 0.04),
                    Text(
                      status == 'Approved'
                          ? "Welcome Onboard!"
                          : status == 'Rejected'
                          ? "Profile Rejected"
                          : "Profile Under Review",
                      style: CommonTextStyles.medium24,
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 22,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: Get.height * 0.2),
                          if (status == 'Approved')
                            Image.asset('assets/images/review_icon_ok.png',
                                width: 100)
                          else if (status == 'Rejected')
                            const Icon(Icons.close,
                                color: Colors.red, size: 100)
                          else
                            Image.asset('assets/images/review_icon.png',
                                width: 100),
                          SizedBox(height: Get.height * 0.02),
                          Text(
                            status == 'Approved'
                                ? "You’re Approved!"
                                : status == 'Rejected'
                                ? "Your profile has been Rejected."
                                : "You’re Almost There!",
                            style: CommonTextStyles.medium20.copyWith(
                              color: CommonColors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: Get.height * 0.01),
                          Text(
                            status == 'Approved'
                                ? "Start receiving jobs, grow your reputation, and earn \n more with MagicWall."
                                : status == 'Rejected'
                                ? "Please re-upload your documents and try again."
                                : "Your documents are under verification.\nThis usually takes 24-48 hours.\nWe’ll notify you once your profile is Approved.",
                            style: CommonTextStyles.regular14.copyWith(
                              color: CommonColors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: Get.height * 0.03),
                          if (status == 'Approved')
                            CommonButton(
                              text: "Go to Dashboard",
                              onTap: () async {
                                final prefs =
                                await SharedPreferences.getInstance();
                                await prefs.setBool('iskycverified', true);

                                Get.offAll(() =>LocationAccessScreen() );
                              },
                              backgroundColor: CommonColors.primaryColor,
                              textColor: CommonColors.white,
                            )
                          else if (status == 'Rejected')
                            CommonButton(
                              text: "Re-verify KYC",
                              onTap: () {
                                Get.to(() => const SelectService());
                              },
                              backgroundColor: CommonColors.primaryColor,
                              textColor: CommonColors.white,
                            ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }


}
