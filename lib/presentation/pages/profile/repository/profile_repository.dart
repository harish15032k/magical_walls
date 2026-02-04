import 'package:magical_walls/data/network/api_services.dart';
import 'package:magical_walls/data/urls/api_urls.dart';
import 'package:magical_walls/presentation/pages/profile/model/profile_model.dart';

class ProfileRepository {
  NetworkApiService http = NetworkApiService();
  getProfile(String token) async {
    final res = await http.get(ApiUrls.profileGet, token: token);
    return ProfileRes.fromMap(res);
  }

  updateToggle(Map<String, dynamic> request, String token) async {
    final res = await http.post(ApiUrls.updateToggle, request, token: token);
    return res;
  }

  riseSupport(Map<String, dynamic> request, String token) async {
    final res = await http.post(ApiUrls.riseSupport, request, token: token);
    return res;
  }
  updateProfile(Map<String, dynamic> request, String token)async{
    final res = await http.post(ApiUrls.profileUpdate, request,token: token);
    return res;

  }

  Future<dynamic> getSupportReasonListRepo({required String token}) async {
    final response = await http.get(
      ApiUrls.reason,
      params: {},
     token:  token,
    );
    return response;
  }
  Future<dynamic> getTechnicianSupportListRepo({required String token}) async {
    final response = await http.get(
      ApiUrls.customerSupportList,
      params: {},
      token:  token,
    );
    return response;
  }


  Future<dynamic> getReferralRepo({required String token}) async {
    final response = await http.get(
      "${ApiUrls.referral}?token=$token",
     params: {},
     token:  token,
    );
    return response;
  }
}
