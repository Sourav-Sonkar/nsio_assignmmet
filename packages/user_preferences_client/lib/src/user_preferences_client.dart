import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static SharedPreferences? _pref;

  static Future<void> _init() async {
    _pref ??= await SharedPreferences.getInstance();
  }
  static void setlogged(bool islogged) async {
    await _init();
    await _pref?.setBool(_islogged, islogged);
  }

  static Future<bool> getlogged() async {
    await _init();
    return _pref!.getBool(_islogged) ?? false;
  }
  static void setUserName(String name) async {
    await _init();
    await _pref?.setString(userName, name);
  }
  static Future<String> getUserName() async {
    await _init();
    return _pref!.getString(userName) ?? "";
  }
  static void setUserEmail(String email) async {
    await _init();
    await _pref?.setString(userEmail, email);
  }
  static Future<String> getUserEmail() async {
    await _init();
    return _pref!.getString(userEmail) ?? "";
  }
  static void setUserPhoto(String photo) async {
    await _init();
    await _pref?.setString(userPhoto, photo);
  }
  static Future<String> getUserPhoto() async {
    await _init();
    return _pref!.getString(userPhoto) ?? "";
  }
  static clearStorage() async {
    await _init();
    await _pref?.clear();
  }

  static const String _islogged="islogged";
  static const String userName="userName";
  static const String userEmail="userEmail";
  static const String userPhoto="userPhoto";
}
