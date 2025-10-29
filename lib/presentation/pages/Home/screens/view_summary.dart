import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magical_walls/presentation/pages/Home/model/Completed_order_model.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text.dart';

class CompletedJobScreen extends StatefulWidget {
  final Datum? orderCompletedRes;

  const CompletedJobScreen({super.key, this.orderCompletedRes});

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
                          widget.orderCompletedRes?.serviceType ?? "",
                          'Booking ID:',
                          "#BK${widget.orderCompletedRes?.bookingId ?? ""}",
                        ),
                        const SizedBox(height: 12),
                        _twoColumnRow(
                          'Date:',
                          widget.orderCompletedRes?.bookingDate ?? "",
                          'Time Slot:',
                          widget.orderCompletedRes?.timeSlot ?? "",
                        ),
                        const SizedBox(height: 12),
                        _twoColumnRow(
                          'Completed On:',
                          widget.orderCompletedRes?.completedOn ?? "",
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
                          widget.orderCompletedRes?.customerInformation?.name ??
                              "",
                          'Phone Number:',
                          widget.orderCompletedRes?.customerInformation
                              ?.phoneNumber ?? "",
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Address:',
                          style: CommonTextStyles.regular14.copyWith(
                            color: CommonColors.secondary,
                          ),
                        ),
                        Text(
                          "${ widget.orderCompletedRes?.customerInformation
                              ?.address?.address ?? ""},${ widget
                              .orderCompletedRes?.customerInformation?.address
                              ?.city ?? ""},${ widget.orderCompletedRes
                              ?.customerInformation?.address?.pinCode ?? ""}",
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
                          '₹ ${widget.orderCompletedRes?.paymentInfo
                              ?.grantAmount ?? ""}',
                          'Payment Mode:',
                          widget.orderCompletedRes?.paymentInfo?.paymentMode ??
                              "",
                        ),
                        const SizedBox(height: 12),
                        _twoColumnRow(
                          'Payment Status:',
                          widget.orderCompletedRes?.paymentInfo
                              ?.paymentStatus ?? "",
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
                          widget.orderCompletedRes?.serviceType ?? "",
                          style: CommonTextStyles.regular16,
                        ),
                        Text(
                          widget.orderCompletedRes?.technicianNotes ?? "",
                          style: CommonTextStyles.regular12.copyWith(color: CommonColors.secondary),
                        ),
                        const SizedBox(height: 16),
                        ListView.separated(separatorBuilder: (c, p) =>
                        const SizedBox(height: 5,),
                            itemCount: widget.orderCompletedRes?.workChecklist
                                ?.length ?? 0,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (c, p) {
                              WorkChecklist? work = widget.orderCompletedRes
                                  ?.workChecklist?[p];
                              return Text('• ${work?.name ?? ""}',
                                style: CommonTextStyles.regular14,);
                            }),


                        const SizedBox(height: 20),


                        Image.network(
                          widget.orderCompletedRes?.uploadedPhotos?.first ?? "",
                          height: 80, errorBuilder: (c, e, t) => SizedBox(),
                        ),
                        const SizedBox(height: 16),

                        if(widget.orderCompletedRes
                            ?.customerRatingFeedback?.ratingText?.isNotEmpty ==
                            true)
                          Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                        Text(
                          'Customer Rating & Feedback',
                          style: CommonTextStyles.medium16,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Row(
                              children: List.generate(5, (i) =>
                                  Icon(Icons.star,
                                      color: i < double.tryParse(
                                          widget.orderCompletedRes
                                              ?.customerRatingFeedback
                                              ?.ratingText
                                              ?.first.rating ?? "0")! ? Colors
                                          .amber : Colors.grey,
                                      size: 20),),),
                            const SizedBox(width: 10),
                            Text('${widget.orderCompletedRes
                                ?.customerRatingFeedback?.ratingText
                                ?.first.rating ?? "0"}/5',
                                style: CommonTextStyles.medium20),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.orderCompletedRes
                              ?.customerRatingFeedback?.ratingText
                              ?.first.review ?? "",
                          style: CommonTextStyles.regular14.copyWith(color: CommonColors.secondary),
                        ),
                            ],),
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