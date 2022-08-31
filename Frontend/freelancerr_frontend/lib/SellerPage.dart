import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'CustomAppBar.dart';
import 'Job.dart';
import 'User.dart';
import 'InfoTile.dart';
import 'individualPage.dart';

class VendorPage extends StatefulWidget {
  final int jobId;
  final String userId;
  const VendorPage({Key? key, required this.userId, required this.jobId})
      : super(key: key);

  @override
  State<VendorPage> createState() => _VendorPageState();
}

class _VendorPageState extends State<VendorPage> {
  Future? _future;

  Future<List<dynamic>> getData() async {
    final job = await fetchJob();
    final user = await fetchSeller();
    return [job, user];
  }

  Future fetchJob() async {
    Uri uri = Uri.parse("http://10.0.2.2:8888/jobs/${widget.jobId}");
    final response = await http.get(uri);
    return Job.fromJson(jsonDecode(response.body));
  }

  Future fetchSeller() async {
    Uri uri =
        Uri.parse("http://10.0.2.2:8888/userservice/user/${widget.userId}");
    final response = await http.get(uri);
    return User.fromJson(jsonDecode(response.body));
  }

  @override
  void initState() {
    _future = getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Freelancerr!"),
      body: FutureBuilder(
        future: _future,
        builder: (ctx, snapshot) {
          // Checking if future is resolved or not
          if (snapshot.connectionState == ConnectionState.done) {
            // If we got an error
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error} occurred',
                  style: const TextStyle(fontSize: 18),
                ),
              );

              // if we got our data
            } else if (snapshot.hasData) {
              // Extracting data from snapshot object
              final data = snapshot.data as List<dynamic>;
              return Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  width: 3)),
                          child: Image.network(
                            data[0].imageLink,
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                              child: Text(data[0].title,
                                  overflow: TextOverflow.fade,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 40)),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                              child: Text(data[0].description,
                                  style: const TextStyle(fontSize: 20)),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 30, 8, 8),
                              child: OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Color(0xFF42273b),
                                  foregroundColor:
                                      Color.fromARGB(255, 238, 13, 182),
                                  elevation: 20, //<-- SEE HERE
                                  shadowColor: Color.fromARGB(
                                      255, 238, 13, 182), //<-- SEE HERE
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => IndividualPage(
                                        targetChat: data[1]!,
                                        user: ,
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.chat),
                                label: const Text("Open Chat"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          }

          // Displaying LoadingSpinner to indicate waiting state
          return const Center(
            child: CircularProgressIndicator(),
          );
        },

        // Future that needs to be resolved
        // inorder to display something on the Canvas
      ),
    );
  }

// child:
}
