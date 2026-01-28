import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magical_walls/core/constants/app_colors.dart';
import 'package:magical_walls/core/constants/app_text.dart';
import 'package:magical_walls/presentation/pages/profile/controller/profile_controller.dart';
import 'package:magical_walls/presentation/widgets/common_button.dart';

import '../model/support_reason_model.dart';

class HelpAndSupportScreen extends StatefulWidget {
  const HelpAndSupportScreen({super.key});

  @override
  State<HelpAndSupportScreen> createState() => _HelpAndSupportScreenState();
}

class _HelpAndSupportScreenState extends State<HelpAndSupportScreen> {
  final TextEditingController _messageController = TextEditingController();
ProfileController controller = Get.put(ProfileController());


  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      controller.isLoading.value = false;
      if (controller.supportReasonModelList.isEmpty) {
        await controller.getSupportReason(context);
        setState(() {

        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Image.asset(
                      'assets/images/arrow-left.png',
                      width: 25,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Help & Support",
                    style: CommonTextStyles.medium20,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Submit Ticket",style: CommonTextStyles.medium18,),
                    const SizedBox(height: 18),
                    Text("Query * ",style: CommonTextStyles.regular14,),
                    const SizedBox(height: 6),
                    DropdownButtonFormField2<SupportReasonModel>(
                      isExpanded: true,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: CommonColors
                                .textFieldGrey,)
                        ),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: CommonColors
                                .textFieldGrey,)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: CommonColors
                                .textFieldGrey,)
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 8,),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: CommonColors
                                .textFieldGrey,)
                        ),
                        // Add more decoration..
                      ),
                      hint:  Text(
                        'Select Your Query',
                        style: CommonTextStyles.regular12,
                      ),
                      items: controller.supportReasonModelList
                          .map((item) =>
                          DropdownMenuItem<SupportReasonModel>(
                            value: item,
                            child: Text(
                              item.reason ?? "",
                              style: CommonTextStyles.regular14,
                            ),
                          ))
                          .toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select Query';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        controller.supportReasonModel = value;
                      },

                      buttonStyleData: const ButtonStyleData(
                        padding: EdgeInsets.only(right: 8),
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black45,
                        ),
                        iconSize: 24,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(
                          color: CommonColors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.only(right: 20), child: Text(
                      "Help us with your concern in brief.*",
                      style: CommonTextStyles.regular16.copyWith(
                        color: CommonColors.black,
                      ),
                    ),),
                    const SizedBox(height: 8),
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: CommonColors.textFieldGrey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: CommonColors.textFieldGrey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: CommonColors.textFieldGrey),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Obx(()=>
                  CommonButton(
                    isLoading:controller.isLoading.value ,
                        text: "Send",
                        backgroundColor: CommonColors.primaryColor,
                        textColor: CommonColors.white,
                        onTap: () async{
                      FocusScope.of(context).unfocus();
                        await  controller.riseSupport(context, _messageController.text);
                          _messageController.clear();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}