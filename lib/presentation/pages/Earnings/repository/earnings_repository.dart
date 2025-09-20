import 'package:magical_walls/data/network/api_services.dart';
import 'package:magical_walls/data/urls/api_urls.dart';
import 'package:magical_walls/presentation/pages/Earnings/model/earnings_model.dart';

class EarningsRepository{
  NetworkApiService http = NetworkApiService();
  getEarnings(String token , dynamic request)async{
    final res = await http.get(ApiUrls.earningsGet,params:request,token: token);
    return BarChartRes.fromMap(res);

  }
  withdrawRequest(dynamic request , String token)async{
    final res = await http.post(ApiUrls.withDrawRequest, request,token: token);
    return res;
  }
}