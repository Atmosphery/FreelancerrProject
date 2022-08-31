// ignore_for_file: prefer_const_constructors, must_be_immutable, sized_box_for_whitespace

import 'dart:convert';

import 'package:flutter/material.dart';

import 'CustomAppBar.dart';
import 'CustomCard.dart';
import 'User.dart';
import 'main.dart';
import 'package:http/http.dart' as http;

class VendorAndServiceScreen extends StatefulWidget {
  VendorAndServiceScreen({Key? key, required this.user, required this.venders})
      : super(key: key);
  final User user;
  List<User> venders;

  @override
  State<VendorAndServiceScreen> createState() => _VendorAndServiceScreenState();
}

// void getUsers() async {
//   var url = Uri.parse('http://10.0.2.2:8888/userservice/users');
//   var response = await http.get(url);
//   widget.venders = jsonDecode(response.body);
// }

class _VendorAndServiceScreenState extends State<VendorAndServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Vendors"),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemCount: widget.venders.length,
              itemBuilder: (context, index) => CustomCard(
                targetChat: widget.venders[index],
                user: widget.user,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
