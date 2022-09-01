// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';

import 'CustomSearchDelegate.dart';
import 'Job.dart';
import 'LoginScreen.dart';
import 'main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CustomAppBar extends StatefulWidget with PreferredSizeWidget {
  // Preffered size required for PreferredSizeWidget extension
  final Size prefSize;
  // App bar title depending on the screen
  final String title;
  // A bool to check whether its a subpage or not.
  final bool isSubPage;
  // An example of search icon press.
  final bool hasSearchFunction;

  CustomAppBar({
    required this.title,
    this.isSubPage = false,
    this.hasSearchFunction = false,
    this.prefSize = const Size.fromHeight(56.0),
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(56.0);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  List<Job> jobs = [];

  Future refreshJobs() async {
    Uri uri = Uri.parse("http://10.0.2.2:8888/jobs/all");
    final response = await http.get(uri);
    var data = json.decode(response.body);
    //jobs = data;

    setState(() {
      for (var i = 0; i < data.length; i++) {
        jobs.add(
          Job(
            id: data[i]["id"],
            title: data[i]["title"],
            userId: data[i]["userId"],
            description: data[i]["description"],
            basePrice: data[i]["basePrice"],
            imageLink: data[i]["imageLink"],
          ),
        );
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    refreshJobs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Color(0xFF42273b),
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              // method to show the search bar
              showSearch(
                  context: context,
                  // delegate to customize the search bar
                  delegate: CustomSearchDelegate(jobs));
            },
            icon: Icon(Icons.search),
          ),
          TextButton(
              child: Text('Back',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255))),
              onPressed: () {
                Navigator.pop(context, LoginScreen());
                // Navigator.pop(context, MaterialPageRoute(builder: (context) {
                //   return LoginScreen();
                // }));
              })
        ]);
  }
}
