import 'package:auth_weather_api/data/models/car_model.dart';
import 'package:auth_weather_api/data/repository/car_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'car_event.dart';
part 'car_state.dart';

class CarBloc extends Bloc<CarsEvent, CarState> {
  CarRepositoryImpl _carRepositoryImpl;
  CarBloc({required CarRepositoryImpl carRepositoryImpl})
      : _carRepositoryImpl = carRepositoryImpl,
        super(CarsLoading()) {
    on<LoadCars>(_LoadCar);
  }

  void _LoadCar(LoadCars event, Emitter<CarState> emit) async {
    try {
      final cars = await _carRepositoryImpl.fetchCars();
      emit(CarsLoaded(cars));
    } catch (e) {
      emit(CarsError(e.toString()));
    }
  }
}
