import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:magical_walls/core/utils/utils.dart';
import 'package:magical_walls/presentation/pages/Home/model/Notification_model.dart'
    as noti;
import 'package:magical_walls/presentation/pages/Home/model/checklist_model.dart' as check;
import 'package:magical_walls/presentation/pages/Home/model/home_mode.dart'
    as up;
import 'package:magical_walls/presentation/pages/Home/repository/home_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/urls/api_urls.dart';
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
  var checkListData =<check.Datum>[].obs;
  RxList<bool> checklist = <bool>[].obs;

  RxBool isAcceptedByYou =false.obs;

  var notifications = <noti.Datum>[].obs;
  var markAsCompletedImage = Rxn<File>();

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

  var startSelfiePic = Rxn<File>();


  Map<int, RxString> orderTimers = {};

  /// Start the timer for a job
  void startJobTimer(int orderId, DateTime startTime) {
    // Avoid creating duplicate timers
    if (orderTimers.containsKey(orderId)) return;

    final timerString = "00:00:00".obs;
    orderTimers[orderId] = timerString;

    Timer.periodic(const Duration(seconds: 1), (timer) {
      final difference = DateTime.now().difference(startTime);
      final hours = difference.inHours.toString().padLeft(2, '0');
      final minutes = (difference.inMinutes % 60).toString().padLeft(2, '0');
      final seconds = (difference.inSeconds % 60).toString().padLeft(2, '0');
      timerString.value = "$hours:$minutes:$seconds";
    });
  }

  /// Get timer string safely
  String getTimerString(dynamic orderId) {
    final key = orderId is int ? orderId : int.tryParse(orderId.toString()) ?? 0;
    return orderTimers[key]?.value ?? "00:00:00";
  }

  /// Call API to take selfie and start job
  Future<void> takeSelfieToStartJob(
      dynamic id, bool otpScreen, BuildContext context) async {
    if (startSelfiePic.value == null) return;

    try {
      isLoading.value = true;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token') ?? '';

      final res = await repo.takeSelfieToStartJob(
        token,
        startSelfiePic.value!,
        id.toString(),
        otpScreen,
      );

      if (res['status'] == true) {
        showCustomSnackBar(context: context, errorMessage: res['message']);

        // Start the timer **only after API success**
        startJobTimer(int.parse(id.toString()), DateTime.now());

        // Navigate after starting the timer
        Get.offAll(() => BottomBar(tabIndex: otpScreen ? 2 : 1),
            transition: Transition.fadeIn);

        getOrderList(otpScreen ? 'completed' : 'ongoing');
      } else {
        log(res['message']);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  getCheckList(dynamic bookingId)async{
    try{
      isLoading.value=true;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token') ?? '';
      Map<String,dynamic> request ={
        // 'service_id':serviceId,
        'booking_service_id':bookingId,

      };
      check.CheckListRes res  = await repo.getCheckList(token,request);

      if(res.status==true){
        checkListData.value=res.data??[];

      }
      else{

      }


    }
    finally{{
      isLoading.value=false;
    }}


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
        isAcceptedByYou.value= res['isAcceptedByYou'];
        if (status == 'reject') {
          upcomingOrders.removeAt(index!);
        }

        await Future.delayed(Duration(milliseconds: 300));
        getOrderList("upcoming");
        showCustomSnackBar(context: context, errorMessage: res['message']);
      } else {
        isAcceptedByYou.value=false;
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

  getStartJobOtp(dynamic id,bool? otpScreen) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var token = preferences.getString('token') ?? "";

      Map<String, dynamic> request = {"bookingServiceId": id};
      isLoading.value = true;

      final res = await repo.getStartJobOtp(token, request);
      if (res['status'] == true) {
        Get.to(() => StartJobOtp(id: id,isEndJob: otpScreen,), transition: Transition.topLevel);
      }
    } finally {
      isLoading.value = false;
    }
  }

  verifyStarJobOtp(dynamic id, dynamic otp, bool? otpScreen ,BuildContext context) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var token = preferences.getString('token') ?? "";

      Map<String, dynamic> request = {"bookingServiceId": id, 'otp': otp};
      isLoading.value = true;

      final res = await repo.verifyStarJobOtp(token, request, otpScreen);
      if (res['status'] == true) {
        otpScreen==true? Get.offAll(() => BottomBar(tabIndex: 2 ),
         transition: Transition.fadeIn):   Get.to(
          () => SelfieScreen(id: id, otpScreen: otpScreen),
          transition: Transition.rightToLeft,
        );
      }
      else{
        showCustomSnackBar(context: context, errorMessage: res['message']);
      }
    } finally {
      isLoading.value = false;
    }
  }
  endJobOtp(dynamic id,bool? otpScreen)async{
    try{
      isLoading.value=true;
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var token = preferences.getString('token') ?? "";
      Map<String, dynamic> request = {
        "bookingServiceId": id,

      };
      final res = await repo.endJobOtp(request, token);
      if(res['status']==true){
        Get.to(() => StartJobOtp(id: id,isEndJob: otpScreen,), transition: Transition.topLevel);
      }

    }finally{
      isLoading.value=false;

    }
  }

  Future<void> markAsCompleted(
      BuildContext context,
      dynamic bookingServiceId,
      dynamic otp,
      List<int> selectedChecklistIds,
      List<File> photos,
      ) async {
    try {
      isLoading.value = true;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      if (token == null || token.isEmpty) {
        showCustomSnackBar(context: context, errorMessage: 'Token missing. Please login again.');
        isLoading.value = false;
        return;
      }

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(ApiUrls.markAsCompleted),
      );


      request.fields['bookingServiceId'] = bookingServiceId.toString();
      request.fields['comments'] = commentController.text.trim();
      request.fields['otp'] = otp.toString();


      for (int i = 0; i < selectedChecklistIds.length; i++) {
        request.fields['whats_included[$i]'] = selectedChecklistIds[i].toString();
      }


      for (int i = 0; i < photos.length; i++) {
        final file = photos[i];
        if (file.existsSync()) {
          request.files.add(await http.MultipartFile.fromPath('photo[$i]', file.path));
        }
      }


      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });


      debugPrint("📦 Fields: ${request.fields}");
      for (var f in request.files) {
        debugPrint("📸 File: ${f.field} => ${f.filename}");
      }

      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);

      debugPrint('📨 Response: ${response.statusCode} => ${responseBody.body}');

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(responseBody.body);
        if (jsonResponse['status'] == true) {
          showCustomSnackBar(
            context: context,
            errorMessage: jsonResponse['message'] ?? 'Job marked as completed successfully!',
          );


          Get.offAll(() => BottomBar(tabIndex: 2), transition: Transition.fadeIn);
        } else {
          showCustomSnackBar(
            context: context,
            errorMessage: jsonResponse['message'] ?? 'Failed to mark job as completed',
          );
        }
      } else {
        showCustomSnackBar(
          context: context,
          errorMessage: 'Server error: ${response.statusCode}',
        );
      }
    } catch (e) {
      debugPrint("❌ markAsCompleted error: $e");
      showCustomSnackBar(context: context, errorMessage: e.toString());
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
