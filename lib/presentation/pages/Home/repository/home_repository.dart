import 'package:magical_walls/data/network/api_services.dart';
import 'package:magical_walls/data/urls/api_urls.dart';
import 'package:magical_walls/presentation/pages/Home/model/Notification_model.dart';
import 'package:magical_walls/presentation/pages/Home/model/home_mode.dart';

import '../model/Completed_order_model.dart';

class HomeRepository {
  NetworkApiService http = NetworkApiService();

  Future<OrderUpcomingRes> getUpcomingOrderList(
    String token,
    dynamic request,
  ) async {
    final res = await http.get(
      ApiUrls.getOrderList,
      params: request,
      token: token,
    );
    return OrderUpcomingRes.fromMap(res);
  }

  Future<OrderCompletedRes> getCompletedOrderList(
    String token,
    dynamic request,
  ) async {
    final res = await http.get(
      ApiUrls.getOrderList,
      params: request,
      token: token,
    );
    return OrderCompletedRes.fromMap(res);
  }

  acceptOrder(String token, dynamic request) async {
    final res = await http.post(ApiUrls.acceptOrder, request, token: token);
    return res;
  }

  getStartJobOtp(String token, dynamic request) async {
    final res = await http.get(
      ApiUrls.startJobSentOtp,
      params: request,
      token: token,
    );
    return res;
  }

  verifyStarJobOtp(String token, dynamic request, bool? otScreen) async {
    final res = await http.post(
      otScreen == true ? ApiUrls.verifyEndJobOtp : ApiUrls.verifyStarJobOtp,
      request,
      token: token,
    );
    return res;
  }

  takeSelfieToStartJob(String token, dynamic request,bool otpScreen) async {
    final res = await http.post(
     otpScreen==true?ApiUrls.takeSelfieToEndJob: ApiUrls.takeSelfieToStartJob,
      request,
      token: token,
    );
    return res;
  }

  markAsCompleted(String token, dynamic request) async {
    final res = await http.post(ApiUrls.markAsCompleted, request, token: token);
    return res;
  }
  getNotification(String token,) async {
    final res = await http.get(
      ApiUrls.getNotification,

      token: token,
    );
    return NotiRes.fromMap(res) ;
  }
}
