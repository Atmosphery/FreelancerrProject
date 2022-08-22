// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'VendorAndServicesScreen.dart';

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
