// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:auth_weather_api/presentation/cubits/sign_up/sign_up_cubit.dart';
import 'package:auth_weather_api/presentation/pages/weather/weather_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/entypo_icons.dart';

import '../../../util/validators/validation.dart';
import '../../../util/validators/validator.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final signupformKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: signupformKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<SignUpCubit, SignUpState>(builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Sign up with",
                style: TextStyle(
                    fontSize: 16, color: Color(0xFFFFAB40), height: 2),
              ),
              Text("ZOMI WEALTH",
                  style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFAB40),
                      height: 1,
                      letterSpacing: 2)),
              SizedBox(
                height: 16,
              ),
              _UserInput(
                  onChanged: (email) {
                    print(email);
                    context
                        .read<SignUpCubit>()
                        .userChanged(state.user.copyWith(email: email));
                  },
                  labelText: "Enter Email/Username"),
              SizedBox(
                height: 16,
              ),
              _UserInput(
                  onChanged: (fullName) {
                    print(fullName);
                    context
                        .read<SignUpCubit>()
                        .userChanged(state.user.copyWith(name: fullName));
                  },
                  labelText: "Enter FullName"),
              SizedBox(
                height: 16,
              ),
              _UserInput(
                  onChanged: (country) {
                    context
                        .read<SignUpCubit>()
                        .userChanged(state.user.copyWith(country: country));
                    print(country);
                  },
                  labelText: "Enter Country"),
              SizedBox(
                height: 16,
              ),
              _UserInput(
                  onChanged: (city) {
                    context
                        .read<SignUpCubit>()
                        .userChanged(state.user.copyWith(city: city));
                    print(city);
                  },
                  labelText: "Enter City"),
              SizedBox(
                height: 16,
              ),
              _UserInput(
                  onChanged: (address) {
                    context
                        .read<SignUpCubit>()
                        .userChanged(state.user.copyWith(address: address));
                    print(address);
                  },
                  labelText: "Enter Address"),
              SizedBox(
                height: 16,
              ),
              _UserInput(
                  onChanged: (zipCode) {
                    context
                        .read<SignUpCubit>()
                        .userChanged(state.user.copyWith(zipCode: zipCode));
                    print(zipCode);
                  },
                  labelText: "Enter ZipCode"),
              SizedBox(
                height: 16,
              ),
              _PasswordInput(),
              SizedBox(
                height: 16,
              ),
              InkWell(
                onTap: () {
                  if (signupformKey.currentState?.validate() == true) {
                    context.read<SignUpCubit>().signUpWithCredentials();
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) => WeatherPage()));
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => WeatherPage()),
                        (route) => false);
                  }
                },
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: Color(0xFFD9BC43),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xFFD9BC43).withOpacity(0.2),
                            spreadRadius: 3,
                            blurRadius: 4,
                            offset: Offset(0, 3))
                      ]),
                  child: Center(
                      child: Text(
                    "SIGN UP",
                    style: TextStyle(
                        fontSize: 24,
                        color: Color(0xFF1C1C1C),
                        fontWeight: FontWeight.bold),
                  )),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Center(
                  child: Text(
                "Or Signup with",
                style: TextStyle(fontSize: 16, color: Color(0xFFD9BC43)),
              )),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Entypo.facebook_circled,
                      size: 32,
                      color: Color(
                        0xFFD9BC43,
                      )),
                  SizedBox(
                    width: 20,
                  ),
                  Icon(Entypo.gplus_circled,
                      size: 32,
                      color: Color(
                        0xFFD9BC43,
                      )),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}

class _UserInput extends StatelessWidget {
  const _UserInput(
      {super.key, required this.onChanged, required this.labelText});
  final Function(String)? onChanged;
  final String labelText;
  //final Validator? Validator;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return TextFormField(
            style: TextStyle(color: Colors.white),
            validator: Validator.apply(context, [RequiredValidation()]),
            decoration: InputDecoration(
                hintText: labelText,
                hintStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3F3C31),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(width: 0, style: BorderStyle.none),
                ),
                filled: true,
                fillColor: Colors.grey.withOpacity(0.1),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 0)),
            onChanged: onChanged);
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return TextFormField(
          obscureText: true,
          validator: Validator.apply(
              context, [RequiredValidation(), PasswordValidation()]),
          onChanged: (value) {
            context.read<SignUpCubit>().passwordChanged(value);
          },
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              hintText: "Password",
              helperStyle: TextStyle(color: Colors.white),
              hintStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3F3C31),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(width: 0, style: BorderStyle.none),
              ),
              filled: true,
              fillColor: Colors.grey.withOpacity(0.1),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 0)),
        );
      },
    );
  }
}
