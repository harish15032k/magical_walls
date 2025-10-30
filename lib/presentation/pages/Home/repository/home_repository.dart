import 'dart:convert';
import 'dart:io';

import 'package:get/get_connect/http/src/multipart/multipart_file.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:magical_walls/data/network/api_services.dart';
import 'package:magical_walls/data/urls/api_urls.dart';
import 'package:magical_walls/presentation/pages/Home/model/Notification_model.dart';
import 'package:magical_walls/presentation/pages/Home/model/checklist_model.dart';
import 'package:magical_walls/presentation/pages/Home/model/home_mode.dart';

import '../model/Completed_order_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
class HomeRepository {
  NetworkApiService _http = NetworkApiService();

  Future<OrderUpcomingRes> getUpcomingOrderList(
    String token,
    dynamic request,
  ) async {
    final res = await _http.get(
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
    final res = await _http.get(
      ApiUrls.getOrderList,
      params: request,
      token: token,
    );
    return OrderCompletedRes.fromMap(res);
  }

  acceptOrder(String token, dynamic request) async {
    final res = await _http.post(ApiUrls.acceptOrder, request, token: token);
    return res;
  }

  getStartJobOtp(String token, dynamic request) async {
    final res = await _http.get(
      ApiUrls.startJobSentOtp,
      params: request,
      token: token,
    );
    return res;
  }

  verifyStarJobOtp(String token, dynamic request, bool? otScreen) async {
    final res = await _http.post(
      otScreen == true ? ApiUrls.verifyEndJobOtp : ApiUrls.verifyStarJobOtp,
      request,
      token: token,
    );
    return res;
  }
  Future<XFile?> compressImage(File file) async {
    final tempDir = await getTemporaryDirectory();
    final targetPath = path.join(tempDir.path, 'compressed_${path.basename(file.path)}');

    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 70,
      minWidth: 1080,
      minHeight: 1080,
    );

    return result;
  }
  Future<Map<String, dynamic>> takeSelfieToStartJob(
      String token,
      File selfieFile,
      String bookingServiceId,
      bool otpScreen,
      ) async {
    try {
      // Compress image before sending
      final XFile? compressed = await compressImage(selfieFile);
      final File compressedFile = File(compressed?.path ?? selfieFile.path);

      final uri = Uri.parse(
        otpScreen ? ApiUrls.takeSelfieToEndJob : ApiUrls.takeSelfieToStartJob,
      );

      var request = http.MultipartRequest('POST', uri);

      request.fields['bookingServiceId'] = bookingServiceId;

      request.files.add(
        await http.MultipartFile.fromPath(
          'selfie',
          compressedFile.path,
          filename: compressedFile.path.split('/').last,
        ),
      );

      request.headers['Authorization'] = 'Bearer $token';

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      return jsonDecode(response.body);
    } catch (e) {
      return {'status': false, 'message': e.toString()};
    }
  }

  endJobOtp(dynamic request,String token)async{
    final res = await _http.post(ApiUrls.verifyEndJobOtp, request, token: token);
    return res;
  }
  markAsCompleted(String token, dynamic request) async {
    final res = await _http.post(ApiUrls.markAsCompleted, request, token: token);
    return res;
  }  getCheckList(String token, dynamic request) async {
    final res = await _http.get(ApiUrls.getCheckList, params: request, token: token);
    return CheckListRes.fromMap(res);
  }
  getNotification(String token,) async {
    final res = await _http.get(
      ApiUrls.getNotification,

      token: token,
    );
    return NotiRes.fromMap(res) ;
  }
}
