import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magical_walls/core/constants/app_colors.dart';
import 'package:magical_walls/core/constants/app_text.dart';
import 'package:magical_walls/presentation/widgets/aadhar_file.dart';
import 'package:magical_walls/presentation/widgets/common_button.dart';
import 'package:magical_walls/presentation/widgets/common_textfield.dart';



import 'dart:io';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/utils/utils.dart';
import 'bank_details.dart';

class IdVerification extends StatefulWidget {
  const IdVerification({super.key});

  @override
  State<IdVerification> createState() => _IdVerificationState();
}

class _IdVerificationState extends State<IdVerification> {
  final TextEditingController work = TextEditingController();
  File? _pickedImage;
  String? _selectedAadhaarFile;

  Future<void> imagepicker() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
    }
  }


  void _onAadhaarFileSelected(String? fileName) {
    setState(() {
      _selectedAadhaarFile = fileName;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.white,
      resizeToAvoidBottomInset: true,
      body: ListView(
        children: [
          LinearProgressIndicator(
            value: .80,
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
                Text("4.ID Verification", style: CommonTextStyles.medium20),
                SizedBox(height: Get.height * 0.004),
                Text(
                  "Verify Your Identity",
                  style: CommonTextStyles.regular14.copyWith(
                    color: CommonColors.grey,
                  ),
                ),
                SizedBox(height: Get.height * 0.022),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Aadhar Card",
                          style: CommonTextStyles.regular16.copyWith(
                            color: CommonColors.secondary,
                          ),
                        ),
                        const SizedBox(width: 2),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 3),
                          child: Icon(Icons.star, color: Colors.red, size: 6),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    AadhaarUploadWidget(onFileSelected: _onAadhaarFileSelected),
                  ],
                ),
                SizedBox(height: Get.height * 0.020),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Pan Card",
                          style: CommonTextStyles.regular16.copyWith(
                            color: CommonColors.secondary,
                          ),
                        ),
                        const SizedBox(width: 2),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 3),
                          child: Icon(Icons.star, color: Colors.red, size: 6),
                        ),
                      ],
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
                          height: _pickedImage == null ? 42 : 200,
                          child: _pickedImage == null
                              ? Center(
                            child: Text(
                              'Click to Upload',
                              style: CommonTextStyles.regular14,
                            ),
                          )
                              : ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              _pickedImage!,
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

            if (_selectedAadhaarFile == null && _pickedImage == null) {
              showCustomSnackBar(
                context: context,
                errorMessage: "Please upload both Aadhaar and PAN card.",
              );
            } else if (_selectedAadhaarFile == null) {
              showCustomSnackBar(
                context: context,
                errorMessage: "Please upload Aadhaar card.",
              );
            } else if (_pickedImage == null) {
              showCustomSnackBar(
                context: context,
                errorMessage: "Please upload PAN card.",
              );
            } else {

               Get.to(() => BankDetails(), transition: Transition.rightToLeft);
            }
          },
        ),
      ),
    );
  }
}
