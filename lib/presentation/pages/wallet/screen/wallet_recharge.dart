import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text.dart';
import '../../../widgets/common_button.dart';
import '../controller/wallet_controller.dart';

class WalletRecharge extends StatelessWidget {
  final WalletController controller;

  const WalletRecharge({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                  Text('Wallet Recharge', style: CommonTextStyles.medium20),
                ],
              ),
              const SizedBox(height: 16),
              Text("Add Money", style: CommonTextStyles.medium18),
              borderContainer(
                context: context,
                margin: const EdgeInsets.only(top: 10, bottom: 16),
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Available balance :",
                      style: CommonTextStyles.regular14.copyWith(
                        color: CommonColors.secondary,
                      ),
                    ),
                 Obx(()=>   Text(
                      "₹ ${controller.walletBalance.value}",
                      style: CommonTextStyles.regular14.copyWith(
                        color: CommonColors.secondary,
                      ),
                    ),),
                  ],
                ),
              ),
              borderContainer(
                context: context,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Enter Amount",
                      style: CommonTextStyles.regular14.copyWith(
                        color: CommonColors.secondary,
                      ),
                    ),
                    TextField(keyboardType: TextInputType.number,
                      controller: controller.walletRechargeController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                      cursorColor: CommonColors.primaryColor,
                      onChanged: (v) {
                        if (controller.walletRechargeController.text.isEmpty) {
                          controller.walletRechargeController.text = "₹ $v";
                        }else{
                          controller.walletRechargeController.text = v;
                        }
                        controller.selectedRechargeValue.value =
                            controller.walletRechargeController.text.replaceAll(
                                "₹ ", '');

                      },
                      style: CommonTextStyles.regular18.copyWith(fontSize: 30),
                    ),
                  ],
                ),
              ),
              Obx(
                () => Wrap(
                  children: List.generate(10, (i) {
                    final String value = "${500 * (i + 1)}";
                    return GestureDetector(
                      onTap: () {
                        controller.selectedRechargeValue.value = value;
                        controller.walletRechargeController.text = "₹ $value";
                      },
                      child: borderContainer(
                        margin: const EdgeInsets.only(top: 14, right: 20),
                        context: context,
                        isSkipWidth: true,
                        padding: const EdgeInsets.symmetric(
                          vertical: 9,
                          horizontal: 16,
                        ),
                        child: Text(value),
                        isSelected:
                            value == controller.selectedRechargeValue.value,
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 14,),
              Obx(() =>CommonButton(
                  onTap: () {
                    if (controller.selectedRechargeValue.value.isNotEmpty) {
                      controller.addCustomerWalletPayment(
                        context: context,
                        amount: controller.selectedRechargeValue.value,
                      );
                    }
                  },
                  text: "Proceed to pay",
                    backgroundColor: controller.selectedRechargeValue.value
                        .isEmpty ||
                        controller.selectedRechargeValue.value == '0'
                        ? CommonColors.grey
                        : CommonColors.primaryColor,
                textColor: CommonColors.white,

                  ),),
            ],
          ),
        ),
      ),
    );
  }

  Widget borderContainer({
    required BuildContext context,
    required Widget child,
    EdgeInsets? padding,
    EdgeInsets? margin,
    bool? isSkipWidth,
    bool isSelected = false,
  }) {
    return Container(
      width: isSkipWidth == true ? null : MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? CommonColors.black : CommonColors.textFieldGrey,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: padding ?? const EdgeInsets.all(8),
      margin: margin,
      child: child,
    );
  }
}
