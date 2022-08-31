import 'package:flutter/material.dart';
import 'package:freelancerr_frontend/User.dart';

import 'CustomAppBar.dart';

class VendorPage extends StatefulWidget {
  final User user;

  const VendorPage({Key? key, required this.user}) : super(key: key);

  @override
  State<VendorPage> createState() => _VendorPageState();
}

class _VendorPageState extends State<VendorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Freelancerr!'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.user.name!),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.user.bio!),
          ),
        ],
      ),
    );
  }
}
