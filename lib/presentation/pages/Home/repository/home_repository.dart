import 'package:magical_walls/data/network/api_services.dart';
import 'package:magical_walls/data/urls/api_urls.dart';
import 'package:magical_walls/presentation/pages/Home/model/home_mode.dart';

import '../model/Completed_order_model.dart';

class HomeRepository {
  NetworkApiService http = NetworkApiService();

  Future<OrderUpcomingRes> getUpcomingOrderList(String token, dynamic request) async {
    final res = await http.get(ApiUrls.getOrderList, params: request, token: token);
    return OrderUpcomingRes.fromMap(res);
  }

  Future<OrderCompletedRes> getCompletedOrderList(String token, dynamic request) async {
    final res = await http.get(ApiUrls.getOrderList, params: request, token: token);
    return OrderCompletedRes.fromMap(res);
  }
}
