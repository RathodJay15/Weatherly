class CurrentWeather {
  final String tempC;
  final String minTemp;
  final String maxTemp;
  final String condition;
  final String uv;
  final int humidity;
  final DateTime dateTime;
  final String imgIcon;

  CurrentWeather({
    required this.tempC,
    required this.minTemp,
    required this.maxTemp,
    required this.condition,
    required this.uv,
    required this.humidity,
    required this.dateTime,
    required this.imgIcon,
  });

  factory CurrentWeather.fromJson(
    Map<String, dynamic> json,
    Map<String, dynamic> dayJson,
  ) {
    return CurrentWeather(
      tempC: json['temp_c'].toString(),
      minTemp: dayJson['mintemp_c'].toString(),
      maxTemp: dayJson['maxtemp_c'].toString(),
      condition: json['condition']['text'],
      uv: json['uv'].toString(),
      humidity: json['humidity'],
      dateTime: DateTime.parse(json['last_updated']),
      imgIcon: json['condition']['icon'],
    );
  }
}
