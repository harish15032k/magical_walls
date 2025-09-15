import 'package:magical_walls/data/urls/api_urls.dart';
import 'package:magical_walls/presentation/pages/Auth/model/service_listmodel.dart';

import '../../../../data/network/api_services.dart';
import '../model/auth_model.dart';
import '../model/verify_otp_model.dart';

class AuthRepository {
  NetworkApiService http = NetworkApiService();
  getOtp(dynamic request) async {
    final res = await http.post(ApiUrls.getOtp,request);
    return GetOtpRes.fromMap(res);
  } verifyOtp(dynamic request) async {
    final res = await http.post(ApiUrls.verifyOtp,request);
    return VerifyOtpRes.fromMap(res);
  }
  serviceList(String token) async {
    final res = await http.get(ApiUrls.serviceList,token:token );
    return ServiceListRes.fromMap(res);
  }
}
