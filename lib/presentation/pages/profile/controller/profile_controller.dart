import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:magical_walls/core/utils/utils.dart';
import 'package:magical_walls/presentation/pages/Auth/screens/login.dart';
import 'package:magical_walls/presentation/pages/profile/repository/profile_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/profile_model.dart';

class ProfileController extends GetxController {
  ProfileRepository repo = ProfileRepository();
  var isAvailable = false.obs;
  final TextEditingController dob = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController mobile = TextEditingController();
  final TextEditingController Address = TextEditingController();
  File? pickedProfileImage;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    getProfile().then((_) {
      if (profileData.isNotEmpty) {
        isAvailable.value = profileData.first.status == 'available';
      }
    });
    ever(profileData, (_) {
      if (profileData.isNotEmpty) {
        isAvailable.value = profileData.first.status == 'available';
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
        profileData.first.status = status ? 'available' : 'unavailable';
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

      Map<String, dynamic> request = {'message': message, 'subject': 'support'};
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
    Get.offAll(LoginScreen());
  }

  updateProfile(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      isLoading.value = true;

      Map<String, dynamic> request = {
        'name': name.text,
        'dob': dob.text,
        'email': Address.text,
        'phone': mobile.text,
        'image': pickedProfileImage!.path!,
      };
      final res = await repo.updateProfile(request, token!);
      if (res['status'] == true) {
        showCustomSnackBar(context: context, errorMessage: res['message']);
        Get.back();
        dob.clear();
        Address.clear();
        name.clear();
        mobile.clear();
      } else {
        showCustomSnackBar(context: context, errorMessage: res['message']);
      }
    } finally {
      isLoading.value = false;
    }
  }
}
