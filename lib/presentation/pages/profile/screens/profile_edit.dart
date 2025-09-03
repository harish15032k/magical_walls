import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magical_walls/core/constants/app_colors.dart';
import 'package:magical_walls/core/constants/app_text.dart';
import 'package:magical_walls/presentation/widgets/common_button.dart';

import '../../../widgets/common_textfield.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  bool _isAvailable = true;
  final TextEditingController dob = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController mobile = TextEditingController();
  final TextEditingController Address = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.white,
      bottomNavigationBar:  Padding(
        padding: EdgeInsets.only(
          left: 18,
          right: 18,
          bottom: MediaQuery.of(context).viewInsets.bottom + 40,
        ),
        child: CommonButton(
          text: "Save Changes",
        backgroundColor: CommonColors.primaryColor,
          textColor: CommonColors.white,

          onTap: () {},
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(

                children: [  GestureDetector(
                  onTap: () => Get.back(),
                  child: Image.asset(
                    'assets/images/arrow-left.png',
                    width: 25,
                  ),
                ),
                  const SizedBox(width: 8), Text("Edit Profile", style: CommonTextStyles.medium20)],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/man.png'),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Image.asset(
                        'assets/images/edit.png',
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),



                ],
              ),
              const SizedBox(height: 24),
              CommonTextField(
                controller: name,
                label: 'Full Name',
                hintText: '',
                isRequired: true,
              ),

              SizedBox(height: Get.height * 0.020),
              CommonTextField(
                controller: mobile,
                label: 'Mobile Number',
                hintText: '',
                isRequired: true,
              ),

              SizedBox(height: Get.height * 0.020),
              CommonTextField(
                readonly: true,

                suffixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset("assets/images/calendar.png", width: 5),
                ),
                controller: dob,
                label: 'Date Of Birth',
                onSuffixTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.light(
                            primary: CommonColors.primaryColor,
                            onPrimary: Colors.white,
                            onSurface: CommonColors.secondary,
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              foregroundColor: CommonColors.primaryColor,
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );

                  if (picked != null) {
                    dob.text = "${picked.day}/${picked.month}/${picked.year}";
                  }
                },

                hintText: '',
                isRequired: true,
              ),
              SizedBox(height: Get.height * 0.020),
              CommonTextField(
                controller: Address,
                keyboardType: TextInputType.emailAddress,
                label: 'Email Address',
                hintText: '',
                isRequired: true,
              ),


              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }


}
