import 'package:shared_preferences/shared_preferences.dart';

class AppointmentPreferences {
  static const key = 'booking_key';

  setAppointment(bool book) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(key, book);
  }

  Future<bool> getAppointment() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey(key)) {
      return Future.value(sharedPreferences.getBool(key));
    } else {
      setAppointment(true);
      return Future.value(true);
    }
  }
}
