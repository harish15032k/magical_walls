import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magical_walls/core/constants/app_colors.dart';
import 'package:magical_walls/core/constants/app_text.dart';
import 'package:magical_walls/presentation/pages/Auth/screens/login.dart';
import 'package:magical_walls/presentation/widgets/common_button.dart';

class GetStart extends StatefulWidget {
  const GetStart({super.key});

  @override
  State<GetStart> createState() => _GetStartState();
}

class _GetStartState extends State<GetStart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.white,
      body: ListView(
        padding: EdgeInsets.only(top: 0),
        children: [
          Container(
            color: Colors.amber,
            margin: EdgeInsets.fromLTRB(70, 70, 70, 25),
            child: Image.asset('assets/images/logo.png'),
          ),

          Image.asset("assets/images/painters.png"),
          SizedBox(height: Get.height * 0.025),
          Center(
            child: Text(
              'Welcome to Magicwall,\n   Technician Partner!',
              style: CommonTextStyles.medium24,
            ),
          ),
          SizedBox(height: Get.height * 0.018),
          Center(
            child: Text(
              'We’re excited to have you on board! Let’s get you set \n   up to start accepting service bookings and grow \n                          your business with us.',
              style: CommonTextStyles.regular16.copyWith(
                color: CommonColors.secondary,
              ),
            ),
          ),
          SizedBox(height: Get.height * 0.13),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: CommonButton(
              text: 'Get Started',
              onTap: () {
                Get.to(
                  () => LoginScreen(),
                  transition: Transition.downToUp,
                  duration: Duration(milliseconds: 500),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
