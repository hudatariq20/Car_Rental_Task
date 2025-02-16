import 'package:auth_weather_api/data/models/car_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class CarRepositoryImpl {
  final FirebaseFirestore _firebaseFirestore;

  CarRepositoryImpl({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;


  @override
  Future<List<Car>> fetchCars() async {
    var snapshot = await _firebaseFirestore.collection('cars').get();
    return snapshot.docs.map((doc) => Car.fromJson(doc.data())).toList();
  }
}
