import 'package:shared_preferences/shared_preferences.dart';

class BookingPreferences {
  static const key = 'booking_key';

  setBooking(String booking) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(key, booking);
  }

  Future<String> getBooking() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey(key)) {
      return Future.value(sharedPreferences.getString(key));
    } else {
      setBooking('BOOK FOR APPOINTMENT');
      return Future.value('BOOK FOR APPOINTMENT');
    }
  }
}
