// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'CustomAppBar.dart';
import 'main.dart';

class VendorAndServiceScreen extends StatelessWidget {
  const VendorAndServiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Vendors"),
      body: Center(
        child: TextButton(
          child: Text('Pop!'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
