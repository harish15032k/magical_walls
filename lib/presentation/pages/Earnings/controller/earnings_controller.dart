import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:magical_walls/core/utils/utils.dart';
import 'package:magical_walls/presentation/pages/Earnings/repository/earnings_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import '../model/earnings_model.dart';

class EarningsController extends GetxController {
  EarningsRepository repo = EarningsRepository();

  var isLoading = false.obs;
  var earningsData = <Datum>[].obs;
  var totalEarnings = 0.obs;

  var currentWeek = Rx<({DateTime start, DateTime end})>((
    start: DateTime.now(),
    end: DateTime.now(),
  ));

  @override
  void onInit() {
    super.onInit();
    _loadInitialData();
  }

  void _loadInitialData() {
    final now = DateTime.now();
    final start = now.subtract(Duration(days: now.weekday - 1));
    final end = start.add(const Duration(days: 6));
    currentWeek.value = (start: start, end: end);
    getEarnings(start.toIso8601String(), end.toIso8601String());
  }

  getEarnings(dynamic startDate, dynamic endDate) async {
    try {
      Map<String, dynamic> request = {
        "start_date": startDate,
        "end_date": endDate,
      };
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      isLoading.value = true;
      BarChartRes res = await repo.getEarnings(token!, request);
      if (res.status == true) {
        earningsData.assignAll(res.data ?? []);
        totalEarnings.value = earningsData.fold(
          0,
          (sum, item) => sum + (item.amount ?? 0),
        );

        currentWeek.value = (
          start: DateTime.parse(startDate),
          end: DateTime.parse(endDate),
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  withdrawRequest(dynamic amount,BuildContext context) async {
    try {
      isLoading.value = true;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      Map<String, dynamic> request = {"amount": amount, "bank": "SBI"};
      final res =await repo.withdrawRequest(request, token!);
      if(res['status']=='success'){
        showCustomSnackBar(context: context, errorMessage: res['message']);
        Get.back();
      }
      else{
        showCustomSnackBar(context: context, errorMessage: res['message']);
      }
    } finally {
      isLoading.value = false;
    }
  }
}
