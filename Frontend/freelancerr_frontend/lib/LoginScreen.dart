// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, unused_local_variable, use_build_context_synchronously

import 'package:flutter/material.dart';

import 'CustomAppBar.dart';
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
              var url = Uri.parse('http://localhost:8888/userservice/user/1');
              var response = await http.get(url);
              print('Response status: ${response.body}');
              var bodyparse = response.body.split(' ');
              print(bodyparse);
              var nameparse =
                  bodyparse.where((bodyparse) => bodyparse.contains('name'));
              print(nameparse);
              var userparse = nameparse.toString().split('=');
              print(userparse);
              var name =
                  userparse.where((userparse) => userparse.contains('nate'));

              print('name1 ' + name.toString());
              print('name2 ' + usernameController.value.text.toString());

              if (usernameController.value.text.toString() == name.toString()) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              }
            },
            child: Text("Log in"),
          ),
        ],
      ),
    );
  }
}
