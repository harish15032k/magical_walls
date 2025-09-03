import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magical_walls/core/constants/app_colors.dart';
import 'package:magical_walls/core/constants/app_text.dart';
import 'package:magical_walls/core/utils/utils.dart';
import 'package:magical_walls/presentation/pages/Auth/screens/kyc/profile_review.dart';
import 'package:magical_walls/presentation/widgets/common_button.dart';
import 'package:magical_walls/presentation/widgets/common_textfield.dart';

class BankDetails extends StatefulWidget {
  const BankDetails({super.key});

  @override
  State<BankDetails> createState() => _BankDetailsState();
}

class _BankDetailsState extends State<BankDetails> {
  final TextEditingController accountHolderName = TextEditingController();
  final TextEditingController bank = TextEditingController();
  final TextEditingController accountNumber = TextEditingController();
  final TextEditingController ifscCode = TextEditingController();
  bool isTermsAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.white,
      resizeToAvoidBottomInset: true,
      body: ListView(
        children: [
          LinearProgressIndicator(
            value: 100,
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
                Text("5.Bank Details", style: CommonTextStyles.medium20),
                SizedBox(height: Get.height * 0.004),
                Text(
                  "We use this account to send your earnings.",
                  style: CommonTextStyles.regular14.copyWith(
                    color: CommonColors.grey,
                  ),
                ),
                SizedBox(height: Get.height * 0.022),
                CommonTextField(
                  controller: accountHolderName,
                  label: 'Account Holder Name',
                  hintText: '',
                  isRequired: true,
                ),
                SizedBox(height: Get.height * 0.020),
                CommonTextField(
                  controller: bank,
                  label: 'Bank',
                  hintText: '',
                  isRequired: true,
                ),
                SizedBox(height: Get.height * 0.020),
                CommonTextField(
                  controller: accountNumber,
                  label: 'Account Number',
                  hintText: '',
                  isRequired: true,
                ),
                SizedBox(height: Get.height * 0.020),
                CommonTextField(
                  controller: ifscCode,
                  label: 'IFSC Code',
                  hintText: '',
                  isRequired: true,
                ),
                SizedBox(height: Get.height * 0.180),
                Row(
                  children: [
                    Checkbox(
                      hoverColor: CommonColors.primaryColor,
                      activeColor: CommonColors.primaryColor,
                      checkColor: CommonColors.white,
                      value: isTermsAccepted,
                      onChanged: (value) {
                        setState(() {
                          isTermsAccepted = value ?? false;
                        });
                      },
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isTermsAccepted = !isTermsAccepted;
                          });
                        },
                        child: Text(
                          "Please review and accept our technician partner guidelines and payment terms.",
                          style: CommonTextStyles.regular14.copyWith(
                            color: CommonColors.secondary,
                            decoration: TextDecoration.underline,
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
            if (accountHolderName.text.isEmpty ||
                accountNumber.text.isEmpty ||
                ifscCode.text.isEmpty ||
                !isTermsAccepted) {
              showCustomSnackBar(
                context: context,
                errorMessage: "Fill all fields and accept terms",
              );
            } else {
              Get.to(
                () => ProfileUnderReview(),
                transition: Transition.rightToLeft,
              );
            }
          },
        ),
      ),
    );
  }
}
