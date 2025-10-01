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
  const SelfieScreen( {super.key, required this.id,this.otpScreen});

  @override
  State<SelfieScreen> createState() => _SelfieScreenState();
}

class _SelfieScreenState extends State<SelfieScreen> {
  HomeController controller = Get.put(HomeController())
;
  Future<void> imagepicker() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      setState(() {
      controller.startSelfiePic = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 82),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  'Take Selfie',
                  style: CommonTextStyles.medium24.copyWith(
                    color: CommonColors.black,
                  ),
                ),
                SizedBox(height: Get.height * 0.012),
                Text(
                  'Take a clear selfie to verify you’re on site.',
                  style: CommonTextStyles.regular14.copyWith(
                    color: CommonColors.grey,
                  ),
                ),
                SizedBox(height: Get.height * 0.15),
                Obx(()=>
                  Center(
                    child: controller.startSelfiePic == null
                        ? Image.asset('assets/images/frame.png', width: 250)
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(3),
                            child: Image.file(
                              controller.startSelfiePic!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 248,
                            ),
                          ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Obx(()=>
               CommonButton(
                 isLoading: controller.isLoading.value,
                  onTap: () {
                    controller.startSelfiePic==null? imagepicker():controller.takeSelfieToStartJob(widget.id,widget.otpScreen);
                  },
                  text:controller.startSelfiePic==null? "Take Selfie":" Confirm & Continue",
                  backgroundColor: CommonColors.primaryColor,
                  textColor: CommonColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
