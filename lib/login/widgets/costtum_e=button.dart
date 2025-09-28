import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';

class CostumeElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final Color borderColor;
  final bool hasIcon;
  final Widget iconName;

  const CostumeElevatedButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.backgroundColor = AppColors.blueColor,
    this.borderColor = AppColors.trancColor,
    this.textStyle,
    this.hasIcon = false,
    required this.iconName,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        elevation: 0,

        padding: EdgeInsets.symmetric(vertical: height * 0.02),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(width: 2, color: borderColor),
        ),
      ),
      onPressed: onPressed,
      child: hasIcon
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                iconName ?? SizedBox(),
                Text(text, style: textStyle ?? AppStyles.MidWhite20),
              ],
            )
          : Text(text, style: textStyle ?? AppStyles.MidWhite20),
    );
  }
}
