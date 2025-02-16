import 'package:auth_weather_api/data/models/car_model.dart';
import 'package:auth_weather_api/presentation/pages/car/car_detail_page.dart';
import 'package:flutter/material.dart';

class CarCard extends StatelessWidget {
  final Car car;
  final int carDetails;
  const CarCard({super.key, required this.car, required this.carDetails});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CarDetailScreen(
                      car: car,
                    )));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (car.model == 'Land Rover')
              Image.asset(
                "assets/land_rover_0.png",
                height: 200,
                width: 270,
              )
            else
              Image.asset(
                "assets/${car.model}.png",
                height: 200,
                width: 300,
              ),
            Center(
              child: Text(
                car.model!,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            if(carDetails == 0) Row(
              //crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        Image.asset('assets/gps.png'),
                        Text(
                          '${car.distance!.toStringAsFixed(0)}km',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Image.asset('assets/pump.png'),
                        Text(' ${car.fuelCapacity!.toStringAsFixed(0)}L',
                            style: TextStyle(color: Colors.white))
                      ],
                    ),
                    Text('  \$${car.fuelPerHour!.toStringAsFixed(0)}/h',
                        style: TextStyle(color: Colors.white)),
                  ],
                ),
              ],
            )else Container()
          ],
        ),
      ),
    );
  }
}
