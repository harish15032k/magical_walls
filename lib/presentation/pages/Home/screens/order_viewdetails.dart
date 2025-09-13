import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text.dart';
import '../../../widgets/common_button.dart';


class JobDetailsScreen extends StatefulWidget {
  final Map<String, String?> job;
  late  bool isaccept;

   JobDetailsScreen({super.key, required this.job,this.isaccept=false});

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header Row
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
                              color: CommonColors.blue.withAlpha(30),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'Upcoming',
                              style: CommonTextStyles.medium14.copyWith(
                                color: CommonColors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _twoColumnRow(
                        'Service Type:',
                        widget.job['type'] ?? '',
                        'Booking ID:',
                        "#${widget.job['id'] ?? ''}",
                      ),
                      const SizedBox(height: 12),
                      _twoColumnRow(
                        'Date:',
                        widget.job['date'] ?? '',
                        'Time Slot:',
                        widget.job['timeSlot'] ?? '',
                      ),

                      const SizedBox(height: 16),
                      Divider(color: CommonColors.textFieldGrey),

                      /// Customer Info
                      Text(
                        'Customer Information',
                        style: CommonTextStyles.medium16,
                      ),
                      const SizedBox(height: 12),
                      _twoColumnRow(
                        'Name:',
                        widget.job['customer'] ?? '',
                        'Phone Number:',
                        '+91 9384712736',
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Address:',
                        style: CommonTextStyles.regular14.copyWith(
                          color: CommonColors.secondary,
                        ),
                      ),
                      Text(
                        widget.job['address'] ?? '',
                        style: CommonTextStyles.medium14,
                      ),

                      const SizedBox(height: 16),
                      Divider(color: CommonColors.textFieldGrey),

                      /// Service Details
                      Text('Service Details', style: CommonTextStyles.medium16),
                      const SizedBox(height: 12),
                      _twoColumnRow(
                        'Task Name:',
                        'Gas Refill',
                        'Duration:',
                        '1.5 – 2 hours',
                      ),
                      const SizedBox(height: 12),
                      _twoColumnRow(
                        'Tools Required:',
                        'AC Pressure Gauge, Gas Refill Kit',
                        'Assigned Technician:',
                        'Ramesh Kumar (you)',
                      ),
                      const SizedBox(height: 12),
                      _twoColumnRow('Service Price:', '₹1,499', '', ''),
                      const SizedBox(height: 12),
                      Text(
                        'Please reach the customer’s location 10–15 minutes before the time slot.',
                        style: CommonTextStyles.regular14.copyWith(
                          color: CommonColors.grey,
                        ),
                      ),
                      const SizedBox(height: 24),

                       widget.isaccept==false
                          ? CommonButton(
                              backgroundColor: CommonColors.primaryColor,
                              textColor: CommonColors.white,
                              text: 'Accept',
                              onTap: () {
                                setState(() {
                            widget.isaccept=true;
                                });
                              },
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: CommonButton(
                                    isimageneed: true,
                                    imagefile: 'assets/images/call-calling.png',
                                    text: 'Call Customer',
                                    backgroundColor: Colors.transparent,
                                    textColor: CommonColors.purple,
                                    borderColor: CommonColors.purple,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: CommonButton(
                                    onTap: (){
                                      // Get.to(()=>StartJobOtp(),transition:Transition.topLevel);
                                    },
                                    backgroundColor: CommonColors.primaryColor,
                                    textColor: CommonColors.white,

                                    text: 'Start Job',
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
            ],
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

        /// Right side
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
