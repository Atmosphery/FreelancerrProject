// ignore_for_file: prefer_const_constructors_in_immutables, must_be_immutable, constant_identifier_names, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

import 'AppCreate.dart';
import 'CustomAppBar.dart';
import 'CustomDrawerWidget.dart';
import 'CustomList.dart';
import 'User.dart';

const String _AppTitle = "Freelancerr!";

class AppManage extends StatefulWidget {
  AppManage({Key? key, required this.user, required this.venders})
      : super(key: key);
  final User user;
  List<User> venders;
  @override
  State<AppManage> createState() => _AppManageState();
}

class _AppManageState extends State<AppManage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: _AppTitle),
      drawer: CustomDrawerWidget(
          header: _AppTitle, user: widget.user, venders: widget.venders),
      body: Column(children: [
        Center(
          child: TextButton(
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return AppCreate(
                      user: widget.user,
                      venders: widget.venders,
                    );
                  },
                ),
              );
            },
            child: Text("Add Appointment"),
          ),
        ),
      ]),
    );
  }
}
