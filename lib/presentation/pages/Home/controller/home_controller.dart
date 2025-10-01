import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:magical_walls/core/utils/utils.dart';
import 'package:magical_walls/presentation/pages/Home/model/Notification_model.dart' as noti;
import 'package:magical_walls/presentation/pages/Home/model/home_mode.dart'
    as up;
import 'package:magical_walls/presentation/pages/Home/repository/home_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/Completed_order_model.dart';
import '../screens/bottom_bar.dart';
import '../screens/selfie_screen.dart';
import '../screens/startjobverifyotp.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;
  var loadingAcceptMap = <dynamic, RxBool>{}.obs;
  var loadingRejectMap = <dynamic, RxBool>{}.obs;

  var upcomingOrders = <up.Datum>[].obs;
  var ongoingOrders = <up.Datum>[].obs;
  var completedOrders = <Datum>[].obs;
  File? startSelfiePic;
  var notifications = <noti.Datum>[].obs;
  File? markAsCompletedImage;
  final TextEditingController commentController = TextEditingController();
  HomeRepository repo = HomeRepository();

  @override
  void onInit() {
    super.onInit();
    getOrderList("upcoming");
    getOrderList("ongoing");
    getOrderList("completed");
    getNotification();
  }

  Future<void> getOrderList(String filter) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var token = preferences.getString('token') ?? "";

      Map<String, dynamic> request = {"filter": filter};
      isLoading.value = true;

      if (filter == "completed") {
        OrderCompletedRes res = await repo.getCompletedOrderList(
          token,
          request,
        );
        if (res.status == true) {
          completedOrders.assignAll(res.data ?? []);
        }
      } else {
        up.OrderUpcomingRes res = await repo.getUpcomingOrderList(
          token,
          request,
        );
        if (res.status == true) {
          if (filter == "upcoming") {
            upcomingOrders.assignAll(res.data ?? []);
          } else if (filter == "ongoing") {
            ongoingOrders.assignAll(res.data ?? []);
          }
        }
      }
    } finally {
      isLoading.value = false;
    }
  }

  acceptService(
    dynamic id,
    String status,
    BuildContext context, {
    int? index,
  }) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var token = preferences.getString('token') ?? "";
      final key = id.toString();
      if (status == 'accept') {
        loadingAcceptMap[key]?.value = true;
      } else {
        loadingRejectMap[key]?.value = true;
      }

      Map<String, dynamic> request = {
        'booking_service_id': id,
        'status': status,
      };
      final res = await repo.acceptOrder(token, request);
      if (res['status'] == true) {
        if (status == 'reject') {
          upcomingOrders.removeAt(index!);
        }

        await Future.delayed(Duration(milliseconds: 800));
        getOrderList("upcoming");
        showCustomSnackBar(context: context, errorMessage: res['message']);
      } else {
        showCustomSnackBar(context: context, errorMessage: res['message']);
      }
    } finally {
      final key = id.toString();
      if (status == 'accept') {
        loadingAcceptMap[key]?.value = false;
      } else {
        loadingRejectMap[key]?.value = false;
      }
    }
  }

  getStartJobOtp(dynamic id) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var token = preferences.getString('token') ?? "";

      Map<String, dynamic> request = {"bookingServiceId": id};
      isLoading.value = true;

      final res = await repo.getStartJobOtp(token, request);
      if (res['status'] == true) {
        Get.to(() => StartJobOtp(id: id), transition: Transition.topLevel);
      }
    } finally {
      isLoading.value = false;
    }
  }

  verifyStarJobOtp(dynamic id, dynamic otp, bool? otpScreen) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var token = preferences.getString('token') ?? "";

      Map<String, dynamic> request = {"bookingServiceId": id, 'otp': otp};
      isLoading.value = true;

      final res = await repo.verifyStarJobOtp(token, request, otpScreen);
      if (res['status'] == true) {
        Get.to(
          () => SelfieScreen(id: id, otpScreen: otpScreen),
          transition: Transition.rightToLeft,
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  takeSelfieToStartJob(dynamic id, bool? otpScreen) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var token = preferences.getString('token') ?? "";

      Map<String, dynamic> request = {
        "bookingServiceId": id,
        'selfie': startSelfiePic!.path!,
      };
      isLoading.value = true;

      final res = await repo.takeSelfieToStartJob(token, request, otpScreen!);
      if (res['status'] == true) {
        Get.offAll(
          () => BottomBar(tabIndex: otpScreen == true ? 2 : 1),
          transition: Transition.fadeIn,
        );
        getOrderList(otpScreen == true ? 'completed' : 'ongoing');
      }
    } finally {
      isLoading.value = false;
    }
  }

  markAsCompleted(dynamic id) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var token = preferences.getString('token') ?? "";

      Map<String, dynamic> request = {
        "bookingServiceId": id,
        'comments': commentController.text,
      };
      isLoading.value = true;

      final res = await repo.markAsCompleted(token, request);
      if (res['status'] == true) {
        Get.to(
          () => StartJobOtp(id: id, isEndJob: true),
          transition: Transition.topLevel,
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  getNotification() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var token = preferences.getString('token') ?? "";

      isLoading.value = true;

      noti.NotiRes res = await repo.getNotification(token);
      if (res.status == true && res.data != null) {
        notifications.assignAll(res.data!);
      } else {
        notifications.clear();
      }
    } finally {
      isLoading.value = false;
    }
  }
}
