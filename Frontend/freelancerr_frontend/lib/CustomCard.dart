// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'User.dart';
import 'individualPage.dart';

class CustomCard extends StatelessWidget {
  CustomCard({Key? key, this.targetChat, this.user}) : super(key: key);
  final User? targetChat;
  final User? user;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => IndividualPage(
                      targetChat: targetChat!,
                      user: user,
                    )));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 30,
              ),
              title: Text(targetChat!.name!,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )),
              subtitle: Row(
                children: [
                  Icon(Icons.done_all),
                  SizedBox(
                    width: 3,
                  ),
                  Text("Musician",
                      style: TextStyle(
                        fontSize: 13,
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 80),
              child: Divider(
                thickness: 1,
              ),
            )
          ],
        ),
      ),
    );
  }
}
