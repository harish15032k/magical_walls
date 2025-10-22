

import 'package:magical_walls/data/network/api_services.dart';
import 'package:magical_walls/data/urls/api_urls.dart';
import 'package:magical_walls/presentation/pages/location/model/location_model.dart';

class LocationRepository {
  NetworkApiService http = NetworkApiService()
;  updateUserLocationApi(String token,Map<String,dynamic> request)async{
    final res = await http.post(ApiUrls.locationUpdate, request,token: token);
    return LocationRes.fromMap(res);

  }
}