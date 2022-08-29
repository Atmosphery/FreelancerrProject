// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, unused_local_variable, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';

import 'CustomAppBar.dart';
import 'SignUpPage.dart';
import 'User.dart';
import 'main.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Freelancerr!"),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: usernameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'User Name',
                hintText: 'Enter username',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
                hintText: 'Enter your secure password',
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              String nameCheck = usernameController.text;
              var url = Uri.parse(
                  'http://localhost:8888/userservice/username/$nameCheck');
              http.Response response = await http.get(url);

              print(response.body.toString());
              User user = User.fromJson(jsonDecode(response.body));

              var url2 = Uri.parse('http://localhost:8888/userservice/users');
              http.Response response2 = await http.get(url2);

              var venderJson = jsonDecode(response2.body);
              List<User> venders = [];
              for (int i = 0; i < venderJson.length; i++) {
                User userToAdd = User.fromJson(venderJson[i]);
                if (userToAdd.id != user.id) {
                  venders.add(userToAdd);
                }
                print("User to add: " + userToAdd.name.toString());
              }

              if (user.password == passwordController.text.toString()) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          HomePage(user: user, venders: venders)),
                );
              }
            },
            child: Text("Log in"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUpPage()),
              );
            },
            child: Text("Sign up"),
          ),
        ],
      ),
    );
  }
}
