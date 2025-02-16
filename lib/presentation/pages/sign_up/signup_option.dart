// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class SignUpOption extends StatefulWidget {
  const SignUpOption({super.key});

  @override
  State<SignUpOption> createState() => _SignUpOptionState();
}

class _SignUpOptionState extends State<SignUpOption> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Text(
            "OR",
            style: TextStyle(
                fontSize: 24,
                color: Color(0xFFECCB45),
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Container(
          height: 40,
          decoration: BoxDecoration(
              color: Color(0xFFECCB45),
              borderRadius: BorderRadius.all(Radius.circular(16)),
              boxShadow: [
                BoxShadow(
                    color: Color(0xFFECCB45).withOpacity(0.2),
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
      ],
    );
  }
}
