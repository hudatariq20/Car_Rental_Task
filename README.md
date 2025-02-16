# 🛵 Authorized Car Rental and Weather App - Flutter, Firebase(SaaS backend), Firebase Firestore, Bloc State Management, Clean Architecture,GeoLocation

### Project Overview

This project demonstrates how to integrate **Firebase** **authentication** and **authorization** with BLoC pattern, along with calling the **OpenWeather** **API** to fetch weather details and explore detailed car information. It displays current weather condition (Sunny, Cloudy, Rainy, Thunderstorm) based on **Geolocation** **API** that fetch exact GPS location of the device. 
 **Firebase's** **Firestore** security rules protect **User** data from unauthorized access and maintains car information that is to be displayed on the car information page.
The app uses **BLoC** for handling state and business logic separately from the UI, ensuring maintainable and scalable code. The **Clean Architecture** pattern is followed to separate concerns between data, domain, and presentation layers.

### 📱 Features
* **User Authentication/Authorization** using Firebase (sign-in, sign-up, and sign-out) and Firebase Firestore.
* **Weather Information** fetched using OpenWeather API, based on the user's current location via Geolocation and Geocoding APIs.
* **Car Rental System** with a list of available cars fetched from Firebase, showing the car's specs (fuel per hour, distance, etc.).
*  **BLoC Pattern** used for state management to make the app scalable and easy to maintain.
*  **Vehicle Listing Page**: Display a list of available cars fetched from Firebase.
*  **Vehicle Information Page**: Show detailed information about a selected car.
*  **Validator class** coordinating checks and **Validation** subclasses defining rules, 



## 🎨 App Screens
edit the screenshots here of the 3 screens.
Home page, 

## 🛠️ Tech Stack
**Flutter**: Cross-platform mobile app development framework.
**Firebase and Firebase FIrestore**: Real-time database to store and manage car details.
**BLoC**: Business Logic Component (BLoC) pattern for state management.
**flutter_bloc**: Package for implementing the BLoC pattern in Flutter.
**equatable**: For value comparison in BLoC events and states.
**http package** is used to send network requests to the OpenWeather API and other external services to fetch and display weather and car data.



### Getting Started

## Installation

**1. Clone the Repository:**  

```sh
  git clone https://github.com/hudatariq20/CarRentalMVP.git
  cd flutter-car-rental-app
```

**2. Install Dependencies:**

```sh
flutter pub get
```

**3. Firebase Setup:**
* Create a Firebase project at **Firebase Console**.
* Enable Firebase Realtime Database or Firestore.
* Add Firebase SDK configuration files (google-services.json for Android, GoogleService-Info.plist for iOS) to your project.
* Add Firebase dependencies in pubspec.yaml (e.g., firebase_core, cloud_firestore).

**4. Run the app:**

```sh
flutter run
```


## Usage
* Launch the app: Run the app on your emulator or device using flutter run.
* Navigate:
 -On the home screen, view the car list fetched from Firebase.
-Tap on a car to view its details.
-Open the map page to view car locations and select pick-up and delivery locations on the map.

## Contributions
Contributions are welcome! Please fork the repository and create a pull request with your enhancements or fixes.

## Contact
For any inquiries or issues, please contact huda.tariq94@gmail.com



