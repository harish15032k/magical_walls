import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magical_walls/core/constants/app_colors.dart';
import 'package:magical_walls/core/constants/app_text.dart';

import 'get_start.dart';
import 'login.dart';

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

      if (mounted) {
        Get.to(
          () => const GetStart(),
          transition: Transition.rightToLeft,
          duration: const Duration(milliseconds: 500),
        );
      }
    } catch (e) {
      debugPrint("Error loading app: $e");
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Spacer(),
          Center(
            child: Image.asset(
              "assets/images/logo.png",
              width: 350,
              height: 350,
            ),
          ),

          Spacer(),
          if (_isLoading) ...[
             Text(
              "Loading",
              style:CommonTextStyles.regular12,
            ),
             SizedBox(height:Get.height*0.01 ),
            SizedBox(
              width: 100,
              child: LinearProgressIndicator(
                backgroundColor: Colors.grey.shade300,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
              ),
            ),
          ],
           SizedBox(height: Get.height*0.06),
        ],
      ),
    );
  }
}
