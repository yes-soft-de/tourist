import 'package:shared_preferences/shared_preferences.dart';

class LocationPreferencesHelper {
  Future<void> setKey(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('maps_key', key);
  }

  Future<String> getKey() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString('maps_key');
  }
}