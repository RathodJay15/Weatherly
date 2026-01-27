class SunInfo {
  final String sunrise;
  final String sunset;

  SunInfo({required this.sunrise, required this.sunset});

  factory SunInfo.fromJson(Map<String, dynamic> json) {
    return SunInfo(sunrise: json['sunrise'], sunset: json['sunset']);
  }
}
