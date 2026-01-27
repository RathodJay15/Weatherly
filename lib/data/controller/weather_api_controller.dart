import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:weatherly/data/services/weather_api_service.dart';
import 'package:weatherly/data/models/weatherResponse.dart';

class WeatherApiController {
  WeatherResponse? weatherData;
  final WeatherApiService _service = WeatherApiService();

  Future<String?> loadData({required double lat, required double long}) async {
    try {
      final response = await _service.getForcast(lat: lat, long: long);

      weatherData = WeatherResponse.fromJson(response.data);
      return null;
    } on DioException catch (e) {
      debugPrint('DIO ERROR TYPE: ${e.type}');
      debugPrint('DIO ERROR MESSAGE: ${e.message}');
      debugPrint('DIO ERROR RESPONSE: ${e.response?.data}');
      debugPrint('DIO STATUS CODE: ${e.response?.statusCode}');

      if (e.type == DioExceptionType.receiveTimeout) {
        return 'Request timed out. Retry?';
      }

      return 'Failed to load weather data';
    }
  }
}
