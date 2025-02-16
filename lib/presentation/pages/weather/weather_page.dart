import 'dart:ui';

import 'package:auth_weather_api/data/models/weather_model.dart';
import 'package:auth_weather_api/data/repository/auth/auth_repository.dart';
import 'package:auth_weather_api/data/repository/weather_repository.dart';
import 'package:auth_weather_api/main.dart';
import 'package:auth_weather_api/presentation/blocs/carBloc/car_bloc.dart';
import 'package:auth_weather_api/presentation/blocs/profile/profile_bloc.dart';
import 'package:auth_weather_api/presentation/pages/login/login_page.dart';
import 'package:auth_weather_api/presentation/widgets/car_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //api key
  final _weatherRepository =
      WeatherRepository('06f10f8e70d0bebd652c3d8e46805467');
  Weather? _weather;

  _fetchWeather() async {
    //get the current city
    String cityName = await _weatherRepository.getCurrentCity();
    //get weather for the city
    try {
      final weather = await _weatherRepository.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json'; //default to Sunny

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloudy.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rainy.json';
      case 'thunderstorm':
        return 'assets/thunderstorm.json';
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProfileLoaded) {
            return Padding(
              padding:
                  const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
              child: SizedBox(
                //display weather widget here..
                height: MediaQuery.sizeOf(context).height,
                child: Stack(
                  children: [
                    Align(
                        alignment: const AlignmentDirectional(3, -0.3),
                        child: Container(
                          height: 300,
                          width: 300,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.deepPurple),
                        )),
                    Align(
                        alignment: const AlignmentDirectional(-3, -0.3),
                        child: Container(
                          height: 300,
                          width: 300,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.deepPurple),
                        )),
                    Align(
                        alignment: const AlignmentDirectional(0, -1.2),
                        child: Container(
                          height: 300,
                          width: 600,
                          decoration: const BoxDecoration(
                              //shape: BoxShape.circle,
                              color: Color(0xFFFFAB40)),
                        )),
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                      child: Container(
                        decoration:
                            const BoxDecoration(color: Colors.transparent),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '📍 ${_weather?.cityName}' ?? "loading..city",
                                style:  TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.transparent,
                                    onPrimary: Colors.white,
                                    minimumSize: Size(10, 50)),
                                onPressed: () {
                                  print('signout');
                                  context.read<AuthRepository>().signOut();
                                  print('i have logged out');
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => HomePage()));
                                  print('move to the page');
                                },
                                child:  Text(
                                  'Sign out',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          const Text(
                            'Welcome Buddy!',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                          Lottie.asset(getWeatherAnimation(
                              _weather?.mainCondition ?? "Loading..")),
                          Center(
                              child: Text(
                            '${_weather?.temperature.round()}°C' ??
                                'Loading Weather...',
                            style: const TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          )),
                          Center(
                              child: Text(
                            _weather?.mainCondition ?? "",
                            style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          )),
                          const SizedBox(
                            height: 50,
                          ),
                          BlocBuilder<CarBloc, CarState>(
                            builder: (context, state) {
                              if (state is CarsLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (state is CarsLoaded) {
                                return Positioned(
                                    left: 0,
                                    right: 0,
                                    bottom: 0,
                                    child: Container(
                                      height: 300,
                                      width: 400,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: state.cars.length,
                                          itemBuilder: (context, index) {
                                            return CarCard(
                                              car: state.cars[index],
                                              carDetails: 1,
                                            );
                                          }),
                                    ));
                              } else if (state is CarsError) {
                                return Center(
                                  child: Text('error: ${state.message}'),
                                );
                              }
                              return Container();
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          } else if (state is ProfileUnavailable) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'You have not logged in',
                    style: TextStyle(color: Color(0xFF1C1C1C), fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xFF1C1C1C),
                        onPrimary: Colors.white,
                        minimumSize: const Size(100, 50)),
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    child: const Text(
                      'Login/Register',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Text('Something went wrong');
          }
        },
      ),
      //   body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       //city name
      //       Text(_weather?.cityName ?? "loading..city"),

      //       Lottie.asset(getWeatherAnimation(_weather?.mainCondition ?? "")),
      //       //temperature
      //       Text('${_weather?.temperature.round()}°C'),
      //       Text(_weather?.mainCondition ?? "")
      //     ],
      //   ),
      // )
    );
  }
}
