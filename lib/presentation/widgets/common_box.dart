import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magical_walls/core/constants/app_colors.dart';
import 'package:magical_walls/core/constants/app_text.dart';
import 'package:magical_walls/presentation/pages/Home/screens/markas_completed_screen.dart';

import '../pages/Home/screens/view_summary.dart';
import 'common_button.dart';

class CommonBox extends StatelessWidget {
  final String? tab;
  final String jobId;
  final String jobType;
  final String customerName;
  final String date;
  final String timeSlot;
  final String address;
  final VoidCallback? onAccept;
  final VoidCallback? onReject;
  final bool? isLoadingAccept;
  final bool? isLoadingReject;

  const CommonBox({
    super.key,
    required this.jobId,
    required this.jobType,
    required this.customerName,
    required this.date,
    required this.timeSlot,
    required this.address,
    this.onAccept,
    this.onReject,
    this.tab,
    this.isLoadingAccept,
    this.isLoadingReject,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: CommonColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: CommonColors.textFieldGrey, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: CommonColors.purple.withAlpha(30),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                '#BKID $jobId',
                style: CommonTextStyles.regular12.copyWith(
                  color: CommonColors.purple,
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            jobType,
            style: CommonTextStyles.medium18.copyWith(
              color: CommonColors.black,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Customer',
                    style: CommonTextStyles.regular14.copyWith(
                      color: CommonColors.secondary,
                    ),
                  ),
                  Text(customerName, style: CommonTextStyles.medium14),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date',
                    style: CommonTextStyles.regular14.copyWith(
                      color: CommonColors.secondary,
                    ),
                  ),
                  Text(date, style: CommonTextStyles.medium14),
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Time Slot',
                    style: CommonTextStyles.regular14.copyWith(
                      color: CommonColors.secondary,
                    ),
                  ),
                  Text(timeSlot, style: CommonTextStyles.regular14),
                ],
              ),
            ],
          ),
          const SizedBox(height: 4),

          const SizedBox(height: 8),
          Text(
            'Address',
            style: CommonTextStyles.regular14.copyWith(
              color: CommonColors.secondary,
            ),
          ),
          const SizedBox(height: 4),
          Text(address, style: CommonTextStyles.medium14),
          const SizedBox(height: 12),
          (tab == 'ongoing' || tab == 'completed')
              ? CommonButton(
            onTap: (){
              tab=='ongoing'?Get.to(()=>MarkAsCompleted(jobType: jobType,id: jobId,)):Get.to(()=>CompletedJobScreen());
            },
                  backgroundColor: CommonColors.primaryColor,
                  textColor: CommonColors.white,
                  text: tab == 'ongoing' ? "Mark as Completed" : "View Summary",
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: CommonButton(
                        isLoading: isLoadingReject??false,
                        text: 'Reject',
                        backgroundColor: Colors.transparent,
                        textColor: CommonColors.purple,
                        borderColor: CommonColors.purple,
                        onTap: onReject,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: CommonButton(
                        isLoading: isLoadingAccept??false,
                        backgroundColor: CommonColors.primaryColor,
                        textColor: CommonColors.white,

                        text: 'Accept',
                        onTap: onAccept,
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
