import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/model%20&%20provider/weather.dart';
import 'package:weather_app/services/weather_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _weatherService = WeatherService("97a624c0cdfbbae221a50bc02be22114");
  final TextEditingController _cityController = TextEditingController();
  Weather? _weather;
  late String cityName;

  _fetchWeather() async {
    cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  _searchWeather() async {
    cityName = _cityController.text;

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  // weather animation
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/json/loading.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
        return 'assets/json/snow.json';
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/json/clouds.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/json/rain.json';
      case 'thunderstorm':
        return 'assets/json/thunderstorm.json';
      case 'clear':
        return 'assets/json/clouds.json';
      default:
        return 'assets/json/clouds.json';
    }
  }

  @override
  void initState() {
    super.initState();
    // fetch weather on startup
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.height * 0.05,
                      vertical: size.height * 0.02),
                  child: TextField(
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.sentences,
                    autofocus: true,
                    style: const TextStyle(color: Colors.white),
                    onSubmitted: (_) => _searchWeather(),
                    controller: _cityController,
                    decoration: InputDecoration(
                      suffixIcon: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      contentPadding: EdgeInsets.all(size.height * 0.025),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: Colors.white, width: 1),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: Colors.white, width: 1),
                      ),
                      hintText: 'Search',
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: Colors.white, width: 1),
                      ),
                      hintStyle: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.1,
                ),
                // city name
                Text(_weather?.cityName ?? "loading city..."),
                SizedBox(
                  height: size.height * 0.1,
                ),
                //lottie animation
                Lottie.asset(getWeatherAnimation(_weather?.mainCondition),
                    fit: BoxFit.fill, height: size.height * 0.24),
                SizedBox(
                  height: size.height * 0.2,
                ),
                Column(
                  children: [
                    // tempreture
                    Text('${_weather?.tempreature.round()}°C'),
                    // Weather Condition
                    Text('${_weather?.mainCondition}'),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
