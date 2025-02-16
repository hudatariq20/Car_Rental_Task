// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:auth_weather_api/data/repository/auth/auth_repository.dart';
import 'package:auth_weather_api/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/profile/profile_bloc.dart';

// class ProfilePage extends StatelessWidget {
//   const ProfilePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocProvider(
//         create: ((context) => ProfileBloc(
//             authBloc: context.read<AuthBloc>(),
//             userRepository: context.read()<UserRepository>())
//           ..add(LoadProfile(context.read<AuthBloc>().state.authUser!))),
//         child: ProfileScreen(),
//       ),
//     );
//   }
// }

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3D657),
      // appBar: CustomAppBar(),
      // bottomNavigationBar: CustomNavBar(),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProfileLoaded) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Your profile has been logged in',
                    style: TextStyle(color: Color(0xFF1C1C1C), fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xFF1C1C1C),
                        onPrimary: Colors.white,
                        minimumSize: const Size(100, 50)),
                    onPressed: () {
                      context.read<AuthRepository>().signOut();
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    child: Text(
                      'Sign Out',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is ProfileUnavailable) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'You have not logged in',
                    style: TextStyle(color: Color(0xFF1C1C1C), fontSize: 20),
                  ),
                  SizedBox(
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
                    child: Text(
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
    );
  }
}
