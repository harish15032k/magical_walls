import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text.dart';

class CommonNoDataFound extends StatelessWidget {
  final String? emptyMessage;
  const CommonNoDataFound({super.key, this.emptyMessage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/review_icon.png', width: 100),
          const SizedBox(height: 16),
          Text(
            emptyMessage ?? "No Data Found",
            style: CommonTextStyles.medium20.copyWith(
              color: CommonColors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
