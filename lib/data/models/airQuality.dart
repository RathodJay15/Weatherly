class AirQuality {
  final String pm25;
  final String pm10;
  final int aqi;

  AirQuality({required this.pm25, required this.pm10, required this.aqi});

  factory AirQuality.fromJson(Map<String, dynamic> json) {
    return AirQuality(
      pm25: json['pm2_5'].toString(),
      pm10: json['pm10'].toString(),
      aqi: json['us-epa-index'],
    );
  }
}
