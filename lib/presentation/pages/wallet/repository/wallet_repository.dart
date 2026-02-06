import 'package:magical_walls/data/network/api_services.dart';

import '../../../../data/urls/api_urls.dart';




class WalletRepository{
  final http  = NetworkApiService();

  Future<dynamic> getWalletApiData(
      {int page = 1, required String token, String type = "all"}) async {
    try {
      final response = await http.get(
        "${ApiUrls.wallet}$page&token=$token&type=$type",
      );
      return response;
    } catch (e) {
      return {'message': "Try Again"};
    }
  }

  Future<dynamic> addCustomerPaymentApi(
      {required String token, required Map body}) async {
    try {
      final response = await http.post(
          "${ApiUrls.addCustomerPayment}$token", token: token, body
      );
      return response;
    } catch (e) {
      return {'message': "Try Again"};
    }
  }

  Future<dynamic> verifyCustomerPaymentApi(
      {required String token, required Map body}) async {
    try {
      final response = await http.post(
          "${ApiUrls.verifyCustomerPayment}$token", token: token, body
      );
      return response;
    } catch (e) {
      return {'message': "Try Again"};
    }
  }
}