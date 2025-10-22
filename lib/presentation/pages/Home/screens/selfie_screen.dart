import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:magical_walls/presentation/pages/Home/controller/home_controller.dart';
import 'package:magical_walls/presentation/pages/Home/screens/home_screen.dart';
import 'package:magical_walls/presentation/widgets/common_button.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text.dart';
import 'bottom_bar.dart';

class SelfieScreen extends StatefulWidget {
  final dynamic id;
  final bool? otpScreen;
  SelfieScreen({super.key, required this.id, this.otpScreen});

  @override
  State<SelfieScreen> createState() => _SelfieScreenState();
}

class _SelfieScreenState extends State<SelfieScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.startSelfiePic.value==null;
  }
  final HomeController controller = Get.find<HomeController>();


  Future<void> pickImage() async {
    final XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      controller.startSelfiePic.value = File(pickedFile.path);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 82),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Take Selfie', style: CommonTextStyles.medium24.copyWith(color: CommonColors.black)),
                SizedBox(height: 12),
                Text('Take a clear selfie to verify you’re on site.',
                    style: CommonTextStyles.regular14.copyWith(color: CommonColors.grey)),
                SizedBox(height: 50),
                Obx(() => Center(
                  child: controller.startSelfiePic.value == null
                      ? Image.asset('assets/images/frame.png', width: 250)
                      : ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: Image.file(
                      controller.startSelfiePic.value!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 248,
                    ),
                  ),
                )),
                SizedBox(height: 20),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Obx(() => Padding(
              padding: const EdgeInsets.all(16.0),
              child: CommonButton(
                isLoading: controller.isLoading.value,
                onTap: () {
                  if (controller.startSelfiePic.value == null) {
                    pickImage();
                  } else {
                    controller.takeSelfieToStartJob(widget.id, widget.otpScreen!,context);
                  }
                },
                text: controller.startSelfiePic.value == null
                    ? "Take Selfie"
                    : "Confirm & Continue",
                backgroundColor: CommonColors.primaryColor,
                textColor: CommonColors.white,
              ),
            )),
          ),
        ],
      ),
    );
  }
}

