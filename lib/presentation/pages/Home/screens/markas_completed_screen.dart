import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text.dart';
import '../../../widgets/common_button.dart';
import '../controller/home_controller.dart';

class MarkAsCompleted extends StatefulWidget {
  final dynamic id;
  final String jobType;
  const MarkAsCompleted({super.key, required this.id, required this.jobType});

  @override
  State<MarkAsCompleted> createState() => _MarkAsCompletedState();
}

class _MarkAsCompletedState extends State<MarkAsCompleted> {
  final List<bool> _checklist = [false, false, false, false, false];

  HomeController controller = Get.put(HomeController());
  Future<void> imagePicker() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      setState(() {
        controller.markAsCompletedImage = File(pickedFile.path);
      });
    }
  }

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
              /// Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Image.asset(
                          'assets/images/arrow-left.png',
                          width: 25,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: CommonColors.purple.withAlpha(30),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              '#BK${widget.id ?? 0}',
                              style: CommonTextStyles.regular12.copyWith(
                                color: CommonColors.purple,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.jobType ?? '',
                            style: CommonTextStyles.medium16,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text("01:24:26", style: CommonTextStyles.medium14),
                ],
              ),

              const SizedBox(height: 24),

              Text('Job Checklist', style: CommonTextStyles.medium20),
              const SizedBox(height: 8),
              _buildCheckBox("Inspect the AC Unit", 0),
              _buildCheckBox("Identify Gas Leakage", 1),
              _buildCheckBox("Refill Gas Cylinder", 2),
              _buildCheckBox("Test Cooling", 3),
              _buildCheckBox("Customer Approval", 4),

              const SizedBox(height: 20),

              /// Upload Photos
              Text(
                "Upload Photos",
                style: CommonTextStyles.medium20.copyWith(
                  color: CommonColors.secondary,
                ),
              ),
              const SizedBox(height: 12),
              controller.markAsCompletedImage == null
                  ? DottedBorder(
                      options: RoundedRectDottedBorderOptions(
                        dashPattern: [8, 4],
                        strokeWidth: 1,
                        radius: Radius.circular(8),
                        color: CommonColors.grey.withAlpha(80),
                      ),
                      child: GestureDetector(
                        onTap: imagePicker,
                        child: Container(
                          width: double.infinity,
                          height: 42,
                          color: CommonColors.fileUpload,
                          child: Center(
                            child: Text(
                              'Click to Upload',
                              style: CommonTextStyles.regular14,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            controller.markAsCompletedImage!,
                            fit: BoxFit.cover,
                            width: 200,
                            height: 100,
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,

                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                controller.markAsCompletedImage = null;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.close,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

              const SizedBox(height: 20),

              /// Comments
              Text(
                "Comments",
                style: CommonTextStyles.medium20.copyWith(
                  color: CommonColors.secondary,
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: controller.commentController,
                maxLines: 2,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2),
                    borderSide: BorderSide(color: CommonColors.textFieldGrey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2),
                    borderSide: BorderSide(color: CommonColors.textFieldGrey),
                  ),
                ),
              ),

              const Spacer(),

              /// Bottom Button
              controller.markAsCompletedImage == null
                  ? Center(
                      child: Container(
                        width: 200,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: CommonColors.grey.withAlpha(25),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            "You have started this job.",
                            style: CommonTextStyles.medium14.copyWith(
                              color: CommonColors.grey,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Obx(
                      () => CommonButton(
                        isLoading: controller.isLoading.value,
                        text: "Mark Service as Completed",
                        backgroundColor: CommonColors.primaryColor,
                        textColor: CommonColors.white,
                        onTap: () {
                          controller.markAsCompleted(widget.id);
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCheckBox(String title, int index) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      title: Text(title, style: CommonTextStyles.regular14),
      value: _checklist[index],
      side: BorderSide(color: CommonColors.textFieldGrey, width: 1),
      onChanged: (value) {
        setState(() {
          _checklist[index] = value ?? false;
        });
      },
      activeColor: CommonColors.primaryColor,
      checkColor: CommonColors.white,
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
