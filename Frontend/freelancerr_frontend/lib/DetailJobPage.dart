import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freelancerr_frontend/VendorPage.dart';
import 'package:http/http.dart' as http;

import 'CustomAppBar.dart';
import 'Job.dart';
import 'User.dart';
import 'InfoTile.dart';
import 'individualPage.dart';

class DetailJobPage extends StatefulWidget {
  final int jobId;
  final String userId;
  const DetailJobPage({Key? key, required this.userId, required this.jobId})
      : super(key: key);

  @override
  State<DetailJobPage> createState() => _DetailJobPageState();
}

class _DetailJobPageState extends State<DetailJobPage> {
  Future? _future;

  Future<List<dynamic>> getData() async {
    final job = await fetchJob();
    final vendor = await fetchSeller();
    return [job, vendor];
  }

  Future fetchJob() async {
    Uri uri = Uri.parse("http://localhost:8888/jobs/${widget.jobId}");
    final response = await http.get(uri);
    return Job.fromJson(jsonDecode(response.body));
  }

  Future fetchSeller() async {
    Uri uri =
        Uri.parse("http://localhost:8888/userservice/user/${widget.userId}");
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 30, 8, 8),
                                  child: OutlinedButton.icon(
                                    style: OutlinedButton.styleFrom(
                                      backgroundColor: Color(0xFF42273b),
                                      elevation: 20,
                                      shadowColor:
                                          Color.fromARGB(255, 238, 13, 182),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => IndividualPage(
                                            user: data[1],
                                          ),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.chat),
                                    label: const Text("Open Chat"),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 30, 8, 8),
                                  child: OutlinedButton.icon(
                                    style: OutlinedButton.styleFrom(
                                        backgroundColor: Color(0xFF42273b),
                                        elevation: 20, //<-- SEE HERE
                                        shadowColor: Color.fromARGB(
                                            255, 238, 13, 182) //<-- SEE HERE
                                        ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => VendorPage(
                                            user: data[1],
                                          ),
                                        ),
                                      );
                                    },
                                    icon: const Icon(
                                        Icons.person_search_outlined),
                                    label: const Text("View Vendor"),
                                  ),
                                ),
                              ],
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
