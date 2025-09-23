import 'package:get/get.dart';
import 'package:magical_walls/presentation/pages/Home/model/home_mode.dart' as up;
import 'package:magical_walls/presentation/pages/Home/repository/home_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/Completed_order_model.dart';
class HomeController extends GetxController {
  var isLoading = false.obs;

  var upcomingOrders = <up.Datum>[].obs;
  var ongoingOrders = <up.Datum>[].obs;
  var completedOrders = <Datum>[].obs;

  HomeRepository repo = HomeRepository();

  @override
  void onInit() {
    super.onInit();
    getOrderList("upcoming");
    getOrderList("ongoing");
    getOrderList("completed");
  }

  Future<void> getOrderList(String filter) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var token = preferences.getString('token') ?? "";

      Map<String, dynamic> request = {"filter": filter};
      isLoading.value = true;

      if (filter == "completed") {

        OrderCompletedRes res = await repo.getCompletedOrderList(token, request);
        if (res.status == true) {
          completedOrders.assignAll(res.data ?? []);
        }
      } else {

        up.OrderUpcomingRes res = await repo.getUpcomingOrderList(token, request);
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
}


