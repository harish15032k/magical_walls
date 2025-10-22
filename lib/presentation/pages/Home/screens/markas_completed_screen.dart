import 'dart:io';
import 'dart:async';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:magical_walls/presentation/widgets/shimmer.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

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
  final HomeController controller = Get.find<HomeController>();



  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getCheckList(widget.id);
      print('API Called for ID: ${widget.id}');
    });
  }

  Future<void> imagePicker() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      controller.startSelfiePic.value = File(pickedFile.path);
    }
  }

  Widget _buildCheckBox(String title, int index) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      title: Text(title, style: CommonTextStyles.regular14),
      value: controller.checklist[index],
      side: BorderSide(color: CommonColors.textFieldGrey, width: 1),
      onChanged: (value) {
        setState(() {
          controller.checklist[index] = value ?? false;
        });
      },
      activeColor: CommonColors.primaryColor,
      checkColor: CommonColors.white,
      controlAffinity: ListTileControlAffinity.leading,
    );
  }

  Widget buildTimer() {
    final key = int.tryParse(widget.id.toString()) ?? 0;

    if (!controller.orderTimers.containsKey(key)) {
      controller.orderTimers[key] = "00:00:00".obs;
    }

    return Obx(() {
      return Text(
        controller.orderTimers[key]!.value,
        style: CommonTextStyles.medium14,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
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
                            widget.jobType,
                            style: CommonTextStyles.medium16,
                          ),
                        ],
                      ),
                    ],
                  ),

                  /// Timer
                  buildTimer(),
                ],
              ),

              const SizedBox(height: 24),

              /// Checklist Section
              Text('Job Checklist', style: CommonTextStyles.medium20),
              const SizedBox(height: 8),

              Obx(() {
                // Keep checklist in sync with API data
                if (controller.checklist.length != controller.checkListData.length) {
                  controller.checklist
                    ..clear()
                    ..addAll(
                      List.generate(controller.checkListData.length, (_) => false),
                    );
                }

                return controller.isLoading.value
                    ? ShimmerWidgets.serviceShimmer()
                    : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.checkListData.length,
                  itemBuilder: (context, index) {
                    final data = controller.checkListData[index];
                    return _buildCheckBox(data.name ?? '', index);
                  },
                );
              }),

              const SizedBox(height: 20),

              /// Upload Photos
              Text(
                "Upload Photos",
                style: CommonTextStyles.medium20.copyWith(
                  color: CommonColors.secondary,
                ),
              ),
              const SizedBox(height: 12),
              Obx(() {
                final file = controller.startSelfiePic.value;
                if (file == null) {
                  return DottedBorder(
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
                  );
                } else {
                  return Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          file,
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
                            controller.startSelfiePic.value = null;
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
                  );
                }
              }),

              const SizedBox(height: 20),

              /// Comments Section
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

              const SizedBox(height: 20),

              /// Bottom Button
              Obx(() {
                final fileUploaded = controller.startSelfiePic.value != null;
                return fileUploaded
                    ? CommonButton(
                  isLoading: controller.isLoading.value,
                  text: "Mark Service as Completed",
                  backgroundColor: CommonColors.primaryColor,
                  textColor: CommonColors.white,
                  onTap: () {

controller.endJobOtp(widget.id,true);


                  },
                )
                    : Center(
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
                );
              }),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
