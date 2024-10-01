// ignore_for_file: depend_on_referenced_packages, unnecessary_import

import 'package:bhpp/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReusableTextfield extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final Icon? prefixIcon;
  final Color? prefixIconColor;
  final TextInputType? textInputType;
  final Color? borderColor;
  const ReusableTextfield({
    super.key,
    required this.hintText,
    this.controller,
    this.prefixIcon,
    this.prefixIconColor,
    this.textInputType,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Kgray,
        ),
        prefixIcon: prefixIcon,
        prefixIconColor: prefixIconColor ?? Kdark,
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: const BorderSide(color: Kgray, width: 1.3)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: const BorderSide(color: Kgray, width: 1.3)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: borderColor ?? Kdark, width: 1.3)),
      ),
      cursorColor: Kdark,
      controller: controller,
      keyboardType: textInputType,
      style: const TextStyle(color: Kdark),
    );
  }
}
