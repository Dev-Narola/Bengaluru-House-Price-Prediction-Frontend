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
  final Color? offBorder;
  final Color? textColor;
  final Color? inputColor;
  final Color? cursorColor;
  const ReusableTextfield({
    super.key,
    required this.hintText,
    this.controller,
    this.prefixIcon,
    this.prefixIconColor,
    this.textInputType,
    this.borderColor,
    this.offBorder,
    this.textColor,
    this.inputColor,
    this.cursorColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: textColor ?? Kgray,
        ),
        prefixIcon: prefixIcon,
        prefixIconColor: prefixIconColor ?? Kdark,
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: offBorder ?? Kgray, width: 1.3)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: offBorder ?? Kgray, width: 1.3)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: borderColor ?? Kdark, width: 1.3)),
      ),
      cursorColor: cursorColor ?? Kdark,
      controller: controller,
      keyboardType: textInputType,
      style: TextStyle(color: inputColor ?? Kdark),
    );
  }
}
