// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, constant_identifier_names, unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freelancerr_frontend/AppModel.dart';
import 'package:http/http.dart' as http;

import 'CustomAppBar.dart';
import 'CustomDrawerWidget.dart';
import 'User.dart';

const String _AppTitle = "Freelancerr!";

class AppCreate extends StatefulWidget {
  AppCreate({Key? key, required this.user, required this.venders})
      : super(key: key);

  final User user;
  List<User> venders;

  @override
  State<AppCreate> createState() => _AppCreateState();
}

class _AppCreateState extends State<AppCreate> {
  final dateCon = TextEditingController();
  final vendCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: _AppTitle),
      drawer: CustomDrawerWidget(
          header: _AppTitle, user: widget.user, venders: widget.venders),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: vendCon,
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Vender',
                hintText: 'Enter venderId',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: dateCon,
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Date',
                hintText: 'Enter Date',
              ),
            ),
          ),
          Center(
            child: TextButton(
              onPressed: () async {
                Uri uriAppPost = Uri.parse("http://localhost:8888/appointment");
                AppModel newApp = AppModel(
                    customerId: int.parse(widget.user.id!),
                    vendorId: int.parse(vendCon.text),
                    status: 0,
                    jobId: 0,
                    appointmentDate: dateCon.text);
                var body = jsonEncode(newApp);

                http.Response responsePost = await http.post(uriAppPost,
                    headers: {"Content-Type": "application/json"}, body: body);
              },
              child: Text("Create Appointment"),
            ),
          ),
        ],
      ),
    );
  }
}
