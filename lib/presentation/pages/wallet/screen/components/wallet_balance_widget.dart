import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text.dart';
import '../../controller/wallet_controller.dart';
class WalletBalanceWidget extends StatelessWidget {
  final WalletController controller;

  const WalletBalanceWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        // color: CommonColors.primaryColor,
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
              image: AssetImage("assets/images/ic_wallet_balance_bg.png"),
              fit: BoxFit.fill)
      ),
      height: 160, //MediaQuery.of(context).size.height * 0.16,
      child: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Your Balance",
                    style: CommonTextStyles.regular14.copyWith(
                      color: CommonColors.white,
                    ),
                  ),
                  Obx(() =>
                      Row(spacing: 14, children: [
                        Obx(() =>
                            Text(controller.showWalletBalance.value
                                ? "₹ ${controller.walletBalance.value}"
                                : "************",
                          style: CommonTextStyles.semiBold16.copyWith(
                              color: CommonColors.white, fontSize: 25),),),
                        GestureDetector(onTap: () {
                          controller.showWalletBalance.value =
                          !controller.showWalletBalance.value;
                        }, child: Icon(
                          controller.showWalletBalance.value ? Icons
                              .visibility_off_outlined : Icons
                              .remove_red_eye_outlined,
                          color: CommonColors.white,))
                      ]),),
                  GestureDetector(
                    onTap: controller.moveWalletRecharge,
                    child: IntrinsicWidth(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 11,
                        ),
                        decoration: BoxDecoration(
                          color: CommonColors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(spacing: 8, children: [
                          Text("Withdraw", style: CommonTextStyles.regular14,),
                          Icon(Icons.arrow_forward_ios_rounded, size: 15,)
                        ],),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
