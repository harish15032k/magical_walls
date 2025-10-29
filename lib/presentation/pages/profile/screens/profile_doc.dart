import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magical_walls/core/constants/app_colors.dart';
import 'package:magical_walls/core/constants/app_text.dart';
import 'package:magical_walls/presentation/pages/profile/model/profile_model.dart';

class DocumentsScreen extends StatelessWidget {
  Data data;
   DocumentsScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Image.asset(
                      'assets/images/arrow-left.png',
                      width: 25,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text("Documents", style: CommonTextStyles.medium20),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: CommonColors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: CommonColors.textFieldGrey,
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDocumentSection(
                      title: "Aadhaar Card",
                      imagePath: data.aadharCard??'',
                      isVerified: true,
                    ),
                    const SizedBox(height: 15),
                    _buildDocumentSection(
                      title: "Pan Card",
                      imagePath:data.panCard??'',
                      isVerified: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDocumentSection({
    required String title,
    required String imagePath,
    required bool isVerified,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: CommonTextStyles.regular14.copyWith(
                color: CommonColors.secondary,
              ),
            ),
            if (isVerified)
              Container(
                decoration: BoxDecoration(
                  color: CommonColors.green.withAlpha(30),
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/tick.png", width: 12),
                    const SizedBox(width: 3),
                    Text(
                      "Verified",
                      style: CommonTextStyles.semiBold12.copyWith(color: CommonColors.green),
                    ),
                  ],
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Container( width: 150,
    height: 100,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(3)),
          clipBehavior: Clip.hardEdge,
          child: Image.network(
            imagePath,
            width: 150,
            height: 100,
            fit: BoxFit.cover, loadingBuilder: (c, l, w) {
            if (w == null) {
              return l;
            }
            return Center(child: CircularProgressIndicator(
              color: CommonColors.primaryColor, strokeWidth: 2,),);
          },
          ),
        ),
      ],
    );
  }
}