import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text.dart';
import '../../presentation/pages/Home/controller/home_controller.dart';
import '../../presentation/pages/Home/screens/order_viewdetails.dart';
import '../../presentation/widgets/common_button.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null || message.data.isNotEmpty) {
    log("Notification Title: ${message.notification?.title}");
    log("Notification Body: ${message.notification?.body}");
    log("Notification Data: ${message.data}");
  }
}

class FirebaseApi {


  final _firebaseMessaging = FirebaseMessaging.instance;
  final _localNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();

    final fcmToken = await _firebaseMessaging.getToken();
    log("FCM Token: $fcmToken");

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("fcm_token", fcmToken ?? '');

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidSettings);
    await _localNotificationsPlugin.initialize(initSettings);

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);


    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null || message.data.isNotEmpty) {
        log("Foreground Notification Title: ${message.notification?.title}");
        log("Foreground Notification Body: ${message.notification?.body}");
        log("Foreground Notification Data: ${message.data}");

        final data = message.data;
        final type = data['type'] ?? '';


        _showNotification(
          message.notification?.title ?? 'No Title',
          message.notification?.body ?? 'No Body',
        );


        if (type == 'new_booking') {
          final context = navigatorKey.currentContext;
          if (context != null) {
            Future.delayed(Duration.zero, () {
              showNewServiceRequestPopup(context, data);
            });
          }
        }
      }
    });
  }

  Future<void> _showNotification(String title, String body) async {
    const androidDetails = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'channel_description',
      importance: Importance.high,
      priority: Priority.high,
    );
    const platformDetails = NotificationDetails(android: androidDetails);
    await _localNotificationsPlugin.show(0, title, body, platformDetails);
  }
}

void showNewServiceRequestPopup(BuildContext context, Map<String, dynamic> data) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        insetPadding: const EdgeInsets.only(left: 16, right: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            GestureDetector( onTap: (){
              // JobDetailsScreen(
              //   job: {
              //     'id': data['booking_service_id'].toString(),
              //     'type': data['service_name'] ?? '',
              //     'customer': job.customerName ?? '',
              //     'date':  data['booking_date'].toString() ?? '',
              //     'timeSlot':  data['time_slot'].toString() ?? '',
              //     'address': job.address?.address ?? '',
              //     'phone': job.customerPhoneNumber ?? '',
              //     'duration': job.duration ?? '',
              //     'tools': job.toolsRequired ?? [],
              //     'service_price': job.servicePrice ?? '',
              //     'assigned_technician': job.assignedTechnician ?? '',
              //   },
              // ),
            },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: CommonColors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: CommonColors.textFieldGrey,
                    width: 1.5,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['title'] ?? 'New Service Request',
                      style: CommonTextStyles.medium22,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      data['body'] ?? 'You received a new job nearby.',
                      style: CommonTextStyles.regular14.copyWith(
                        color: CommonColors.secondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      color: CommonColors.purple.withAlpha(30),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          '#${data['booking_service_id'] ?? 'N/A'}',
                          style: CommonTextStyles.regular12.copyWith(
                            color: CommonColors.purple,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      data['service_name'] ?? 'Unknown Service',
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
                              'Date',
                              style: CommonTextStyles.regular14.copyWith(
                                color: CommonColors.secondary,
                              ),
                            ),
                            Text(
                              data['booking_date'] ?? 'N/A',
                              style: CommonTextStyles.medium14,
                            ),
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
                            Text(
                              data['time_slot'] ?? 'N/A',
                              style: CommonTextStyles.regular14,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Price: ₹${data['price'] ?? '0'}',
                      style: CommonTextStyles.medium14.copyWith(
                        color: CommonColors.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: CommonButton(
                            onTap: () async{
                              final  homeController = Get.find<HomeController>();
                              await     homeController.acceptService(
                                data['booking_service_id'],
                                'reject',
                                context,
                                index: 0,
                              );
                              Get.back();
                            },
                            text: 'Reject',
                            backgroundColor: Colors.transparent,
                            textColor: CommonColors.purple,
                            borderColor: CommonColors.purple,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: CommonButton(
                            onTap: () async{
                              final  homeController = Get.find<HomeController>();

                         await     homeController.acceptService(
                                data['booking_service_id'],
                                'accept',
                                context,
                                index: 0,
                              );
                              Get.back();
                            },
                            backgroundColor: CommonColors.primaryColor,
                            textColor: CommonColors.white,
                            text: 'Accept',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              width: 20,
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Image.asset('assets/images/close-circle.png'),
              ),
            ),
          ],
        ),
      );
    },
  );
}
