import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weatherly/data/models/airQuality.dart';
import 'package:weatherly/data/models/currentWeather.dart';
import 'package:weatherly/data/models/locationModel.dart';
import 'package:weatherly/data/models/sunInfo.dart';
import 'package:weatherly/data/models/weeklyWeather.dart';
import 'package:weatherly/generated/fonts.gen.dart';
import '/generated/assets.gen.dart';
import '/core/constants/app_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SevenDayForecast extends StatefulWidget {
  final CurrentWeather current;
  final List<WeeaklyWeather> weeklyList;
  final SunInfo sunInfo;
  final AirQuality airQuality;
  final LocationModel currentLocation;

  SevenDayForecast({
    required this.airQuality,
    required this.weeklyList,
    required this.current,
    required this.sunInfo,
    required this.currentLocation,
  });

  @override
  State<StatefulWidget> createState() => _SevenDayForecast();
}

class _SevenDayForecast extends State<SevenDayForecast> {
  @override
  void initState() {
    super.initState();
  }

  final ScrollController _scrollController = ScrollController();

  void _scrollLeft() {
    _scrollController.animateTo(
      _scrollController.offset - 270,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
  }

  void _scrollRight() {
    _scrollController.animateTo(
      _scrollController.offset + 270,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final current = widget.current;
    final weeklyList = widget.weeklyList;
    final sunInfo = widget.sunInfo;
    final airQuality = widget.airQuality;
    final currentLocation = widget.currentLocation;

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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 100),

            Center(
              child: Text(
                '${currentLocation.city}, ${currentLocation.region}',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            Center(
              child: Text(
                'Max: ${current.maxTemp}°  Min: ${current.minTemp}°',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Text(
                AppConstants.sevenDayForecast,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            SizedBox(height: 10),

            SizedBox(
              width: 500,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      _scrollLeft();
                    },
                    iconSize: 50,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    color: Theme.of(context).colorScheme.onInverseSurface,
                    icon: Icon(Icons.chevron_left_rounded),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 160,
                      child: ListView.builder(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        itemCount: weeklyList.length,
                        itemBuilder: (context, index) {
                          final dayData = weeklyList[index];
                          return Container(
                            width: 78,
                            margin: const EdgeInsets.only(right: 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Theme.of(context).colorScheme.onSecondary,
                                  Theme.of(context).colorScheme.onSurface,
                                ],
                                stops: const [0.5, 1.0],
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${dayData.avgTemp}°C',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineMedium,
                                ),
                                // SvgPicture.asset(
                                //   Assets.svgs.cloudMoonRain.path,
                                //   height: 60,
                                // ),
                                CachedNetworkImage(
                                  imageUrl: dayData.imgIcon,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      SvgPicture.asset(
                                        Assets.svgs.cloudMoonRain.path,
                                        height: 60,
                                      ),
                                  height: 60,
                                  width: 60,
                                  fit: BoxFit.fill,
                                ),
                                Text(
                                  dayData.shortDayName,
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
                  IconButton(
                    color: Theme.of(context).colorScheme.onInverseSurface,
                    icon: Icon(Icons.chevron_right_rounded),
                    iconSize: 50,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      _scrollRight();
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              child: Container(
                height: 200,
                width: 400,
                padding: EdgeInsets.all(20),
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
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.40),
                      // offset: Offset(0, 4),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.air,
                          size: 40,
                          color: Theme.of(context).colorScheme.onInverseSurface,
                        ),
                        SizedBox(width: 10),
                        Text(
                          AppConstants.airQuality,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontFamily: FontFamily.openSans),
                        ),
                      ],
                    ),
                    Text(
                      '${airQuality.aqi}',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontFamily: FontFamily.openSans,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Container(
                      height: 5,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).colorScheme.onPrimary,
                            Theme.of(context).colorScheme.onSecondary,
                            Theme.of(context).colorScheme.onSurface,
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          AppConstants.seeMore,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(fontFamily: FontFamily.openSans),
                        ),
                        IconButton(
                          color: Theme.of(context).colorScheme.onInverseSurface,
                          icon: Icon(Icons.chevron_right_rounded),
                          iconSize: 30,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: SizedBox(
                width: 400,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 170,
                      width: 170,
                      padding: EdgeInsets.all(10),
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
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.40),
                            // offset: Offset(0, 4),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.sunny,
                                size: 35,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onInverseSurface,
                              ),
                              SizedBox(width: 5),
                              Text(
                                AppConstants.sunRise,
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(fontFamily: FontFamily.openSans),
                              ),
                            ],
                          ),
                          Text(
                            sunInfo.sunrise,
                            style: Theme.of(context).textTheme.headlineLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontFamily.openSans,
                                ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.sunny,
                                size: 35,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onInverseSurface,
                              ),
                              SizedBox(width: 5),
                              Text(
                                AppConstants.sunSet,
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(fontFamily: FontFamily.openSans),
                              ),
                            ],
                          ),
                          Text(
                            sunInfo.sunset,
                            style: Theme.of(context).textTheme.headlineLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontFamily.openSans,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 170,
                      width: 170,
                      padding: EdgeInsets.all(10),
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
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.wb_sunny_outlined,
                                size: 35,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onInverseSurface,
                              ),
                              SizedBox(width: 5),
                              Text(
                                AppConstants.uvIndex,
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(fontFamily: FontFamily.openSans),
                              ),
                            ],
                          ),
                          Text(
                            current.uv,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.displaySmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  fontFamily: FontFamily.openSans,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
