import 'package:shared_preferences/shared_preferences.dart';

class LoginPreferences {
  static const loginKey = 'login_key';
  static const roleKey = 'role_key';

  setLogin(String id, String role) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(loginKey, id);
    sharedPreferences.setString(roleKey, role);
  }

  getLoginId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(loginKey);
  }

  getLoginRole() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(roleKey);
  }
}
