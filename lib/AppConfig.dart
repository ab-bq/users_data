import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfig {
  static SharedPreferences? sharedPreferences;

  init() async {
    WidgetsFlutterBinding.ensureInitialized();
    sharedPreferences = await SharedPreferences.getInstance();
  }
}
