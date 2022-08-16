// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

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
    return const MaterialApp(
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
      drawer: const CustomDrawerWidget(header: _AppTitle),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          children: <Widget>[
            Expanded(flex: 2, child: <CustomListItem>[]),
            const Expanded(
              flex: 1,
              child: Center(child: Text("Ur mum")),
            )
          ],
        ),
      ),
    );
  }
}

class CustomListItem extends StatelessWidget {
  final Widget thumbnail;
  final String title;
  final String user;
  final int viewCount;

  const CustomListItem({
    Key? key,
    required this.thumbnail,
    required this.title,
    required this.user,
    required this.viewCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: thumbnail,
          ),
          Expanded(
            flex: 3,
            child: Text("Mother lol"),
          ),
          const Icon(
            Icons.more_vert,
            size: 16.0,
          ),
        ],
      ),
    );
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
          child: const Text('Login Page'),
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
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 147, 108, 255),
            ),
            child: Text("Freelancerr Menu"),
          ),
          ListTile(
              title: TextButton(
                  child: Text('View Details'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const VendorAndServiceScreen();
                    }));
                  })),
          const ListTile(
            title: Text("Category"),
          ),
          const ListTile(
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
  Size get preferredSize => const Size.fromHeight(56.0);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: const Color.fromARGB(255, 107, 13, 170),
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
            icon: const Icon(Icons.search),
          ),
          TextButton(
              child: const Text('Login',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255))),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const LoginScreen();
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
          icon: const Icon(Icons.clear)),
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
        icon: const Icon(Icons.arrow_back));
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
