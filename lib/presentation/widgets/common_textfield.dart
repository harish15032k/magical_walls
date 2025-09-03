import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text.dart';

class CommonTextField extends StatelessWidget {
  final String label;
  final bool isRequired;
  final String hintText;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final VoidCallback? onSuffixTap;
  final TextInputType keyboardType;
  final int? maxLength;
  final bool readonly;
  final VoidCallback? ontap;

  const CommonTextField({
    super.key,
    required this.label,
    this.isRequired = false,
    required this.hintText,
    this.controller,
    this.suffixIcon,
    this.onSuffixTap,
    this.keyboardType = TextInputType.text,
    this.maxLength,
    this.readonly = false,
    this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: CommonTextStyles.regular16.copyWith(
                color: CommonColors.secondary,
              ),
            ),
            if (isRequired) ...[
              const SizedBox(width: 2),
              const Padding(
                padding: EdgeInsets.only(top: 1),
                child: Icon(Icons.star, color: Colors.red, size: 6),
              ),
            ],
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          style: CommonTextStyles.regular16,
          onTap: ontap,
          readOnly: readonly,
          inputFormatters: [LengthLimitingTextInputFormatter(maxLength)],
          controller: controller,
          keyboardType: keyboardType,
          cursorWidth: 1,
          cursorColor: CommonColors.placeholderText,
          decoration: InputDecoration(
            filled: true,
            fillColor: CommonColors.white,

            hintText: hintText,
            hintStyle: CommonTextStyles.regular16.copyWith(
              color: CommonColors.placeholderText,
            ),
            suffixIcon: onSuffixTap != null
                ? GestureDetector(onTap: onSuffixTap, child: suffixIcon)
                : suffixIcon,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: CommonColors.textFieldGrey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: CommonColors.textFieldGrey),
            ),
          ),
        ),
      ],
    );
  }
}
