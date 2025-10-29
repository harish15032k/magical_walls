import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magical_walls/core/constants/app_colors.dart';
import 'package:magical_walls/core/constants/app_text.dart';
import 'package:intl/intl.dart';
import 'package:magical_walls/presentation/pages/Home/controller/home_controller.dart';
import 'package:magical_walls/presentation/widgets/shimmer.dart';


class NotificationScreen extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

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
                  Text(
                    'Notifications',
                    style: CommonTextStyles.medium20,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return  ShimmerWidgets.shimmerBox(count: 10,height: 60);
                  }
                  if (controller.notifications.isEmpty) {
                    return const Center(child: Text("No notifications found"));
                  }
                  return ListView.builder(
                    itemCount: controller.notifications.length,
                    itemBuilder: (context, index) {
                      final item = controller.notifications[index];
                      final data = item.data;


                      final formattedTime = item.createdAt != null
                          ? DateFormat("MMMM d, yyyy | hh:mm a")
                          .format(item.createdAt!)
                          : "";


                      List<String>? details;
                      if (data != null) {
                        details = [];
                        if (data.service != null) {
                          details.add("Service: ${data.service}");
                        }
                        if (data.datetime != null) {
                          details.add("Time: ${data.datetime}");
                        }
                        if (data.location != null) {
                          details.add(
                              "Location: ${data.location}");
                        }
                      }

                      return _buildNotificationCard(
                        iconPath: 'assets/images/noti.png',
                        title: item.title ?? '',
                        message: item.message ?? '',
                        details: details,
                        timestamp: formattedTime,
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationCard({
    required String iconPath,
    required String title,
    required String message,
    List<String>? details,
    required String timestamp,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: CommonColors.textFieldGrey, width: 1),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  iconPath,
                  width: 33,
                  height: 33,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: CommonTextStyles.medium18),
                      Text(
                        message,
                        style: CommonTextStyles.regular14
                            .copyWith(color: CommonColors.secondary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (details != null && details.isNotEmpty) ...[
              const SizedBox(height: 8),
              ...details.map((detail) {
                final parts = detail.split(': ');
                if (parts.length == 2) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Row(
                      children: [
                        Text(
                          '${parts[0]}: ',
                          style: CommonTextStyles.regular14
                              .copyWith(color: CommonColors.secondary),
                        ),
                        Expanded(
                          child: Text(
                            parts[1],
                            style: CommonTextStyles.regular14
                                .copyWith(color: CommonColors.black),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(detail, style: CommonTextStyles.regular14),
                );
              }).toList(),
            ],
            const SizedBox(height: 8),
            Text(
              timestamp,
              style: CommonTextStyles.regular12
                  .copyWith(color: CommonColors.secondary),
            ),
          ],
        ),
      ),
    );
  }
}
