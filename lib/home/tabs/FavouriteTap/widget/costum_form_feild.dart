import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';

import '../../../../utils/app_colors.dart';

typedef OnValidator = String? Function(String?)?;

class CostumeFormField extends StatelessWidget {
  Color borderSideColor;
  String? hintText;
  String? labelText;
  TextStyle? hintTextStyle;
  TextStyle? labelTextStyle;
  Widget? prefixIcon;
  Widget? suffixIcon;
  TextInputType? KeyboardType;
  OnValidator? validator;
  bool? obscureText;
  TextEditingController? controller;
  int maxLines;


  CostumeFormField({
    super.key,
    this.borderSideColor = AppColors.greyColor,
    this.hintText,
    this.labelText,
    this.hintTextStyle,
    this.labelTextStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.KeyboardType = TextInputType.text,
    this.obscureText = false,
    required this.controller,
    this.maxLines = 1
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: height * 0.02,
        horizontal: width * 0.03,
      ),
      child: TextFormField(
        style: Theme.of(context).textTheme.headlineLarge,
        controller: controller,
        obscureText: obscureText!,
        keyboardType: KeyboardType,
        validator: validator,
        maxLines: maxLines,
        decoration: InputDecoration(
          enabledBorder: buildDecorationBorder(
            borderSideColor: borderSideColor,
          ),
          focusedBorder: buildDecorationBorder(
            borderSideColor: borderSideColor,
          ),
          errorBorder: buildDecorationBorder(
            borderSideColor: AppColors.redColor,
          ),
          focusedErrorBorder: buildDecorationBorder(
            borderSideColor: AppColors.redColor,
          ),
          hintText: hintText,
          labelText: labelText,
          labelStyle: labelTextStyle ?? AppStyles.MidGreyt16,
          hintStyle: hintTextStyle ?? AppStyles.MidGreyt16,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }

  OutlineInputBorder buildDecorationBorder({required Color borderSideColor}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: borderSideColor, width: 2),
    );
  }
}
