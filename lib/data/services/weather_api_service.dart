import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import 'package:weatherly/core/constants/api_constants.dart';

class WeatherApiService {
  final Dio _dio = DioClient.instance.dio;

  Future<Response> getForcast({required lat, required long}) {
    return _dio.get(
      ApiConstants.url,
      queryParameters: {
        'key': ApiConstants.apiKey,
        'q': '$lat,$long',
        'days': 7,
        'aqi': 'yes',
        'alerts': 'no',
      },
    );
  }

  Future<Response> searchByLocation(String city) {
    return _dio.get(
      ApiConstants.url,
      queryParameters: {
        'key': ApiConstants.apiKey,
        'q': city,
        'days': 7,
        'aqi': 'yes',
        'alerts': 'no',
      },
    );
  }
}
