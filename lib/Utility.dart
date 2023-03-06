import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'AppConfig.dart';

class Utility {
  static void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        timeInSecForIosWeb: 3,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static SystemUiOverlayStyle getSystemUiOverlayStyle(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
      systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
    );
  }

  static String? getUserDataFromSharedPreferences() {
    return AppConfig.sharedPreferences!.getString(Constant.USER_DATA_PREF_KEY);
  }

  static saveUserDataInPreferences(String data) {
    AppConfig.sharedPreferences!.setString(Constant.USER_DATA_PREF_KEY, data);
  }
}

class Constant {
  static const USER_DATA_PREF_KEY = "USER_DATA_PREF_KEY";
}

const COLORS = [
  0xFFFA903E,
  0xFFFF63B8,
  0xFFAF5CF7,
  0xFFEE675C,
  0xFF5BB974,
  0xFF4ECDE6,
];
