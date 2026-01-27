import 'package:weatherly/data/models/locationModel.dart';

import 'currentWeather.dart';
import 'airQuality.dart';
import 'weeklyWeather.dart';
import 'hourlyWeather.dart';
import 'sunInfo.dart';

class WeatherResponse {
  final CurrentWeather current;
  final List<HourlyWeather> hourly;
  final List<WeeaklyWeather> daily;
  final AirQuality airQuality;
  final SunInfo sunInfo;
  final LocationModel currentLocation;
  WeatherResponse({
    required this.current,
    required this.hourly,
    required this.daily,
    required this.airQuality,
    required this.sunInfo,
    required this.currentLocation,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    final forecastDays = json['forecast']['forecastday'];

    return WeatherResponse(
      currentLocation: LocationModel.fromJson(json['location']),
      current: CurrentWeather.fromJson(json['current'], forecastDays[0]['day']),
      hourly: (forecastDays[0]['hour'] as List)
          .map((e) => HourlyWeather.fromJson(e))
          .toList(),
      daily: (forecastDays as List)
          .map((e) => WeeaklyWeather.fromJson(e))
          .toList(),
      airQuality: AirQuality.fromJson(json['current']['air_quality']),
      sunInfo: SunInfo.fromJson(forecastDays[0]['astro']),
    );
  }
}
