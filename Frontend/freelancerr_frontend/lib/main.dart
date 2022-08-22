// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: must_be_immutable, prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import, constant_identifier_names, use_full_hex_values_for_flutter_colors, sized_box_for_whitespace

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:http/http.dart' as http;

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

class CustomList extends StatelessWidget {
  List<CustomListItem> items;

  CustomList({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(padding: const EdgeInsets.all(10.0), children: items);
  }
}

class CustomListItem extends StatelessWidget {
  final String thumbnail;
  final String title;

  const CustomListItem({
    Key? key,
    required this.thumbnail,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 5.0),
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              verticalDirection: VerticalDirection.down,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  flex: 1,
                  child: Image.network(
                    thumbnail,
                    height: 200,
                    width: 200,
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Text(title),
                ),
                Icon(
                  Icons.more_vert,
                  size: 16.0,
                ),
              ],
            ),
          ),
        ));
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: _AppTitle),
      body: Center(
        child: TextButton(
          child: Text('Back'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

class VendorAndServiceScreen extends StatelessWidget {
  const VendorAndServiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: _AppTitle),
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

class CustomDrawerWidget extends StatelessWidget {
  final String header;

  final bool isSubPage;
  // An example of search icon press.
  final bool hasSearchFunction;

  const CustomDrawerWidget(
      {required this.header,
      this.isSubPage = false,
      this.hasSearchFunction = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xFFffffffff),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF70566D),
            ),
            child: Text("Freelancerr Menu"),
          ),
          ListTile(
              title: TextButton(
                  child: Text('View Details'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return VendorAndServiceScreen();
                    }));
                  })),
          ListTile(
            title: Text("Category"),
          ),
          ListTile(
            title: Text("Become a vendor"),
          ),
        ],
      ),
    );
  }
}

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

class CustomSearchDelegate extends SearchDelegate {
  List<String> searchTerms = [
    "Apple",
    "Banana",
    "Mango",
    "Pear",
    "Watermelons",
    "Blueberries",
    "Pineapples",
    "Strawberries"
  ];
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear)),
    ];
    // ignore: todo
    // TODO: implement buildActions
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // ignore: todo
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matches = [];
    for (String item in searchTerms) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        matches.add(item);
      }
    }
    return ListView.builder(
      itemCount: matches.length,
      itemBuilder: (context, index) {
        var result = matches[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matches = [];

    for (var item in matches) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        matches.add(item);
      }
    }
    return ListView.builder(
      itemCount: matches.length,
      itemBuilder: (context, index) {
        var result = matches[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }
}
