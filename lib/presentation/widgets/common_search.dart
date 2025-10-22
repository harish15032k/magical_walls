import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text.dart';

class CommonSearch extends StatelessWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final VoidCallback? ontap;
  final VoidCallback? suffixontap;
  final bool? readonly;
  final bool? issuffixneed;

  const CommonSearch({
    super.key,
    this.hintText = "Search",
    this.onChanged,
    this.controller,
    this.ontap,
    this.suffixontap,
    this.readonly = false,
    this.issuffixneed = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: ontap,
      readOnly: readonly!,
      controller: controller,
      style: CommonTextStyles.regular16,
      cursorWidth: 1,
      cursorColor: CommonColors.placeholderText,
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: CommonColors.fileUpload,
        hintText: hintText,
        hintStyle: CommonTextStyles.regular16.copyWith(
          color: CommonColors.placeholderText,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.fromLTRB(18.0, 18, 10, 18),
          child: Image.asset(
            'assets/images/search-normal.png',
            width: 20,
            color: CommonColors.black,
          ),
        ),
        suffixIcon: issuffixneed!
            ? Padding(
                padding: const EdgeInsets.fromLTRB(18.0, 18, 10, 18),
                child: GestureDetector(
                  onTap: suffixontap,
                  child: Image.asset(
                    'assets/images/close-circle.png',
                    width: 20,
                    color: CommonColors.black,
                  ),
                ),
              )
            : null,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: CommonColors.textFieldGrey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: CommonColors.textFieldGrey),
        ),
      ),
    );
  }
}
