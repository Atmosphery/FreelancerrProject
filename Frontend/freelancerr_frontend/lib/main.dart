// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: must_be_immutable, prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import, constant_identifier_names, use_full_hex_values_for_flutter_colors, sized_box_for_whitespace

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:freelancerr_frontend/InfoTile.dart';
import 'package:go_router/go_router.dart';

import 'package:http/http.dart' as http;

import 'CustomAppBar.dart';
import 'CustomDrawerWidget.dart';
import 'CustomList.dart';
import 'Job.dart';
import 'LoginScreen.dart';
import 'User.dart';
import 'VendorAndServicesScreen.dart';

const String _AppTitle = "Freelancerr!";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Potato',
      home: LoginScreen(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.user, required this.venders})
      : super(key: key);

  final User user;
  List<User> venders;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: _AppTitle),
      drawer: CustomDrawerWidget(
          header: _AppTitle, user: widget.user, venders: widget.venders),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.fromLTRB(60, 5, 60, 5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.greenAccent, width: 5),
            ),
            child: Text(
              'Top Jobs',
              style: TextStyle(
                color: Colors.green,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        CustomList(),
      ]),
    );
  }
}
