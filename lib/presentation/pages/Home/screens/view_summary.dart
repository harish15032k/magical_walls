import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text.dart';
import '../../../widgets/common_button.dart';

class CompletedJobScreen extends StatefulWidget {

  CompletedJobScreen({super.key, });

  @override
  State<CompletedJobScreen> createState() => _CompletedJobScreenState();
}

class _CompletedJobScreenState extends State<CompletedJobScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          child: SingleChildScrollView(
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
                      'Job Detail',
                      style: CommonTextStyles.medium20.copyWith(
                        color: CommonColors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: CommonColors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: CommonColors.textFieldGrey,
                      width: 1,
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Booking Info
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Booking Information',
                              style: CommonTextStyles.medium16,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: CommonColors.green.withAlpha(30),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                'Completed',
                                style: CommonTextStyles.medium14.copyWith(
                                  color: CommonColors.green,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _twoColumnRow(
                          'Service Type:',
                          'AC Repair - Gas Refill',
                          'Booking ID:',
                          "#BK034523",
                        ),
                        const SizedBox(height: 12),
                        _twoColumnRow(
                          'Date:',
                          '25 July 2025',
                          'Time Slot:',
                          '10 AM - 12 PM',
                        ),
                        const SizedBox(height: 12),
                        _twoColumnRow(
                          'Completed On:',
                          '26 July 2025 - 03:45 PM',
                          '',
                          '',
                        ),
                        const SizedBox(height: 16),
                        Divider(color: CommonColors.textFieldGrey),
            

                        Text(
                          'Customer Information',
                          style: CommonTextStyles.medium16,
                        ),
                        const SizedBox(height: 12),
                        _twoColumnRow(
                          'Name:',
                          'Ravi Kumar',
                          'Phone Number:',
                          '+91 9384772736',
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Address:',
                          style: CommonTextStyles.regular14.copyWith(
                            color: CommonColors.secondary,
                          ),
                        ),
                        Text(
                          'Flat 202, Lotus Apartments, Chennai',
                          style: CommonTextStyles.medium14,
                        ),
                        const SizedBox(height: 16),
                        Divider(color: CommonColors.textFieldGrey),
            

                        Text(
                          'Payment Info',
                          style: CommonTextStyles.medium16,
                        ),
                        const SizedBox(height: 12),
                        _twoColumnRow(
                          'Total Amount:',
                          '₹1200',
                          'Payment Mode:',
                          'UPI',
                        ),
                        const SizedBox(height: 12),
                        _twoColumnRow(
                          'Payment Status:',
                          'Paid',
                          '',
                          '',
                        ),
                        const SizedBox(height: 16),
                        Divider(color: CommonColors.textFieldGrey),
            

                        Text(
                          'Technician Notes',
                          style: CommonTextStyles.medium16,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Gas refill for split AC.',
                          style: CommonTextStyles.regular16,
                        ),
                        Text(
                          'Replaced low gas and tested cooling. Customer satisfied.',
                          style: CommonTextStyles.regular12.copyWith(color: CommonColors.secondary),
                        ),
                        const SizedBox(height: 16),
            

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('• Inspect the AC Unit',style: CommonTextStyles.regular14,),
                            SizedBox(height: 5,),
                            Text('• Identify Gas Leakage',style: CommonTextStyles.regular14,),
                            SizedBox(height: 5,),
                            Text('• Refill Gas Cylinder',style: CommonTextStyles.regular14,),
                            SizedBox(height: 5,),

                            Text('• Test Cooling',style: CommonTextStyles.regular14,),
                            SizedBox(height: 5,),
                            Text('• Customer Approval',style: CommonTextStyles.regular14,),
                          ]
                        ),
                        const SizedBox(height: 20),
            

                        Image.asset(
                          'assets/images/ac.png',
                          height: 80,
                        ),
                        const SizedBox(height: 16),
            

                        Text(
                          'Customer Rating & Feedback',
                          style: CommonTextStyles.medium16,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 20),
                            const Icon(Icons.star, color: Colors.amber, size: 20),
                            const Icon(Icons.star, color: Colors.amber, size: 20),
                            const Icon(Icons.star, color: Colors.amber, size: 20),
                            const Icon(Icons.star, color: Colors.amber, size: 20),
                            const SizedBox(width: 10),
                            Text('5/5', style: CommonTextStyles.medium20),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Quick and professional service. Thank you!',
                          style: CommonTextStyles.regular14.copyWith(color: CommonColors.secondary),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _twoColumnRow(
      String leftLabel,
      String leftValue,
      String rightLabel,
      String rightValue,
      ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                leftLabel,
                style: CommonTextStyles.regular14.copyWith(
                  color: CommonColors.secondary,
                ),
              ),
              const SizedBox(height: 2),
              SizedBox(
                width: 120,
                child: Text(leftValue, style: CommonTextStyles.medium14),
              ),
            ],
          ),
        ),
        SizedBox(width: 100),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (rightLabel.isNotEmpty) ...[
                Text(
                  rightLabel,
                  style: CommonTextStyles.regular14.copyWith(
                    color: CommonColors.secondary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(rightValue, style: CommonTextStyles.medium14),
              ],
            ],
          ),
        ),
      ],
    );
  }
}