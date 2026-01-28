import 'package:intl/intl.dart';

class HourlyWeather {
  final DateTime? time;
  final String? tempC;
  final String? condition;
  late final String? formattedTime;
  final String? imgIcon;

  HourlyWeather({
    required this.time,
    required this.tempC,
    required this.condition,
    required this.imgIcon,
  }) {
    formattedTime = DateFormat('h a').format(time!);
  }

  factory HourlyWeather.fromJson(Map<String, dynamic> json) {
    return HourlyWeather(
      time: DateTime.parse(json['time']),
      tempC: json['temp_c'].toString(),
      condition: json['condition']['text'],
      imgIcon: json['condition']['icon'],
    );
  }
}
