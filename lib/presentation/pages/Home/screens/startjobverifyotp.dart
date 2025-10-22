import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magical_walls/core/constants/app_colors.dart';
import 'package:magical_walls/core/constants/app_text.dart';
import 'package:magical_walls/core/utils/utils.dart';
import 'package:magical_walls/presentation/pages/Auth/screens/kyc/service_add.dart';
import 'package:magical_walls/presentation/pages/Home/controller/home_controller.dart';
import 'package:magical_walls/presentation/pages/Home/screens/selfie_screen.dart';
import 'package:magical_walls/presentation/widgets/common_button.dart';

import 'package:pinput/pinput.dart';

class StartJobOtp extends StatefulWidget {
 final dynamic id;
 bool? isEndJob;
   StartJobOtp( {super.key,required this.id,this.isEndJob=false
  });

  @override
  State<StartJobOtp> createState() => _StartJobOtpState();
}

class _StartJobOtpState extends State<StartJobOtp> {
  final FocusNode _otpFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_otpFocus);
    });
  }

  HomeController controller = Get.put(HomeController());

  @override
  void dispose() {
    _otpFocus.dispose();
    super.dispose();
  }

  String pin = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.white,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 82),
        children: [
          Text(
         widget.isEndJob==true? 'Verify OTP to Complete Job':  'Verify OTP to Start Job',
            style: CommonTextStyles.medium24.copyWith(
              color: CommonColors.black,
            ),
          ),
          SizedBox(height: Get.height * 0.012),
          Text(
            'Please enter the 4-digit OTP provided by the customer',
            style: CommonTextStyles.regular14.copyWith(
              color: CommonColors.grey,
            ),
          ),
          SizedBox(height: Get.height * 0.04),

          Pinput(
            focusNode: _otpFocus,
            separatorBuilder: (index) => const SizedBox(width: 22),
            length: 4,
            defaultPinTheme: PinTheme(
              height: 56,
              width: 76,
              textStyle: CommonTextStyles.medium18.copyWith(
                color: CommonColors.black,
              ),
              decoration: BoxDecoration(
                color: CommonColors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: CommonColors.placeholderText,
                  width: 1,
                ),
              ),
            ),
            focusedPinTheme: PinTheme(
              height: 56,
              width: 76,
              textStyle: CommonTextStyles.medium18.copyWith(
                color: CommonColors.black,
              ),
              decoration: BoxDecoration(
                color: CommonColors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: CommonColors.pinFieldColor, width: 1),
              ),
            ),
            submittedPinTheme: PinTheme(
              height: 56,
              width: 76,
              textStyle: CommonTextStyles.medium18.copyWith(
                color: CommonColors.black,
              ),
              decoration: BoxDecoration(
                color: CommonColors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: CommonColors.pinFieldColor, width: 1),
              ),
            ),
            onChanged: (value) {
              pin = value;
            },
            onCompleted: (value) {
              pin = value;
            },
          ),

          SizedBox(height: Get.height * 0.035),

          Column(
            children: [
              Obx(
                () => CommonButton(
                  isLoading: controller.isLoading.value,
                  backgroundColor: CommonColors.primaryColor,
                  textColor: CommonColors.white,
                  text: 'Verify OTP',
                  onTap: () {
                    FocusScope.of(context).unfocus();

                    if (pin.length != 4) {
                      showCustomSnackBar(
                        context: context,
                        errorMessage: "Pin should be 4 digit",
                      );
                      return;
                    }

                    if (widget.isEndJob == true) {
                      final selectedIds = <int>[];


                      for (int i = 0; i < controller.checkListData.length; i++) {
                        final id = controller.checkListData[i].id;
                        if (controller.checklist[i] && id != null) {
                          selectedIds.add(id);
                        }
                      }

                      final photos = <File>[];
                      if (controller.startSelfiePic.value != null) {
                        photos.add(File(controller.startSelfiePic.value!.path));
                      }


                      controller.markAsCompleted(
                        context,
                        widget.id,
                        pin,
                        selectedIds,
                        photos,
                      );
                    } else {
                      controller.verifyStarJobOtp(widget.id, pin, widget.isEndJob);
                    }
                  },

                ),
              ),
              SizedBox(height: 20),
              Text(
                'Didn’t receive the code?',
                style: CommonTextStyles.regular14.copyWith(
                  color: CommonColors.black,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Ask customer to check SMS or Booking screen',
                style: CommonTextStyles.regular14.copyWith(
                  color: CommonColors.secondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
