// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, unused_local_variable, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';

import 'CustomAppBar.dart';
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
              var url = Uri.parse('http://localhost:8888/userservice/users');
              var response = await http.get(url);
              List userList = jsonDecode(response.body);
              var user = userList.where(
                  (user) => user['name'] == usernameController.text.toString());

              for (int i = 0; i < userList.length; i++) {
                print(userList[i]);
              }

              print(user);
              User userModel = User.fromJson(user as Map<String, dynamic>);
              print("usermodel " + userModel.toString());
              // if (userModel.password == passwordController.text.toString()) {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => HomePage()),
              //   );
              // }
            },
            child: Text("Log in"),
          ),
        ],
      ),
    );
  }
}
