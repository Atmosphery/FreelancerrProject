// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:freelancerr_frontend/AppPage.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'AppModel.dart';
import 'User.dart';

class AppCard extends StatefulWidget {
  AppCard(
      {Key? key,
      required this.user,
      required this.appModel,
      required this.userDisplay})
      : super(key: key);
  final User user;
  final String userDisplay;
  final AppModel appModel;

  @override
  State<AppCard> createState() => _AppCardState();
}

class _AppCardState extends State<AppCard> {
  String? userName = "";

  @override
  void initState() {
    getUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("Id: " + widget.appModel.id.toString());
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AppPage(
                    app: widget.appModel,
                    user: widget.user,
                  )),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 30,
              ),
              title: Text(
                userName!,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Row(
                children: [
                  Icon(Icons.done_all),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    widget.appModel.appointmentDate!.toString(),
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 80),
              child: Divider(
                thickness: 1,
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> getUserName() async {
    var url = Uri.parse(
        'http://10.0.2.2:8888/userservice/user/${widget.userDisplay}');
    http.Response response = await http.get(url);

    print('name string: ' + User.fromJson(jsonDecode(response.body)).name!);
    setState(() {
      userName = User.fromJson(jsonDecode(response.body)).name!;
    });
  }
}
