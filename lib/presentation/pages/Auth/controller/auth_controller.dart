import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:developer' as dev;
import 'dart:io';

import 'package:file_picker/file_picker.dart' show PlatformFile;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:magical_walls/core/utils/utils.dart';
import 'package:magical_walls/data/urls/api_urls.dart';
import 'package:magical_walls/presentation/pages/Auth/model/auth_model.dart' hide Data;
import 'package:magical_walls/presentation/pages/Auth/model/kyc_model.dart';
import 'package:magical_walls/presentation/pages/Auth/model/service_listmodel.dart';
import 'package:magical_walls/presentation/pages/Auth/repository/auth_repository.dart';
import 'package:magical_walls/presentation/pages/Auth/screens/kyc/profile_review.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import '../../Home/screens/bottom_bar.dart';
import '../model/verify_otp_model.dart' hide Data;
import '../screens/kyc/service_add.dart';
import '../screens/otp_screen.dart';

class AuthController extends GetxController {
  AuthRepository repo = AuthRepository();

  final TextEditingController mobile = TextEditingController();
  var isLoading = false.obs;
  var serviceList = <Datum>[].obs;
  List<dynamic> selectedService = [].obs;
  final TextEditingController name = TextEditingController();
  final TextEditingController dob = TextEditingController();
  final TextEditingController gender = TextEditingController();
  final TextEditingController lang = TextEditingController();
  final TextEditingController work = TextEditingController();
  File? pickedSkilledImage;
  File? pickedPanImage;
  String? selectedAadhaarFile;
  final TextEditingController accountHolderName = TextEditingController();
  final TextEditingController bank = TextEditingController();
  final TextEditingController accountNumber = TextEditingController();
  final TextEditingController ifscCode = TextEditingController();
  bool isTermsAccepted = false;
  final _kycStatusController = StreamController<String>.broadcast();
  Stream<String> get kycStatusStream => _kycStatusController.stream;
  var kycStatus = ''.obs;
  getOtp(BuildContext context) async {
    try {
      isLoading.value = true;
      Map<String, String> request = {
        'phone': mobile.text,
        'fcm_token':
            'e5zr4hE_TdqvspLM7rFztW:APA91bHwKnAl6DS8AWTayjqYcgy8s4HVtUO7CW2TCOLVuyOPoMiIl7POFxX8KROaLgshVvEN0TKeOk0XEcqwMy4lmUoNOvzgEUNFxWRUVpC30heKUXQkRt8',
      };

      GetOtpRes res = await repo.getOtp(request);

      if (res.status == true) {
        Get.to(
          () => OtpScreen(mobile: mobile.text),
          transition: Transition.rightToLeft,
        );
      } else {
        showCustomSnackBar(context: context, errorMessage: res.message ?? '');
      }
    } catch (e) {
      debugPrint("getOtp error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  verifyOtp(String pin, String mobile, BuildContext context) async {
    try {
      print('mobile $mobile');
      isLoading.value = true;
      Map<String, String> request = {'phone': mobile, 'code': pin};
      VerifyOtpRes res = await repo.verifyOtp(request);

      if (res.status == true) {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        await prefs.setString('token', res.data?.token ?? '');
        await prefs.setBool('isLogin', true);

        await prefs.setInt('isKycCompleted', res.data!.isKyc ?? 0);

        if (res.data?.isKyc == 1) {
          bool? iskycverifiedfromadmin = prefs.getBool("iskycverified");
          if (iskycverifiedfromadmin == true) {
            Get.offAll(() => BottomBar());
          } else {
            Get.offAll(() => ProfileUnderReview());
          }
        } else {
          Get.offAll(() => SelectService(), transition: Transition.rightToLeft);
        }
      } else {
        showCustomSnackBar(context: context, errorMessage: res.message ?? '');
      }
    } catch (e) {
      debugPrint("verifyOtp error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  getServiceList() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var token = prefs.getString('token');

      isLoading.value = true;
      ServiceListRes res = await repo.serviceList(token!);
      if (res.status == true) {
        serviceList.value = res.data!;
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> kycCompleted(BuildContext context) async {
    try {
      isLoading.value = true;

      // Validate and format date
      DateTime? dateOfBirth;
      try {
        dateOfBirth = DateFormat('dd/MM/yyyy').parse(dob.text);
      } catch (e) {
        showCustomSnackBar(context: context, errorMessage: 'Invalid date of birth format. Use dd/MM/yyyy');
        isLoading.value = false;
        return;
      }
      String formattedDob = DateFormat('yyyy-MM-dd').format(dateOfBirth);


      var request = http.MultipartRequest('POST', Uri.parse(ApiUrls.kycComplete))
        ..fields['full_name'] = accountHolderName.text
        ..fields['date_of_birth'] = formattedDob
        ..fields['gender'] = gender.text.toLowerCase()
        ..fields['speaking_language'] = lang.text
        ..fields['experience'] = work.text
        ..fields['account_holder_name'] = accountHolderName.text
        ..fields['bank'] = bank.text
        ..fields['account_number'] = accountNumber.text
        ..fields['ifsc_number'] = ifscCode.text
        ..fields['check_guideline'] = isTermsAccepted ? '1' : '0';


      if (selectedService.isNotEmpty) {
        for (int i = 0; i < selectedService.length; i++) {
          request.fields['service[$i]'] = selectedService[i].toString();
        }
      }


      if (pickedSkilledImage != null) {
        debugPrint('Skill Certificate Path: ${pickedSkilledImage!.path}, Size: ${await File(pickedSkilledImage!.path).length()} bytes');
        request.files.add(await http.MultipartFile.fromPath('skill_certificate', pickedSkilledImage!.path));
      }
      if (selectedAadhaarFile != null) {
        debugPrint('Aadhaar Card Path: $selectedAadhaarFile, Size: ${await File(selectedAadhaarFile!).length()} bytes');
        request.files.add(await http.MultipartFile.fromPath('aadhar_card', selectedAadhaarFile!));
      }
      if (pickedPanImage != null) {
        debugPrint('Pan Card Path: ${pickedPanImage!.path}, Size: ${await File(pickedPanImage!.path).length()} bytes');
        request.files.add(await http.MultipartFile.fromPath('pan_card', pickedPanImage!.path));
      }


      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      if (token == null) {
        showCustomSnackBar(context: context, errorMessage: 'Authentication token missing');
        isLoading.value = false;
        return;
      }
      request.headers.addAll({'Authorization': 'Bearer $token'});


      debugPrint('Request Fields: ${request.fields}');
      for (var file in request.files) {
        debugPrint('Request File: ${file.field}, Size: ${await file.length} bytes');
      }


      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(responseBody.body);
        if (jsonResponse['status'] == true) {
          debugPrint("🎉 KYC Success Log => Request: ${request.fields}, StatusCode: ${response.statusCode}, Response: ${responseBody.body}");
          await prefs.setInt('isKycCompleted', 1);
          Get.offAll(() => ProfileUnderReview(), transition: Transition.rightToLeft);
          showCustomSnackBar(context: context, errorMessage: jsonResponse['message'] ?? 'KYC submission Completed');

        } else {
          showCustomSnackBar(context: context, errorMessage: jsonResponse['message'] ?? 'KYC submission failed');
        }
      } else {
        showCustomSnackBar(context: context, errorMessage: 'Server error occurred, status: ${response.statusCode}, body: ${responseBody.body}');
      }
    } catch (e) {
      debugPrint("kycCompleted error: $e");
      showCustomSnackBar(context: context, errorMessage: 'An error occurred');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getKycStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    try {
      isLoading.value = true;
      KycRes res = await repo.getKycStatus(token!);

      if (res.status == true) {
        _kycStatusController.add(res.data?.kycStatus ?? '');
      } else {
        _kycStatusController.add('');
      }
    } catch (e) {
      _kycStatusController.addError(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    _kycStatusController.close();
    super.onClose();
  }
}
