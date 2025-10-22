import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magical_walls/presentation/pages/Home/screens/bottom_bar.dart';
import 'package:magical_walls/presentation/pages/location/screens/location_access.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:magical_walls/core/constants/app_colors.dart';
import 'package:magical_walls/core/constants/app_text.dart';
import 'package:magical_walls/presentation/pages/Auth/screens/get_start.dart';
import 'package:magical_walls/presentation/pages/Auth/screens/login.dart';
import 'package:magical_walls/presentation/pages/Auth/screens/kyc/profile_review.dart';
import 'package:magical_walls/presentation/pages/Auth/screens/kyc/service_add.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAppData();
  }

  Future<void> _loadAppData() async {
    try {
      await Future.delayed(const Duration(seconds: 2));

      final prefs = await SharedPreferences.getInstance();
      bool? isFirstOpen = prefs.getBool("isFirstOpen");
      bool? isLogin = prefs.getBool("isLogin");
      int? isKycCompleted = prefs.getInt("isKycCompleted");
      bool? isKycVerified = prefs.getBool("isKycVerified");
      bool? isLocationUpdated = prefs.getBool("locationUpdated");

      Widget nextScreen;

      if (isFirstOpen == null || isFirstOpen == true) {
        prefs.setBool("isFirstOpen", false);
        nextScreen = const GetStart();
      } else if (isLogin != true) {
        nextScreen = const LoginScreen();
      } else if (isKycCompleted != 1) {
        nextScreen = const SelectService();
      } else if (isKycVerified == true) {
        nextScreen =  isLocationUpdated==true? BottomBar():LocationAccessScreen();
      } else {
        nextScreen = const ProfileUnderReview();
      }

      if (mounted) {
        Get.offAll(
          () => nextScreen,
          transition: Transition.rightToLeft,
          duration: const Duration(milliseconds: 500),
        );
      }
    } catch (e) {
      debugPrint("Error loading app: $e");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Center(
            child: Image.asset(
              "assets/images/logo.png",
              width: 350,
              height: 350,
            ),
          ),
          const Spacer(),
          if (_isLoading) ...[
            Text("Loading", style: CommonTextStyles.regular12),
            SizedBox(height: Get.height * 0.01),
            SizedBox(
              width: 100,
              child: LinearProgressIndicator(
                backgroundColor: Colors.grey.shade300,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
              ),
            ),
          ],
          SizedBox(height: Get.height * 0.08),
        ],
      ),
    );
  }
}
