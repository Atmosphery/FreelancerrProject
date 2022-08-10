// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

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
      appBar: AppBar(title: const Text("Freelancerr!"), actions: [
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
        IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const LoginScreen();
            }));
          },
          icon: const Icon(Icons.login),
        ),
      ]),
      drawer: Drawer(
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
                        return VendorAndServiceScreen();
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
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}

class VendorAndServiceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(),
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

class CustomAppbar extends StatefulWidget {
  const CustomAppbar({Key? key}) : super(key: key);

  @override
  State<CustomAppbar> createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(title: const Text("Freelancerr!"), actions: [
        IconButton(
          onPressed: () {
            // method to show the search bar
            showSearch(
                context: context,
                // delegate to customize the search bar
                delegate: CustomSearchDelegate());
          },
          icon: const Icon(Icons.search),
        )
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
