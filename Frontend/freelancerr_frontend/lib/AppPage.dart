// ignore_for_file: prefer_const_constructors_in_immutables, prefer_interpolation_to_compose_strings, must_be_immutable, prefer_const_constructors, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'AppModel.dart';
import 'CustomAppBar.dart';
import 'CustomDrawerWidget.dart';
import 'User.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String _AppTitle = "Freelancerr!";

class AppPage extends StatefulWidget {
  AppPage({Key? key, this.app, required this.user}) : super(key: key);
  final User user;
  AppModel? app;

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  User? vender;
  User? customer;
  DateFormat formatter = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    getCustomer(widget.app!.customerId.toString());
    getVender(widget.app!.vendorId.toString());
    super.initState();
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: _AppTitle),
      drawer:
          CustomDrawerWidget(header: _AppTitle, user: widget.user, venders: []),
      body: Column(
        children: [
          Center(
            child: Text(
              (vender) != null ? "Vendor: " + vender!.name! : "Vendor: ",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Center(
            child: Text(
              (customer) != null
                  ? "Customer: " + customer!.name!
                  : "Customer: ",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Center(
            child: Text(
              (customer) != null
                  ? "Date: " + widget.app!.appointmentDate!.split("T")[0]
                  : "Date: ",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Center(
            child: Text(
              (customer) != null
                  ? "Status: " + widget.app!.status.toString()
                  : "Status: ",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Center(
            child: TextButton(
                onPressed: () async {
                  widget.app!.updateStatus(1);
                  var uriUpdate =
                      Uri.parse('http://10.0.2.2:8888/appointment/');

                  var body = jsonEncode(widget.app!.toJson());

                  http.Response responsePut = await http.put(uriUpdate,
                      headers: {"Content-Type": "application/json"},
                      body: body);
                  print("${responsePut.statusCode}");
                  print("${responsePut.body}");
                  setState(() {
                    getCustomer(widget.app!.customerId.toString());
                    getVender(widget.app!.vendorId.toString());
                  });
                },
                child: Text("Accept")),
          ),
          Center(
            child: TextButton(onPressed: () {}, child: Text("Deny")),
          ),
          Center(
            child: TextButton(onPressed: () {}, child: Text("Mark Complete")),
          ),
        ],
      ),
    );
  }

  Future<void> getCustomer(String id) async {
    var url = Uri.parse('http://10.0.2.2:8888/userservice/user/${id}');
    http.Response response = await http.get(url);

    print('Customer Name: ' + User.fromJson(jsonDecode(response.body)).name!);
    setState(() {
      customer = User.fromJson(jsonDecode(response.body));
    });
  }

  Future<void> getVender(String id) async {
    var url = Uri.parse('http://10.0.2.2:8888/userservice/user/${id}');
    http.Response response = await http.get(url);

    print('Vender Name: ' + User.fromJson(jsonDecode(response.body)).name!);
    setState(() {
      vender = User.fromJson(jsonDecode(response.body));
    });
  }
}
