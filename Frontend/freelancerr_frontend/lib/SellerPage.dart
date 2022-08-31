import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'CustomAppBar.dart';
import 'Job.dart';
import 'User.dart';
import 'InfoTile.dart';

class VendorPage extends StatefulWidget {
  final int jobId;
  final String userId;
  const VendorPage({Key? key, required this.userId, required this.jobId})
      : super(key: key);

  @override
  State<VendorPage> createState() => _VendorPageState();
}

class _VendorPageState extends State<VendorPage> {
  User user = User();
  Job job = Job();

  @override
  void initState() {
    fetchSeller();
    fetchJob();
    super.initState();
  }

  Future fetchJob() async {
    Uri uri = Uri.parse("http://localhost:8888/jobs/${widget.jobId}");
    final response = await http.get(uri);
    setState(() {
      job = Job.fromJson(jsonDecode(response.body));
    });
  }

  Future fetchSeller() async {
    Uri uri =
        Uri.parse("http://localhost:8888/userservice/user/${widget.userId}");
    final response = await http.get(uri);
    setState(() {
      user = User.fromJson(jsonDecode(response.body));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Freelancerr!"),
      body: Center(
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: Text("UserId = ${user.id}\n JobId = ${job.id}"),
            ),
          ],
        ),
      ),
    );
  }
}
