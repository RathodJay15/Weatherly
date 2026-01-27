import 'package:flutter/material.dart';
import 'seven_day_forecast.dart';
import 'today_forecast.dart';

class WeatherMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WeatherMainState();
}

class _WeatherMainState extends State<WeatherMain> {
  int _currentIndex = 0;

  void _screenChange(value) {
    setState(() {
      _currentIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [TodayForecast(), SevenDayForecast()],
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
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
        ],
      ),
    );
  }
}
