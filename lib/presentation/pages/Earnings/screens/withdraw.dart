import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magical_walls/core/constants/app_colors.dart';
import 'package:magical_walls/core/constants/app_text.dart';
import 'package:magical_walls/presentation/pages/Earnings/controller/earnings_controller.dart';
import 'package:magical_walls/presentation/widgets/common_button.dart';
import 'package:magical_walls/presentation/widgets/common_textfield.dart';

import '../../../../core/utils/utils.dart';

class WithdrawScreen extends StatefulWidget {
  final dynamic totalEarnings;
  const WithdrawScreen({super.key, this.totalEarnings});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  final TextEditingController _amountController = TextEditingController();

  EarningsController controller = Get.put(EarningsController());

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
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
                  Text("Withdraw", style: CommonTextStyles.medium20),
                ],
              ),
              const SizedBox(height: 18),
              Text(
                "Available Balance: ₹${widget.totalEarnings}",
                style: CommonTextStyles.regular18.copyWith(
                  color: CommonColors.black,
                ),
              ),
              const SizedBox(height: 18),
              CommonTextField(
                keyboardType: TextInputType.number,
                label: 'Enter Amount to Withdraw',
                hintText: '',
                isRequired: true,
                controller: _amountController,
              ),

              const SizedBox(height: 16),

              Text(
                "Payment Method",
                style: CommonTextStyles.regular16.copyWith(
                  color: CommonColors.secondary,
                ),
              ),
              Text(
                "Bank",
                style: CommonTextStyles.regular18.copyWith(
                  color: CommonColors.black,
                ),
              ),
              const SizedBox(height: 16),
              Obx(
                () => CommonButton(
                  isLoading: controller.isLoading.value,
                  text: "Withdraw",
                  backgroundColor: CommonColors.primaryColor,
                  textColor: CommonColors.white,
                  onTap: () {
                    FocusScope.of(context).unfocus();

                    if (_amountController.text.isEmpty) {
                      showCustomSnackBar(
                        context: context,
                        errorMessage: 'Enter an amount',
                      );
                      return;
                    }

                    final enteredAmount = double.tryParse(_amountController.text) ?? 0;
                    final totalEarnings = double.tryParse(widget.totalEarnings.toString()) ?? 0;

                    if (enteredAmount > totalEarnings) {
                      showCustomSnackBar(
                        context: context,
                        errorMessage: 'Insufficient balance',
                      );
                      return;
                    }

                    if (enteredAmount <= 0) {
                      showCustomSnackBar(
                        context: context,
                        errorMessage: 'Please enter a valid amount',
                      );
                      return;
                    }

                    controller.withdrawRequest(
                      _amountController.text,
                      context,
                    );
                  },

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
