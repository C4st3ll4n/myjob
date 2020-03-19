import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingCode {
  static const String useLocation = 'settings.useLocation';
}

final Settings appSettings = Settings();

class Settings with ChangeNotifier {
  SharedPreferences preferences;

  bool get useLocation => preferences.getBool(SettingCode.useLocation) ?? true;

  Future<void> getInstance() async {
    final instance = await SharedPreferences.getInstance();
    preferences = instance;
  }

  Future<void> updateSetting(String settingCode, dynamic newValue) async {
    if (settingCode == null)
      throw AssertionError("The settingCode can not be null");

    switch (newValue.runtimeType) {
      case bool:
        preferences.setBool(settingCode, newValue);
        break;
      case String:
        preferences.setString(settingCode, newValue);
        break;
      case double:
        preferences.setDouble(settingCode, newValue);
        break;
      case int:
        preferences.setInt(settingCode, newValue);
        break;
      case List:
        preferences.setStringList(settingCode, newValue);
        break;
      default:
        throw AssertionError("Invalid type");
    }
  }
}
