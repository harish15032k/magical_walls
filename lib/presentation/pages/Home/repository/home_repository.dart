import 'package:magical_walls/data/network/api_services.dart';
import 'package:magical_walls/data/urls/api_urls.dart';
import 'package:magical_walls/presentation/pages/Home/model/home_mode.dart';

class HomeRepository {
  NetworkApiService http = NetworkApiService();
  getOrderList(String token , dynamic request)async{
    final res = await http.get(ApiUrls.getOrderList,params: request ,token: token);
    return OrderListRes.fromMap(res);
  }
  
}