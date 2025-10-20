import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';

class DialogUtils {
  static void showLoading({
    required String massage,
    required BuildContext context,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(color: AppColors.blueColor),
            SizedBox(width: 10),
            Text(massage, style: AppStyles.bold16Black),
          ],
        ),
      ),
    );
  }

  static void hiddenDialog({required BuildContext context}) {
    Navigator.pop(context);
  }

  static void alertMassage({
    required String massage,
    required BuildContext context,
    String? title,
    String? posActionName,
    Function? posAction,
    String? negActionName,
    Function? negAction,
  }) {
    List<Widget>? actions = [];
    if (posActionName != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            posAction?.call();
          },
          child: Text(posActionName, style: AppStyles.MidBlue20),
        ),
      );
    }
    if (negActionName != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            negAction?.call();
          },
          child: Text(negActionName, style: AppStyles.MidBlue20),
        ),
      );
    }
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(massage, style: AppStyles.MidBlack16),
        title: Text(title ?? ''),
        actions: actions,
      ),
    );
  }
}
