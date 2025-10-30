import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magical_walls/core/constants/app_colors.dart';
import 'package:magical_walls/core/constants/app_text.dart';
import 'package:magical_walls/core/utils/utils.dart';
import 'package:magical_walls/presentation/pages/Auth/controller/auth_controller.dart';
import 'package:magical_walls/presentation/pages/Auth/screens/kyc/work_experience.dart';
import 'package:magical_walls/presentation/widgets/common_button.dart';
import 'package:magical_walls/presentation/widgets/common_textfield.dart';

import '../../../../widgets/common_droplist.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({super.key});

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  final AuthController controller = Get.put(AuthController());

  bool isgenderclicked=false;
  bool islanguageclicked=false;
List<String> Gender =['Male','Female'];
List<String> Language =['English','Tamil','Telugu','Hindi','English','Tamil','Telugu','Hindi'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.white,
      resizeToAvoidBottomInset: true,
      body: ListView(
        children: [
          LinearProgressIndicator(
            value: .45,
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
                Text("1.Personal Details", style: CommonTextStyles.medium20),
                SizedBox(height: Get.height * 0.004),
                Text(
                  "Tell Us About You",
                  style: CommonTextStyles.regular14.copyWith(
                    color: CommonColors.grey,
                  ),
                ),
                SizedBox(height: Get.height * 0.022),

                CommonTextField(
                  controller: controller.name,
                  label: 'Full Name',
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
                  readonly: true,
                  ontap: (){
                    setState(() {
                      isgenderclicked=!isgenderclicked;
                    });
                  },
                  onSuffixTap: (){
                    setState(() {
                      isgenderclicked=!isgenderclicked;
                    });

                  },
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset("assets/images/arrowdown.png", width: 5),
                  ),
                  controller: controller.gender,
                  label: 'Gender',
                  hintText: '',
                  isRequired: true,
                ),
                SizedBox(height: Get.height * 0.010),
                isgenderclicked?  CommonSelectionList(
                  items: Gender,
                  onSelect: (gen) {
                    setState(() {
                      controller.gender.text = gen;
                      isgenderclicked = false;
                    });
                  },
                )
                    :SizedBox.shrink(),


              SizedBox(height: Get.height * 0.020),
                CommonTextField(
                  ontap: (){
                    setState(() {
                      islanguageclicked=!islanguageclicked;
                    });
                  },
                  onSuffixTap: (){
                    setState(() {
                      islanguageclicked=!islanguageclicked;
                    });

                  },
                  readonly: true,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset("assets/images/arrowdown.png", width: 5),
                  ),
                  controller: controller.lang,
                  label: 'Language Spoken',
                  hintText: '',
                  isRequired: true,
                ),
                SizedBox(height: Get.height * 0.010),
                islanguageclicked?  CommonSelectionList(
                  items: Language,
                  onSelect: (gen) {
                    setState(() {
                      controller.lang.text = gen;
                      islanguageclicked = false;
                    });
                  },
                )
                    :SizedBox.shrink(),
                SizedBox(height: Get.height * 0.020),
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
            if(controller.name.text.isEmpty||controller.dob.text.isEmpty||controller.gender.text.isEmpty||controller.lang.text.isEmpty){
              showCustomSnackBar(context: context, errorMessage: "Fill All Fields");
            }

            else{
              Get.to(()=>WorkDetails(),transition: Transition.rightToLeft);
            }

          },
        ),
      ),
    );
  }
}
