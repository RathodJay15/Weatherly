import 'package:shared_preferences/shared_preferences.dart';

class LocationStorage {
  static const _latKey = 'latitude';
  static const _lonKey = 'longitude';

  static Future<void> saveLocation({
    required double latitude,
    required double longitude,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_latKey, latitude);
    await prefs.setDouble(_lonKey, longitude);
  }

  static Future<double?> getLatitude() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_latKey);
  }

  static Future<double?> getLongitude() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_lonKey);
  }

  static Future<Map<String, double>?> getLocation() async {
    final prefs = await SharedPreferences.getInstance();
    final lat = prefs.getDouble(_latKey);
    final lon = prefs.getDouble(_lonKey);

    if (lat == null || lon == null) return null;

    return {'lat': lat, 'lon': lon};
  }

  static Future<void> clearLocation() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_latKey);
    await prefs.remove(_lonKey);
  }
}
