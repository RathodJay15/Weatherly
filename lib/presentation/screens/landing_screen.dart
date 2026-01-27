import 'package:flutter/material.dart';
import 'package:weatherly/core/theme/color_scheme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weatherly/generated/fonts.gen.dart';
import 'package:weatherly/presentation/screens/today_forecast.dart';
import 'package:weatherly/presentation/screens/weatherMain.dart';
import '/generated/assets.gen.dart';
import 'package:geolocator/geolocator.dart';
import '/core/constants/app_constants.dart';
import 'package:weatherly/core/storage/locationStorage.dart';

class LandingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Service Disabled!');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permission denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Permission Denied Forever');
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation().then((value) {
      LocationStorage.saveLocation(
        latitude: value.latitude,
        longitude: value.longitude,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              SvgPicture.asset(
                Assets.svgs.cloudSunRain.path,
                height: 400,
                width: 400,
                semanticsLabel: 'Rain cloud',
              ),
              SizedBox(height: 40),
              Text(
                AppConstants.weather,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              Text(
                AppConstants.forecasts,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              SizedBox(height: 40),
              SizedBox(
                width: 300,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.commonAccent,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => WeatherMain()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'Get Start',
                      style: Theme.of(context).textTheme.headlineLarge
                          ?.copyWith(
                            fontFamily: FontFamily.openSans,
                            fontWeight: FontWeight.bold,
                            color: AppColors.commonButtonText,
                          ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
