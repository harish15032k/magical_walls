import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magical_walls/core/constants/app_colors.dart';
import 'package:magical_walls/core/constants/app_text.dart';
import 'package:magical_walls/core/utils/utils.dart';
import 'package:magical_walls/presentation/pages/Auth/controller/auth_controller.dart';
import 'package:magical_walls/presentation/pages/Auth/screens/kyc/id_verification.dart';
import 'package:magical_walls/presentation/widgets/common_button.dart';
import 'package:magical_walls/presentation/widgets/common_textfield.dart';



import 'dart:io';
import 'package:image_picker/image_picker.dart';

class WorkDetails extends StatefulWidget {
  const WorkDetails({super.key});

  @override
  State<WorkDetails> createState() => _WorkDetailsState();
}

class _WorkDetailsState extends State<WorkDetails> {
  final AuthController controller = Get.put(AuthController());


  Future<void> imagepicker() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        controller.pickedSkilledImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.white,
      resizeToAvoidBottomInset: true,
      body: ListView(
        children: [
          LinearProgressIndicator(
            value: .65,
            backgroundColor: Colors.grey.shade300,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Technician Onboarding", style: CommonTextStyles.medium20),
                SizedBox(height: Get.height * 0.01),
                Text(
                  "We’ll need some documents to verify your profile.",
                  style: CommonTextStyles.regular14.copyWith(
                    color: CommonColors.grey,
                  ),
                ),
                SizedBox(height: Get.height * 0.022),
                Text("3.Work Experience", style: CommonTextStyles.medium20),
                SizedBox(height: Get.height * 0.004),
                Text(
                  "Your Professional Background",
                  style: CommonTextStyles.regular14.copyWith(
                    color: CommonColors.grey,
                  ),
                ),
                SizedBox(height: Get.height * 0.022),

                CommonTextField(
                  keyboardType: TextInputType.phone,
                  controller: controller.work,
                  label: 'Your Experience',
                  hintText: '',
                  isRequired: true,
                ),

                SizedBox(height: Get.height * 0.020),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Skill Certifications",
                      style: CommonTextStyles.regular16.copyWith(
                        color: CommonColors.secondary,
                      ),
                    ),
                    const SizedBox(height: 8),


                    DottedBorder(
                      options: RoundedRectDottedBorderOptions(
                        dashPattern: [8, 4],
                        strokeWidth: 1,
                        radius: Radius.circular(8),
                        color: CommonColors.grey.withAlpha(80),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          imagepicker();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: CommonColors.fileUpload,
                          ),
                          width: double.infinity,
                          height: controller.pickedSkilledImage==null? 42:200,
                          child:  controller.pickedSkilledImage == null
                              ? Center(
                            child: Text(
                              'Click to Upload',
                              style: CommonTextStyles.regular14,
                            ),
                          )
                              : ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              controller.pickedSkilledImage!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: 18,
          right: 18,
          bottom: MediaQuery.of(context).viewInsets.bottom + 40,
        ),
        child: CommonButton(
          backgroundColor: CommonColors.primaryColor,textColor: CommonColors.white,
          text: "Next",
          onTap: () {
            FocusScope.of(context).unfocus();
            if(controller.work.text.isNotEmpty){
              Get.to(()=>IdVerification(),transition: Transition.rightToLeft );
            }

            else{
              showCustomSnackBar(context: context, errorMessage: "Please Enter Work Experience");
            }

          },
        ),
      ),
    );
  }
}
