import 'dart:ui';

import 'package:auth_weather_api/data/models/car_model.dart';
import 'package:auth_weather_api/presentation/widgets/car_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CarDetailScreen extends StatefulWidget {
  final Car car;
  const CarDetailScreen({super.key, required this.car});

  @override
  State<CarDetailScreen> createState() => _CarDetailScreenState();
}

class _CarDetailScreenState extends State<CarDetailScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;

  @override
  void initState() {
    //animation controller
    //initialize the controller.. with duration
    _animationController =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);

    //initialize the animation with tween animation and insert the controller too
    _animation =
        Tween<double>(begin: 1.0, end: 1.5).animate(_animationController!)
          ..addListener(() {
            setState(() {});
          });
    //execute the animation
    _animationController!.forward();

    super.initState();
  }

  @override
  void dispose() {
    //dispose the animation
    _animationController!.forward();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      //extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.info_outline,
              color: Colors.white,
            ),
            Text(
              ' Information',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
        child: SizedBox(
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
                  decoration: const BoxDecoration(color: Colors.transparent),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    CarCard(
                        car: Car(
                            model: widget.car.model,
                            distance: widget.car.distance,
                            fuelCapacity: widget.car.fuelCapacity,
                            fuelPerHour: widget.car.fuelPerHour), carDetails: 0,),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: const Color(0xffF3F3F3),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 10,
                                        spreadRadius: 5)
                                  ]),
                              child: const Column(children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundImage:
                                      AssetImage('assets/user.png'),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Jane Cooper',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '\$4,253',
                                  style: TextStyle(color: Colors.grey),
                                )
                              ]),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container(
                              height: 170,
                              decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 10,
                                      spreadRadius: 5)
                                ],
                                /*image: DecorationImage(
                                  image: AssetImage('assets/maps.png'),
                                  fit: BoxFit.cover),*/
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                //transform.scale for animation value..
                                child: Transform.scale(
                                  scale: _animation!.value,
                                  alignment: Alignment.center,
                                  child: Image.asset(
                                    'assets/maps.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          // MoreCard(
                          //     car: Car(
                          //         model: widget.car.model! + "-1",
                          //         distance: widget.car.distance! + 100,
                          //         fuelCapacity: widget.car.fuelCapacity! + 100,
                          //         fuelPerHour: widget.car.fuelPerHour! + 100)),
                          // const SizedBox(
                          //   height: 5,
                          // ),
                          // MoreCard(
                          //     car: Car(
                          //         model: widget.car.model! + "-2",
                          //         distance: widget.car.distance! + 200,
                          //         fuelCapacity: widget.car.fuelCapacity! + 200,
                          //         fuelPerHour: widget.car.fuelPerHour! + 200)),
                          // const SizedBox(
                          //   height: 5,
                          // ),
                          // MoreCard(
                          //     car: Car(
                          //         model: widget.car.model! + "-3",
                          //         distance: widget.car.distance! + 300,
                          //         fuelCapacity: widget.car.fuelCapacity! + 300,
                          //         fuelPerHour: widget.car.fuelPerHour! + 200))
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
