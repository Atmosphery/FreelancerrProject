// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'CustomAppBar.dart';
import 'main.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Freelancerr!"),
      body: Center(
        child: TextButton(
          child: Text('Back'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
