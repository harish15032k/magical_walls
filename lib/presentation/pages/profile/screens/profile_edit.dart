import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:magical_walls/core/constants/app_colors.dart';
import 'package:magical_walls/core/constants/app_text.dart';
import 'package:magical_walls/presentation/pages/profile/controller/profile_controller.dart';
import 'package:magical_walls/presentation/widgets/common_button.dart';

import '../../../widgets/common_textfield.dart';
import 'package:magical_walls/presentation/pages/profile/model/profile_model.dart';


class ProfileEdit extends StatefulWidget {
  Data data;
   ProfileEdit({super.key,required this.data});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  bool _isAvailable = true;

  ProfileController controller = Get.put(ProfileController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.data.dob != null && widget.data.dob!.isNotEmpty) {
      try {
        DateTime parsedDate = DateTime.parse(widget.data.dob!);
        controller.dob.text =
        "${parsedDate.day}/${parsedDate.month.toString().padLeft(2, '0')}/${parsedDate.year}";
      } catch (e) {
        controller.dob.text = widget.data.dob ?? '';
      }
    } else {
      controller.dob.text = '';
    }
    controller.name.text=widget.data.name??'';
    controller.mobile.text=widget.data.phone??'';
    controller.Address.text=widget.data.email??'';
  }
  Future<void> imagePicker() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        controller.pickedProfileImage = File(pickedFile.path);
      });
    }
  }
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
        child: Obx(()=>
           CommonButton(
             isLoading: controller.isLoading.value,
            text: "Save Changes",
          backgroundColor: CommonColors.primaryColor,
            textColor: CommonColors.white,

            onTap: () {

               controller.updateProfile(context);
            },
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
                    backgroundColor: CommonColors.primaryColor.withOpacity(0.2),
                    backgroundImage: controller.pickedProfileImage != null
                        ? FileImage(controller.pickedProfileImage!)
                        : (widget.data.technicianImage != null && widget.data.technicianImage!.isNotEmpty)
                        ? NetworkImage(widget.data.technicianImage!) as ImageProvider
                        : null,
                    child: Stack(
                      children: [

                        if (controller.pickedProfileImage == null &&
                            (widget.data.technicianImage == null || widget.data.technicianImage!.isEmpty))
                          Center(
                            child: Text(
                              widget.data.name != null && widget.data.name!.length >= 2
                                  ? widget.data.name!.substring(0, 2).toUpperCase()
                                  : (widget.data.name?.substring(0, 1).toUpperCase() ?? ''),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),

                        Align(
                          alignment: Alignment.bottomRight,
                          child: GestureDetector(
                            onTap: () {
                              imagePicker();
                            },
                            child: Image.asset(
                              'assets/images/edit.png',
                              width: 24,
                              height: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),


              const SizedBox(height: 24),
              CommonTextField(
                controller: controller.name,
                label: 'Full Name',
                hintText: '',
                isRequired: true,
              ),

              SizedBox(height: Get.height * 0.020),
              CommonTextField(
                controller: controller.mobile,
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
                controller: controller.dob,
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
                    controller.dob.text = "${picked.day}/${picked.month}/${picked.year}";
                  }
                },

                hintText: '',
                isRequired: true,
              ),
              SizedBox(height: Get.height * 0.020),
              CommonTextField(
                controller: controller.Address,
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
