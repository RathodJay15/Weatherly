import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weatherly/generated/fonts.gen.dart';
import 'package:weatherly/presentation/screens/seven_day_forecast.dart';
import '/generated/assets.gen.dart';
import '/core/constants/app_constants.dart';
import 'package:weatherly/core/storage/locationStorage.dart';
import 'package:weatherly/data/controller/weather_api_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

class TodayForecast extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TodayForecastState();
}

class _TodayForecastState extends State<TodayForecast> {
  final WeatherApiController _weatherController = WeatherApiController();
  SvgPicture cloudPicture = SvgPicture.asset(
    Assets.svgs.cloudMoonRain.path,
    height: 60,
    width: 60,
  );

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final location = await LocationStorage.getLocation();

    if (location != null) {
      final error = await _weatherController.loadData(
        lat: location['lat']!,
        long: location['lon']!,
      );
      if (error != null) {
        print('----Debuge:$error');
      }
      setState(() {});
    }
  }

  int _currentIndex = 0;

  void _screenChange(value) {
    setState(() {
      _currentIndex = value;
    });
    if (value == 2) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => SevenDayForecast()),
      );
    }
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40),
            // SvgPicture.asset(
            //   Assets.svgs.cloudSunRain.path,
            //   height: 280,
            //   width: 280,
            //   semanticsLabel: 'Rain cloud',
            // ),
            CachedNetworkImage(
              imageUrl: current.imgIcon,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => SvgPicture.asset(
                Assets.svgs.cloudSunRain.path,
                semanticsLabel: 'Rain cloud',
              ),
              height: 200,
              width: 200,
              fit: BoxFit.fill,
            ),
            Text(
              '${current.tempC.toString()}°',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            Text(
              AppConstants.precipitations,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(
              'Max: ${current.maxTemp}°  Min: ${current.minTemp}°',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            SizedBox(height: 20),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.45,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 10,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: SvgPicture.asset(
                        Assets.svgs.house.path,
                        height: 300,
                        width: 300,
                        semanticsLabel: 'Rain cloud',
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 3,
                    child: Container(
                      height: 250,
                      width: 400,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomLeft,
                          colors: [
                            Theme.of(context).colorScheme.onSecondary,
                            Theme.of(context).colorScheme.onSurface,
                          ],
                          stops: [0.0001, 1.0],
                        ),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.40),
                            // offset: Offset(0, 4),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 20,
                              bottom: 10,
                              left: 40,
                              right: 40,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppConstants.today,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(
                                        fontFamily: FontFamily.openSans,
                                      ),
                                ),
                                Text(
                                  DateFormat(
                                    'MMM d',
                                  ).format(current.dateTime).toString(),

                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(
                                        fontFamily: FontFamily.openSans,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: 10,
                            thickness: 2,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 20,
                            ),
                            child: SizedBox(
                              height: 135,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemExtent: 80 + 16,
                                itemCount: hourlyList.length,
                                itemBuilder: (context, index) {
                                  final hour = hourlyList[index];
                                  return Container(
                                    width: 80,
                                    margin: const EdgeInsets.only(right: 16),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${hour.tempC}°C',
                                          style: Theme.of(
                                            context,
                                          ).textTheme.headlineMedium,
                                        ),
                                        // cloudPicture,
                                        CachedNetworkImage(
                                          imageUrl: hour.imgIcon,
                                          placeholder: (context, url) =>
                                              CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              cloudPicture,
                                          height: 60,
                                          width: 60,
                                          fit: BoxFit.fill,
                                        ),
                                        Text(
                                          hour.formattedTime,
                                          style: Theme.of(
                                            context,
                                          ).textTheme.headlineMedium,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
