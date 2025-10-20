import 'dart:ui';

import 'package:fluttertoast/fluttertoast.dart';

class ToastUtils {
  static Future<bool?> showToastMes({
    required String message,
    required Color backGroundColor,
    required Color textColor,
  }) {
    return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: backGroundColor,
      textColor: textColor,
      fontSize: 16.0,
    );
  }
}
