import 'package:flutter/material.dart';

import '../../../../core/constants/api_urls.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text.dart';

class ShareAppBottomSheet extends StatelessWidget {
  final bool isWhatsappShare;

  const ShareAppBottomSheet({super.key, required this.isWhatsappShare});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color:Colors.grey.shade400,
              borderRadius: BorderRadius.circular(10),
            ),
          ),),
          const SizedBox(height: 20),
          Text(
            'Share App',
            style: CommonTextStyles.bold16,
          ),
          const SizedBox(height: 20),

          _shareTile(
            icon: Icons.person,
            title: 'Share User App',
            onTap: () {
              Navigator.pop(context, AppConstants.user);
            },
          ),

          const SizedBox(height: 12),

          _shareTile(
            icon: Icons.build,
            title: 'Share Technician App',
            onTap: () {
              Navigator.pop(context, AppConstants.technician);
            },
          ),
        ],
      ),
    );
  }

  Widget _shareTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: CommonColors.primaryColor,),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Image.asset(isWhatsappShare
                ? 'assets/images/ic_whatapp.png'
                : 'assets/images/ic_referral_share.png', width: 24,
              height: 24,
            ),
            const SizedBox(width: 14),
            Text(
              title,
              style: CommonTextStyles.regular14.copyWith(color: CommonColors.primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
