class WeeaklyWeather {
  final DateTime? date;
  final String? minTemp;
  final String? maxTemp;
  final String? avgTemp;
  final String? condition;
  final String? imgIcon;

  WeeaklyWeather({
    required this.date,
    required this.minTemp,
    required this.maxTemp,
    required this.condition,
    required this.avgTemp,
    required this.imgIcon,
  });

  factory WeeaklyWeather.fromJson(Map<String, dynamic> json) {
    return WeeaklyWeather(
      date: DateTime.parse(json['date']),
      minTemp: json['day']['mintemp_c'].toString(),
      maxTemp: json['day']['maxtemp_c'].toString(),
      condition: json['day']['condition']['text'],
      avgTemp: json['day']['avgtemp_c'].toString(),
      imgIcon: json['day']['condition']['icon'],
    );
  }
  String get dayName {
    const days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    return days[date!.weekday - 1];
  }

  String get shortDayName {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[date!.weekday - 1];
  }
}
