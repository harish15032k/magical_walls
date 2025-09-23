import 'package:magical_walls/data/network/api_services.dart';
import 'package:magical_walls/data/urls/api_urls.dart';
import 'package:magical_walls/presentation/pages/profile/model/profile_model.dart';

class ProfileRepository{
  NetworkApiService http = NetworkApiService();
  getProfile(String token)async{
    final res = await http.get(ApiUrls.profileGet,token: token);
    return ProfileRes.fromMap(res);

  }
  updateToggle(Map<String,dynamic> request,String token)async{
    final res = await http.post(ApiUrls.updateToggle, request,token: token);
    return res;

  }  riseSupport(Map<String,dynamic> request,String token)async{
    final res = await http.post(ApiUrls.riseSupport, request,token: token);
    return res;

  }
}