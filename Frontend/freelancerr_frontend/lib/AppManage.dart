// ignore_for_file: prefer_const_constructors_in_immutables, must_be_immutable, constant_identifier_names, prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, unnecessary_new, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:flutter/material.dart';

import 'AppCard.dart';
import 'AppCreate.dart';
import 'AppModel.dart';
import 'CustomAppBar.dart';
import 'CustomDrawerWidget.dart';
import 'CustomList.dart';
import 'User.dart';
import 'package:http/http.dart' as http;

const String _AppTitle = "Freelancerr!";

class AppManage extends StatefulWidget {
  AppManage({Key? key, required this.user, required this.venders})
      : super(key: key);
  final User user;
  List<User> venders;
  //List<AppModel> apps;

  @override
  State<AppManage> createState() => _AppManageState();
}

class _AppManageState extends State<AppManage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: _AppTitle),
      drawer: CustomDrawerWidget(
          header: _AppTitle, user: widget.user, venders: widget.venders),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: TextButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AppCreate(
                        user: widget.user,
                        venders: widget.venders,
                      );
                    },
                  ),
                );
              },
              child: Text("Add Appointment"),
            ),
          ),
          Expanded(
            flex: 10,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: FutureBuilder<List<AppModel>>(
                future: getAppsUser(widget.user.id!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  var data = snapshot.data!;
                  print(data);

                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      print('${snapshot.data![index]}');
                      return AppCard(
                        user: widget.user,
                        appModel: snapshot.data![index],
                        userDisplay:
                            snapshot.data![index].customerId.toString(),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<List<AppModel>> getAppsUser(String id) async {
  var url = Uri.parse('http://localhost:8888/appointment/all/$id/vendor');
  http.Response response = await http.get(url);

  var appJson = jsonDecode(response.body);
  List<AppModel> appUsersList = [];
  for (int i = 0; i < appJson.length; i++) {
    AppModel appToAdd = AppModel.fromJson(appJson[i]);
    appUsersList.add(appToAdd);
  }

  for (int i = 0; i < appUsersList.length; i++) {
    print("App User List: " + appUsersList[i].appointmentDate.toString());
  }

  return appUsersList;
}
