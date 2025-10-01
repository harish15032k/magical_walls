import 'package:flutter/material.dart';
import 'package:magical_walls/core/constants/app_colors.dart';
import 'package:magical_walls/core/constants/app_text.dart';

class CommonButton extends StatelessWidget {
  final String text;
  final double? width;
  final double height;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final double borderRadius;
  final VoidCallback? onTap;
  final bool isLoading;
  final bool isimageneed;
  final String? imagefile;

  const CommonButton({
    super.key,
    required this.text,
    this.width,
    this.height = 43,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.borderRadius = 8,
    this.onTap,
    this.isLoading = false,
    this.isimageneed = false,
    this.imagefile,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        height: height,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          color: backgroundColor ?? CommonColors.white,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: borderColor ?? CommonColors.primaryColor,
            width: 1,
          ),
        ),
        alignment: Alignment.center,
        child: isLoading
            ?  SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: textColor,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isimageneed
                      ? Image.asset(imagefile!, width: 18)
                      : SizedBox.shrink(),
                  if (isimageneed) SizedBox(width: 8),
                  Text(
                    text,
                    style: CommonTextStyles.medium16.copyWith(
                      color: textColor ?? CommonColors.primaryColor,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
