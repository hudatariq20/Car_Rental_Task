import 'dart:async';

import 'package:auth_weather_api/data/models/weather_model.dart';
import 'package:auth_weather_api/data/repository/weather_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  //WeatherRepository _weatherRepository; //send the key also..
  WeatherBloc() : super(WeatherLoading()) {
    on<FetchWeather>(_FetchWeather);
  }

  void _FetchWeather(FetchWeather event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    try {
      final _weatherRepository =
          WeatherRepository('06f10f8e70d0bebd652c3d8e46805467');
      String cityName =
          await _weatherRepository.getCurrentCity(); //get current city
      final weather = await _weatherRepository
          .getWeather(cityName); //get weather based on city name
      emit(WeatherSuccess(weather));
    } catch (e) {
      emit(WeatherFailure());
    }
  }
}
