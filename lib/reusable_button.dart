// ignore_for_file: depend_on_referenced_packages

import 'package:bhpp/constant.dart';
import 'package:bhpp/reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReusableButton extends StatelessWidget {
  final String content;
  final double? btnHeight;
  final double? btnWidth;
  final VoidCallback? onTap;
  final Color? borderColor;
  final Color? backgroundColor;
  final Color? textColor;
  const ReusableButton({
    super.key,
    this.btnHeight,
    this.btnWidth,
    required this.content,
    this.onTap,
    this.borderColor,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: btnHeight ?? 20,
        width: btnWidth ?? double.infinity,
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.transparent,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: borderColor ?? Kdark,
            width: 1.5,
          ),
        ),
        child: Center(
          child: ReusableText(
            text: content,
            fontSize: 14,
            color: textColor ?? Kdark,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
