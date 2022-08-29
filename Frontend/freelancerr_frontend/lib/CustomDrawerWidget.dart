// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:freelancerr_frontend/AppManage.dart';

import 'User.dart';
import 'VendorAndServicesScreen.dart';

class CustomDrawerWidget extends StatefulWidget {
  final String header;

  final bool isSubPage;
  // An example of search icon press.
  final bool hasSearchFunction;
  final User user;
  List<User> venders;

  CustomDrawerWidget(
      {required this.header,
      this.isSubPage = false,
      this.hasSearchFunction = false,
      Key? key,
      required this.user,
      required this.venders})
      : super(key: key);

  @override
  State<CustomDrawerWidget> createState() => _CustomDrawerWidgetState();
}

class _CustomDrawerWidgetState extends State<CustomDrawerWidget> {
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return VendorAndServiceScreen(
                          user: widget.user, venders: widget.venders);
                    },
                  ),
                );
              },
            ),
          ),
          ListTile(
            title: Text("Category"),
          ),
          ListTile(
            title: Text("Become a vendor"),
          ),
          ListTile(
            title: TextButton(
              child: Text('List Users'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return VendorAndServiceScreen(
                        user: widget.user,
                        venders: widget.venders,
                      );
                    },
                  ),
                );
              },
            ),
          ),
          ListTile(
            title: TextButton(
              child: Text('Manage Appointments'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AppManage(
                        user: widget.user,
                        venders: widget.venders,
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
