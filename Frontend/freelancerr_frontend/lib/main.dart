// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: must_be_immutable, prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import, constant_identifier_names, use_full_hex_values_for_flutter_colors, sized_box_for_whitespace

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:http/http.dart' as http;

import 'CustomAppBar.dart';
import 'CustomDrawerWidget.dart';
import 'CustomList.dart';
import 'CustomListItem.dart';
import 'LoginScreen.dart';
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
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: _AppTitle),
      drawer: CustomDrawerWidget(header: _AppTitle),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.0),
        child: CustomList(items: [
          CustomListItem(
            thumbnail:
                "https://eadn-wc03-3448642.nxedge.io/cdn/media/catalog/product/cache/ac15be4d11510284e17cdd74847b75a6/e/o/eotech_eotech_thermochromic_mug_red_a.png",
            title: "Mug",
          ),
          CustomListItem(
            thumbnail:
                "https://play-lh.googleusercontent.com/9UDY3O4wSwlBm-kHHfjKf85Yk5GCt0nckL5ZdMR-nYotAfNjODvR4sZ-scPXG3ABVF65",
            title: "Ur mom",
          ),
        ]),
      ),
    );
  }
}
