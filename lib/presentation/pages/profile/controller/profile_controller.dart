import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:magical_walls/core/utils/utils.dart';
import 'package:magical_walls/presentation/pages/Auth/screens/login.dart';
import 'package:magical_walls/presentation/pages/profile/repository/profile_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/urls/api_urls.dart';
import '../model/profile_model.dart';
import '../model/referral_model.dart';
import '../model/support_reason_model.dart';
import '../model/support_tickets_model.dart';

class ProfileController extends GetxController {
  ProfileRepository repo = ProfileRepository();
  var isAvailable = false.obs;
  final TextEditingController dob = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController mobile = TextEditingController();
  final TextEditingController Address = TextEditingController();
  File? pickedProfileImage;
  List<SupportReasonModel> supportReasonModelList = [];
  SupportReasonModel? supportReasonModel;
  RxBool isCustomerSupportListLoading = false.obs,
      isHideSupportTicket = true.obs;
  List<SupportModel> supportModel = [];
  ReferralModel? referralModel;
  String referralCode = "";
  String referralShareLink = "";
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    getProfile().then((_) {
      if (profileData.isNotEmpty) {
        isAvailable.value = profileData.first.status == 'available' || profileData.first.status == '1';
      }
    });
    ever(profileData, (_) {
      if (profileData.isNotEmpty) {
        isAvailable.value = profileData.first.status == 'available' || profileData.first.status == '1';
      }
    });
  }

  var isLoading = false.obs;
  var isLoadingToggle = false.obs;
  var profileData = <Data>[].obs;

  getProfile() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      isLoading.value = true;
      ProfileRes res = await repo.getProfile(token!);
      if (res.status == true) {
        profileData.assignAll([res.data!]);
      }
    } finally {
      isLoading.value = false;
    }
  }

  updateToggle(BuildContext context, bool status) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      isLoadingToggle.value = true;

      Map<String, dynamic> request = {'available': status};
      final res = await repo.updateToggle(request, token!);
      if (res['status'] == true) {
        profileData.first.status = status ? '1': '0';
        isAvailable.value = status;
        showCustomSnackBar(context: context, errorMessage: res['message']);
      } else {
        showCustomSnackBar(context: context, errorMessage: res['message']);
      }
    } finally {
      isLoadingToggle.value = false;
    }
  }

  riseSupport(BuildContext context, String message) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      isLoading.value = true;

      Map<String, dynamic> request = {
        'description': message,
        'reason': supportReasonModel?.reason ?? ""
      };
      final res = await repo.riseSupport(request, token!);
      if (res['status'] == true) {
        showCustomSnackBar(context: context, errorMessage: res['message']);
        Get.back();
      } else {
        showCustomSnackBar(
          context: context,
          errorMessage: res['message']['message'][0],
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  logOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('isLogin');
    preferences.remove('locationUpdated');
    Get.offAll(LoginScreen());
  }

  updateProfile(BuildContext context) async {
    try {
      isLoading.value = true;


      if (Address.text.isEmpty || !GetUtils.isEmail(Address.text)) {
        showCustomSnackBar(context: context, errorMessage: 'Please enter a valid email');
        isLoading.value = false;
        return;
      }


      String formattedDob = dob.text;
      try {
        DateTime dateOfBirth = DateFormat('dd/MM/yyyy').parse(dob.text);
        formattedDob = DateFormat('yyyy-MM-dd').format(dateOfBirth);
      } catch (e) {
        showCustomSnackBar(context: context, errorMessage: 'Invalid date format. Use dd/MM/yyyy');
        isLoading.value = false;
        return;
      }


      var request = http.MultipartRequest(
        'POST',
        Uri.parse(ApiUrls.profileUpdate),
      );

      request.fields['name'] = name.text;
      request.fields['dob'] = formattedDob;
      request.fields['email'] = Address.text;
      request.fields['phone'] = mobile.text;


      if (pickedProfileImage != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'image',
          pickedProfileImage!.path,
        ));
      }


      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      if (token != null) {
        request.headers.addAll({'Authorization': 'Bearer $token'});
      }


      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);
      var res = jsonDecode(responseBody.body);


      if (response.statusCode == 200 && res['status'] == true) {
        showCustomSnackBar(
          context: context,
          errorMessage: res['message'] ?? 'Profile updated successfully',
        );

        dob.clear();
        Address.clear();
        name.clear();
        mobile.clear();
        pickedProfileImage = null;
        Get.back();
      } else {

        String errorMsg = '';
        if (res['message'] is Map<String, dynamic>) {
          res['message'].forEach((key, value) {
            if (value is List && value.isNotEmpty) {
              errorMsg = value.first;
            }
          });
        } else {
          errorMsg = res['message'].toString();
        }
        showCustomSnackBar(context: context, errorMessage: errorMsg);
      }
    } catch (e) {
      debugPrint("updateProfile error: $e");
      showCustomSnackBar(context: context, errorMessage: 'An error occurred');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getSupportReason(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final dynamic response = await repo.getSupportReasonListRepo(
        token: preferences.getString('token') ?? '');
    if (response is Map && response['status'] == true &&
        response['data'] is List) {
      supportReasonModelList.addAll(List.from(
          response['data'].map((it) => SupportReasonModel.fromJson(it))));
    } else {
      showCustomSnackBar(context: context,
          errorMessage: response is Map
              ? response['message'] ?? ""
              : "Try Again");
    }
  }


  Future<void> getTechnicianSupportList(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    isCustomerSupportListLoading.value = true;
    final dynamic response = await repo.getTechnicianSupportListRepo(
        token: preferences.getString('token') ?? '');
    supportModel.clear();
    if (response is Map && response['status'] == true &&
        response['data'] is List) {
      List<SupportTicketsModel> dataTickets = List.from(
          response['data'].map((it) => SupportTicketsModel.fromJson(it)));
      List<String> monthYearList = [];
      if (dataTickets.isNotEmpty) {
        for (var i in dataTickets) {
          final String result = Utils.filterMonthYearInDate(
              i.createdAt ?? i.updatedAt ?? DateTime.now().toUtc().toString());
          if (!monthYearList.contains(result)) {
            monthYearList.add(result);
          }
          i.monthYear = result;
        }
        if (monthYearList.isNotEmpty) {
          for (var i in monthYearList) {
            supportModel.add(
                SupportModel(monthYear: i,
                    supportTickets: List.from(
                        dataTickets.where((it) => it.monthYear == i))));
          }
        }
      }
    } else {
      showCustomSnackBar(context: context,
          errorMessage: response is Map
              ? response['message'] ?? ""
              : "Try Again");
    }
    isCustomerSupportListLoading.value = false;
  }


  Future<void> getReferral(BuildContext context) async {
    isLoading.value = true;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final Map response = await repo.getReferralRepo(
        token: preferences.getString('token') ?? '');

    if (response['status'] == true && response['data'] is Map) {
      referralModel = ReferralModel.fromJson(response['data']);
      referralCode = referralModel?.referralCode ??"";
      referralShareLink = "https://budgetappstudio.com/magicalwalls/user/referral/${referralCode}";
    } else {
      showCustomSnackBar(
          context: context, errorMessage: response['message'] ?? "Try Again");
    }
    isLoading.value = false;
  }

}
