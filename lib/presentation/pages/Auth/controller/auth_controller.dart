import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magical_walls/presentation/pages/Auth/model/auth_model.dart';
import 'package:magical_walls/presentation/pages/Auth/repository/auth_repository.dart';
import 'package:magical_walls/presentation/pages/Auth/screens/kyc/profile_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Home/screens/bottom_bar.dart';
import '../screens/kyc/service_add.dart';
import '../screens/otp_screen.dart';
class AuthController extends GetxController {
  AuthRepository repo = AuthRepository();
  final TextEditingController mobile = TextEditingController();
  var isLoading = false.obs;

  getOtp() async {
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
      }
    } catch (e) {
      debugPrint("getOtp error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  verifyOtp(String pin) async {
    try {
      isLoading.value = true;
      Map<String, String> request = {'phone': mobile.text, 'code': pin};
      GetOtpRes res = await repo.verifyOtp(request);

      if (res.status == true) {
        SharedPreferences prefs = await SharedPreferences.getInstance();


        await prefs.setString('token', res.data?.token ?? '');
        await prefs.setBool('isLogin', true);


        await prefs.setBool('isKycCompleted', res.data?.iskycompleted ?? false);


        if (res.data?.iskycompleted == true) {
          bool? iskycverifiedfromadmin = prefs.getBool("iskycverified");
          if(iskycverifiedfromadmin==true){
            Get.offAll(() => BottomBar());

          }else{
          Get.offAll(() => ProfileUnderReview());}
        } else {
          Get.offAll(() => SelectService(), transition: Transition.rightToLeft);
        }
      }
    } catch (e) {
      debugPrint("verifyOtp error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}

