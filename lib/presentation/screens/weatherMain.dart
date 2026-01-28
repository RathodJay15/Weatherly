import 'package:flutter/material.dart';
import 'package:weatherly/core/storage/locationStorage.dart';
import 'package:weatherly/presentation/screens/searchLocation.dart';
import 'seven_day_forecast.dart';
import 'today_forecast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherly/data/controller/weather_api_controller.dart';

class WeatherMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WeatherMainState();
}

class _WeatherMainState extends State<WeatherMain> {
  final WeatherApiController _weatherController = WeatherApiController();

  int _currentIndex = 0;

  void _screenChange(value) {
    setState(() {
      _currentIndex = value;
    });
  }

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    await Geolocator.getCurrentPosition().then((value) async {
      await LocationStorage.saveLocation(
        latitude: value.latitude,
        longitude: value.longitude,
      );
      final error = await _weatherController.loadData(
        lat: value.latitude,
        long: value.longitude,
      );
      if (error != null) {
        debugPrint('----Debuge:$error');
      }
    });

    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_weatherController.weatherData == null) {
      return Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).colorScheme.onPrimary,
                Theme.of(context).colorScheme.onSecondary,
                Theme.of(context).colorScheme.onSurface,
              ],
            ),
          ),
          child: Center(
            child: SizedBox(
              height: 50.0,
              width: 50.0,
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.onInverseSurface,
                strokeWidth: 5.0,
              ),
            ),
          ),
        ),
      );
    }

    final current = _weatherController.weatherData!.current;
    final hourlyList = _weatherController.weatherData!.hourly;
    final weeklyList = _weatherController.weatherData!.daily;
    final sunInfo = _weatherController.weatherData!.sunInfo;
    final airQuality = _weatherController.weatherData!.airQuality;
    final locationModel = _weatherController.weatherData!.currentLocation;
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          TodayForecast(current: current, hourlyList: hourlyList),
          SevenDayForecast(
            currentLocation: locationModel,
            airQuality: airQuality,
            current: current,
            sunInfo: sunInfo,
            weeklyList: weeklyList,
          ),
          SearchLocation(
            currentLocation: locationModel,
            airQuality: airQuality,
            current: current,
            sunInfo: sunInfo,
            weeklyList: weeklyList,
            hourlyList: hourlyList,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 30,
        onTap: (value) => _screenChange(value),

        selectedItemColor: Colors.amber,
        unselectedItemColor: Theme.of(context).colorScheme.onInverseSurface,
        backgroundColor: Theme.of(context).colorScheme.onSurface,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on_outlined),
            label: 'Location',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'Add',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'search'),
        ],
      ),
    );
  }
}
