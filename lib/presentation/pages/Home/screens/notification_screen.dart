import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magical_walls/core/constants/app_colors.dart';
import 'package:magical_walls/core/constants/app_text.dart';

class NotificationScreen extends StatelessWidget {
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
                child: ListView(
                  children: [
                    _buildNotificationCard(
                      iconPath: 'assets/images/noti.png',
                      title: 'New Booking Assigned',
                      message: 'You\'ve been assigned a new job',
                      details: [
                        'Service: AC Repair - Gas Refill',
                        'Time: Today, 4:00 PM',
                        'Booking ID: #MW127',
                      ],
                      timestamp: 'July 20, 2025 | 10:35 AM',
                    ),
                    _buildNotificationCard(
                      iconPath: 'assets/images/noti.png',
                      title: 'Upcoming Job Reminder',
                      message: 'Your next job is in 1 hour.',
                      details: [
                        'Service: Full Home Painting',
                        'Location: Anna Nagar, Chennai',
                      ],
                      timestamp: 'July 17, 2025 | 07:36 AM',
                    ),
                    _buildNotificationCard(
                      iconPath: 'assets/images/noti.png',
                      title: 'Payment Update',
                      message: '₹899 has been credited to your account for booking #UC7519.',
                      timestamp: 'July 11, 2025 | 10:35 AM',
                    ),
                  ],
                ),
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
                      Text(
                        title,
                        style: CommonTextStyles.medium18,
                      ),
                      Text(
                        message,
                        style: CommonTextStyles.regular14.copyWith(color: CommonColors.secondary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (details != null) ...[
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
                          style: CommonTextStyles.regular14.copyWith(
                            color: CommonColors.secondary,

                          ),
                        ),
                        Expanded(
                          child: Text(
                            parts[1],
                            style: CommonTextStyles.regular14.copyWith(color: CommonColors.black),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    detail,
                    style: CommonTextStyles.regular14,
                  ),
                );
              }),
            ],
            const SizedBox(height: 8),
            Text(
              timestamp,
              style: CommonTextStyles.regular12.copyWith(
                color: CommonColors.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}