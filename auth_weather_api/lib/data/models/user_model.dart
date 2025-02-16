import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? id;
  final String name;
  final String email;
  final String country;
  final String city;
  final String address;
  final String zipCode;

  const User(
      {this.id,
      this.name = '',
      this.email = '',
      this.country = '',
      this.city = '',
      this.address = '',
      this.zipCode = ''});

  User copyWith(
      {String? id,
      String? name,
      String? email,
      String? country,
      String? city,
      String? address,
      String? zipCode}) {
    return User(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        country: country ?? this.country,
        city: city ?? this.city,
        address: address ?? this.address,
        zipCode: zipCode ?? this.zipCode);
  }

  // //constructor to read the object from cloud firestore
  factory User.fromSnapshot(DocumentSnapshot snap) {
    return User(
        id: snap.id,
        email: snap['email'],
        name: snap['name'],
        address: snap['address'],
        city: snap['city'],
        country: snap['country'],
        zipCode: snap['zipCode']);
  }

  //constructor to save object to firebase
  Map<String, Object> toDocument() {
    return {
      'name': name,
      'email': email,
      'address': address,
      'city': city,
      'country': country,
      'zipCode': zipCode
    };
  }

  @override
  List<Object?> get props => [id, name, email, address, city, country, zipCode];
}
