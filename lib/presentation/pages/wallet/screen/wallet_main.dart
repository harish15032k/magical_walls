import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_text.dart';
import '../controller/wallet_controller.dart';
import 'components/wallet_balance_widget.dart';
import 'components/wallet_transaction_widget.dart';

class WalletMain extends StatelessWidget {
  const WalletMain({super.key});

  @override
  Widget build(BuildContext context) {
    final WalletController controller = Get.find<WalletController>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: Get.back,
                    child: Image.asset(
                      'assets/images/arrow-left.png',
                      width: 25,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text("Wallet", style: CommonTextStyles.medium20),
                ],
              ),
            ),
            Expanded(child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 14),
                child: Column(
                  children: [
                    Obx(() =>
                    !controller.isWalletTransactionFullScreen.value ?
                    WalletBalanceWidget(controller: controller) : SizedBox(),),
                    Obx(() =>
                        SizedBox(
                            height: controller.isWalletTransactionFullScreen
                                .value ? 0 : MediaQuery
                                .of(context)
                                .size
                                .height * 0.035),
                    ),
                    Expanded(
                      child: WalletTransactionWidget(controller: controller),),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
