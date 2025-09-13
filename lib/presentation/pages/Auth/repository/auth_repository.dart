import 'package:magical_walls/data/urls/api_urls.dart';

import '../../../../data/network/api_services.dart';
import '../model/auth_model.dart';

class AuthRepository {
  NetworkApiService http = NetworkApiService();
  getOtp(dynamic request) async {
    final res = await http.post(ApiUrls.getOtp,request);
    return GetOtpRes.fromMap(res);
  } verifyOtp(dynamic request) async {
    final res = await http.post(ApiUrls.verifyOtp,request);
    return GetOtpRes.fromMap(res);
  }
}
