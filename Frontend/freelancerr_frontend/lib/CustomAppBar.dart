// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';

import 'CustomSearchDelegate.dart';
import 'LoginScreen.dart';
import 'main.dart';

class CustomAppBar extends StatefulWidget with PreferredSizeWidget {
  // Preffered size required for PreferredSizeWidget extension
  final Size prefSize;
  // App bar title depending on the screen
  final String title;
  // A bool to check whether its a subpage or not.
  final bool isSubPage;
  // An example of search icon press.
  final bool hasSearchFunction;

  CustomAppBar(
      {required this.title,
      this.isSubPage = false,
      this.hasSearchFunction = false,
      this.prefSize = const Size.fromHeight(56.0),
      Key? key})
      : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(56.0);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
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
                  delegate: CustomSearchDelegate());
            },
            icon: Icon(Icons.search),
          ),
          TextButton(
              child: Text('Login',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255))),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LoginScreen();
                }));
              })
        ]);
  }
}
