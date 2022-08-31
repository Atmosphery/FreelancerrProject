// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, unused_local_variable, unnecessary_new, unnecessary_string_interpolations, avoid_print, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:flutter/material.dart';
import 'CustomAppBar.dart';
import 'package:http/http.dart' as http;

import 'User.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final nameCon = TextEditingController();
  final passCon = TextEditingController();
  final phoneCon = TextEditingController();
  final emailCon = TextEditingController();
  final aboutCon = TextEditingController();
  final addressCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Freelancerr!"),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: nameCon,
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
              controller: passCon,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
                hintText: 'Enter your secure password',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: phoneCon,
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'PhoneNumber',
                hintText: 'Enter your phone number',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: emailCon,
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
                hintText: 'Enter your Email',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: addressCon,
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Address',
                hintText: 'Enter your Address',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: aboutCon,
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'About',
                hintText: 'Tell us a little about yourself',
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              var url = Uri.parse('http://10.0.2.2:8888/userservice/users');
              http.Response resCount = await http.get(url);
              var userCountList = jsonDecode(resCount.body);

              print("count body: " + resCount.body);

              int idCount = userCountList.length;
              print("count: " + idCount.toString());

              var uriCreate =
                  Uri.parse('http://10.0.2.2:8888/userservice/createuser');

              String nameCheck = nameCon.text;
              var uriName = Uri.parse(
                  'http://10.0.2.2:8888/userservice/finduser/$nameCheck');
              http.Response resName = await http.get(uriName);

              User usrNameCheck = User.fromJson(jsonDecode(resName.body));

              if (usrNameCheck.name != nameCheck) {
                User newUser = new User(
                    id: idCount.toString(),
                    name: nameCon.text,
                    password: passCon.text,
                    phonenumber: phoneCon.text,
                    email: emailCon.text,
                    bio: aboutCon.text,
                    address: addressCon.text);

                var body = jsonEncode(newUser);

                http.Response responsePost = await http.post(uriCreate,
                    headers: {"Content-Type": "application/json"}, body: body);
                print("${responsePost.statusCode}");
                print("${responsePost.body}");
              }
              Navigator.pop(context);
            },
            child: Text("Sign up"),
          ),
        ],
      ),
    );
  }
}
