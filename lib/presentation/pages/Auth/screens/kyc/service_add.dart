import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magical_walls/core/constants/app_colors.dart';
import 'package:magical_walls/core/constants/app_text.dart';
import 'package:magical_walls/core/utils/utils.dart';
import 'package:magical_walls/presentation/pages/Auth/screens/kyc/personal_details.dart';
import 'package:magical_walls/presentation/widgets/common_button.dart';
import 'package:magical_walls/presentation/widgets/common_textfield.dart';

class SelectService extends StatefulWidget {
  const SelectService({super.key});

  @override
  State<SelectService> createState() => _SelectServiceState();
}

class _SelectServiceState extends State<SelectService> {
  final TextEditingController _serviceController = TextEditingController();

  List<String> serviceList = [
    'Electrician',
    'Plumber',
    'Painter',
    'Carpenter',
    'Home Cleaning',
  ];

  String selectedService = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.white,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          ListView(
            children: [
              LinearProgressIndicator(
                value: .25,
                backgroundColor: Colors.grey.shade300,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
              ),

              SizedBox(height: Get.height * 0.01),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Get.height * 0.01),
                    Text(
                      "Technician Onboarding",
                      style: CommonTextStyles.medium20,
                    ),
                    SizedBox(height: Get.height * 0.01),
                    Text(
                      "We’ll need some documents to verify your profile.",
                      style: CommonTextStyles.regular14.copyWith(
                        color: CommonColors.grey,
                      ),
                    ),
                    SizedBox(height: Get.height * 0.022),
                    Text("1.Service", style: CommonTextStyles.medium20),
                    SizedBox(height: Get.height * 0.004),
                    Text(
                      "What Services Do You Provide?",
                      style: CommonTextStyles.regular14.copyWith(
                        color: CommonColors.grey,
                      ),
                    ),
                    SizedBox(height: Get.height * 0.022),

                    CommonTextField(
                      readonly: true,
                      controller: _serviceController,
                      label: 'Select Service',
                      hintText: '',
                      isRequired: true,
                    ),
                    SizedBox(height: Get.height * 0.020),

                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: serviceList.map((service) {
                        final isSelected = selectedService == service;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedService = service;
                              _serviceController.text = service;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: isSelected
                                  ? const Color(0xFF5D0491)
                                  : CommonColors.textFieldGrey,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            child: Text(
                              service,
                              style: CommonTextStyles.regular14.copyWith(
                                color: isSelected
                                    ? CommonColors.white
                                    : CommonColors.black,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ],
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 0, 18, 40),
              child: CommonButton(
                backgroundColor: CommonColors.primaryColor,textColor: CommonColors.white,
                text: "Next",
                onTap: () {
                  FocusScope.of(context).unfocus();
                  if(_serviceController.text.isNotEmpty){
                    Get.to(
                          () => PersonalDetails(),
                      transition: Transition.rightToLeft,
                    );
                  }
                  else{
                    showCustomSnackBar(context: context, errorMessage: "Choose any one service");
                  }

                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
