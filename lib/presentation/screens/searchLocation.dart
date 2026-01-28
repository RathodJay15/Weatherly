import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weatherly/data/controller/weather_api_controller.dart';
import 'package:weatherly/data/models/airQuality.dart';
import 'package:weatherly/data/models/currentWeather.dart';
import 'package:weatherly/data/models/hourlyWeather.dart';
import 'package:weatherly/data/models/locationModel.dart';
import 'package:weatherly/data/models/sunInfo.dart';
import 'package:weatherly/data/models/weeklyWeather.dart';
import 'package:weatherly/generated/fonts.gen.dart';
import '/generated/assets.gen.dart';
import '/core/constants/app_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

class SearchLocation extends StatefulWidget {
  final CurrentWeather current;
  final List<WeeaklyWeather> weeklyList;
  final SunInfo sunInfo;
  final AirQuality airQuality;
  final LocationModel currentLocation;
  final List<HourlyWeather> hourlyList;

  SearchLocation({
    required this.airQuality,
    required this.weeklyList,
    required this.current,
    required this.sunInfo,
    required this.currentLocation,
    required this.hourlyList,
  });

  @override
  State<StatefulWidget> createState() => _searchLocationState();
}

class _searchLocationState extends State<SearchLocation> {
  final WeatherApiController _weatherController = WeatherApiController();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textSearchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  late CurrentWeather _current;
  late List<WeeaklyWeather> _weeklyList;
  late SunInfo _sunInfo;
  late AirQuality _airQuality;
  late LocationModel _currentLocation;
  late List<HourlyWeather> _hourlyList;

  bool _isSearching = false;

  void _startSearch() {
    setState(() => _isSearching = true);
    _searchFocusNode.requestFocus();
  }

  void _onSearchPressed(value) async {
    FocusScope.of(context).unfocus();

    if (value != null) {
      final city = value.trim();
      final error = await _weatherController.loadSearchedData(city: city);
      if (error != null) {
        debugPrint('----Debuge:$error');
      }
      setState(() {
        _current = _weatherController.weatherData!.current;
        _weeklyList = _weatherController.weatherData!.daily;
        _sunInfo = _weatherController.weatherData!.sunInfo;
        _airQuality = _weatherController.weatherData!.airQuality;
        _currentLocation = _weatherController.weatherData!.currentLocation;
        _hourlyList = _weatherController.weatherData!.hourly;
      });
    }
  }

  void _closeOrClearSearch() {
    if (_textSearchController.text.isNotEmpty) {
      _textSearchController.clear();
    } else {
      _searchFocusNode.unfocus();
      setState(() => _isSearching = false);
    }
  }

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
  void initState() {
    super.initState();
    _current = widget.current;
    _weeklyList = widget.weeklyList;
    _sunInfo = widget.sunInfo;
    _airQuality = widget.airQuality;
    _currentLocation = widget.currentLocation;
    _hourlyList = widget.hourlyList;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _textSearchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              SizedBox(
                width: 500,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: TextField(
                    controller: _textSearchController,
                    focusNode: _searchFocusNode,
                    onTap: _startSearch,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (value) => _onSearchPressed(value),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onInverseSurface,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Search products...',
                      hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onInverseSurface,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Theme.of(context).colorScheme.onInverseSurface,
                      ),
                      filled: true,
                      fillColor: Theme.of(
                        context,
                      ).colorScheme.onSurfaceVariant.withValues(alpha: 0.30),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (_isSearching)
                            IconButton(
                              icon: Icon(
                                Icons.close,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onInverseSurface,
                              ),
                              onPressed: _closeOrClearSearch,
                            ),
                          TextButton(
                            onPressed: () =>
                                _onSearchPressed(_textSearchController.text),
                            child: Text(
                              'Search',
                              style: TextStyle(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onInverseSurface,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Text(
                  '${_currentLocation.city}, ${_currentLocation.region}',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              Center(
                child: Text(
                  'Max: ${_current.maxTemp}°  Min: ${_current.minTemp}°',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 200,
                  width: 450,
                  padding: EdgeInsets.symmetric(horizontal: 20),
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppConstants.today,
                              style: Theme.of(context).textTheme.headlineMedium
                                  ?.copyWith(fontFamily: FontFamily.openSans),
                            ),
                            Text(
                              DateFormat(
                                'MMM d',
                              ).format(_current.dateTime!).toString(),

                              style: Theme.of(context).textTheme.headlineMedium
                                  ?.copyWith(fontFamily: FontFamily.openSans),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 2,
                        thickness: 2,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        child: SizedBox(
                          height: 120,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemExtent: 80 + 16,
                            itemCount: _hourlyList.length,
                            itemBuilder: (context, index) {
                              final hour = _hourlyList[index];
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
                                    CachedNetworkImage(
                                      imageUrl: hour.imgIcon!,
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
                                      hour.formattedTime!,
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
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Text(
                  AppConstants.sevenDayForecast,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
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
                          itemCount: _weeklyList.length,
                          itemBuilder: (context, index) {
                            final dayData = _weeklyList[index];
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
                                  CachedNetworkImage(
                                    imageUrl: dayData.imgIcon!,
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 15,
                ),
                child: Container(
                  width: 400,
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
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.40),
                        // offset: Offset(0, 4),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.air,
                        size: 40,
                        color: Theme.of(context).colorScheme.onInverseSurface,
                      ),
                      SizedBox(width: 10),
                      Text(
                        '${AppConstants.airQuality}: ',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontFamily: FontFamily.openSans,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        '${_airQuality.aqi}',
                        style: Theme.of(context).textTheme.displaySmall
                            ?.copyWith(fontFamily: FontFamily.openSans),
                        overflow: TextOverflow.ellipsis,
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
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
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
                                      ?.copyWith(
                                        fontFamily: FontFamily.openSans,
                                      ),
                                ),
                              ],
                            ),
                            Text(
                              _sunInfo.sunrise!,
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
                                      ?.copyWith(
                                        fontFamily: FontFamily.openSans,
                                      ),
                                ),
                              ],
                            ),
                            Text(
                              _sunInfo.sunset!,
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
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
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
                                      ?.copyWith(
                                        fontFamily: FontFamily.openSans,
                                      ),
                                ),
                              ],
                            ),
                            Text(
                              _current.uv!,
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
      ),
    );
  }
}
