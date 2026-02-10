import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:magical_walls/core/constants/app_colors.dart';
import 'package:magical_walls/core/constants/app_text.dart';
import 'package:magical_walls/core/utils/utils.dart';
import 'package:magical_walls/presentation/pages/Auth/screens/otp_screen.dart';
import 'package:magical_walls/presentation/widgets/common_button.dart';
import 'package:magical_walls/presentation/widgets/common_textfield.dart';
import 'package:play_install_referrer/play_install_referrer.dart';

import '../controller/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key,});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController controller = Get.put(AuthController());
  final appLinks = AppLinks();
  StreamSubscription? subscription;

  Future<void> getInstallReferrer() async {
    try {
      final referrer = (await PlayInstallReferrer.installReferrer).installReferrer;

      debugPrint("getInstallReferrer $referrer");
      if (referrer != null) {
        final uri = Uri.parse('https://dummy?$referrer');
        // https://play.google.com/store/apps/details?id=com.your.app
        // &referrer=utm_source=test&utm_medium=emulator&utm_campaign=debug123

        final utmSource = uri.queryParameters['utm_source'];
        final utmCampaign = uri.queryParameters['utm_campaign'];
        final utmMedium = uri.queryParameters['utm_medium'];

        debugPrint('utm_source: $utmSource');
        debugPrint('utm_campaign: $utmCampaign');
        debugPrint('utm_medium: $utmMedium');
        if(utmCampaign?.isNotEmpty == true) {
          controller.referralController.text = utmCampaign ?? "";
        }
      }
    } catch (e) {
      debugPrint('Install referrer error: $e');
    }
  }
  @override
  void initState() {

    super.initState();
    getInstallReferrer();
    subscription = appLinks.uriLinkStream.listen((uri) {
      controller.referralController.text = uri.toString();
      Fluttertoast.showToast(
        msg:controller.referralController.text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      setState(() {


      });
    });
  }


  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.white,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 22),
        children: [
          Container(
            color: Colors.amber,
            margin: EdgeInsets.fromLTRB(70, 70, 70, 25),
            child: Image.asset('assets/images/logo.png'),
          ),
          Text(
            'Verify Your Mobile Number',
            style: CommonTextStyles.medium24.copyWith(
              color: CommonColors.black,
            ),
          ),
          SizedBox(height: Get.height * 0.012),
          Text(
            'Enter your mobile number to receive an OTP and get started.',
            style: CommonTextStyles.regular14.copyWith(
              color: CommonColors.grey,
            ),
          ),
          SizedBox(height: Get.height * 0.04),
          CommonTextField(
            maxLength: 10,

            controller: controller.mobile,
            label: 'Mobile Number',
            hintText: 'Enter your mobile number',
            isRequired: true,
            keyboardType: TextInputType.phone,
          ),
          SizedBox(height: Get.height * 0.025),
          CommonTextField(
            controller: controller.referralController,
            label: 'Referral Code',
            hintText: 'Enter your referral code',
            keyboardType: TextInputType.text,
          ),
          SizedBox(height: Get.height * 0.035),
          Obx(()=>
             CommonButton(
               isLoading: controller.isLoading.value,
              backgroundColor: CommonColors.primaryColor,textColor: CommonColors.white,
              text: 'Get OTP',
              onTap: () {
                FocusScope.of(context).unfocus();

                if (controller.mobile.text.length != 10) {
                  showCustomSnackBar(
                    context: context,
                    errorMessage: 'Number should be 10 digits',
                  );
                }
                else{
                  controller.getOtp( context)
            ;
              }
              },
            ),
          ),
        ],
      ),
    );
  }
}
