import 'package:get/get.dart';
import 'package:magical_walls/presentation/pages/Home/model/home_mode.dart';
import 'package:magical_walls/presentation/pages/Home/repository/home_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
class HomeController extends GetxController {
  var isLoading = false.obs;

  var upcomingOrders = <Datum>[].obs;
  var ongoingOrders = <Datum>[].obs;
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

      OrderListRes res = await repo.getOrderList(token, request);

      if (res.status == true) {
        switch (filter) {
          case "upcoming":
            upcomingOrders.assignAll(res.data ?? []);
            break;
          case "ongoing":
            ongoingOrders.assignAll(res.data ?? []);
            break;
          case "completed":
            completedOrders.assignAll(res.data ?? []);
            break;
        }
      }
    } finally {
      isLoading.value = false;
    }
  }
}

