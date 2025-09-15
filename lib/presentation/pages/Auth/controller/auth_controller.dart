import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magical_walls/core/utils/utils.dart';
import 'package:magical_walls/presentation/pages/Auth/model/auth_model.dart';
import 'package:magical_walls/presentation/pages/Auth/model/service_listmodel.dart';
import 'package:magical_walls/presentation/pages/Auth/repository/auth_repository.dart';
import 'package:magical_walls/presentation/pages/Auth/screens/kyc/profile_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Home/screens/bottom_bar.dart';
import '../model/verify_otp_model.dart';
import '../screens/kyc/service_add.dart';
import '../screens/otp_screen.dart';
class AuthController extends GetxController {

  AuthRepository repo = AuthRepository();

  final TextEditingController mobile = TextEditingController();
  var isLoading = false.obs;
  var serviceList = <Datum>[].obs;
  List<dynamic> selectedService = [].obs;

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
      }
      else{
        showCustomSnackBar(context: context, errorMessage: res.message??'');
      }
    } catch (e) {
      debugPrint("getOtp error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  verifyOtp(String pin,String mobile,BuildContext context) async {
    try {
      print('mobile $mobile');
      isLoading.value = true;
      Map<String, String> request = {'phone': mobile, 'code': pin};
      VerifyOtpRes res = await repo.verifyOtp(request);

      if (res.status == true) {
        SharedPreferences prefs = await SharedPreferences.getInstance();


        await prefs.setString('token', res.data?.token ?? '');
        await prefs.setBool('isLogin', true);


        await prefs.setInt('isKycCompleted', res.data!.isKyc??0);


        if (res.data?.isKyc == 1) {
          bool? iskycverifiedfromadmin = prefs.getBool("iskycverified");
          if(iskycverifiedfromadmin==true){
            Get.offAll(() => BottomBar());

          }else{
          Get.offAll(() => ProfileUnderReview());}
        } else {
          Get.offAll(() => SelectService(), transition: Transition.rightToLeft);
        }
      }
      else{
        showCustomSnackBar(context: context, errorMessage: res.message??'');

      }
    } catch (e) {
      debugPrint("verifyOtp error: $e");
    } finally {
      isLoading.value = false;
    }
  }
  getServiceList()async{
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var token = prefs.getString('token');

      isLoading.value=true;
      ServiceListRes res =await repo.serviceList(token!);
      if(res.status==true){
         serviceList.value=res.data!;

      }

    }catch(e){

    }finally{
      isLoading.value=false;


    }
  }
}

