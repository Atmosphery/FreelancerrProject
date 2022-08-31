import 'package:flutter/material.dart';
import 'package:freelancerr_frontend/LoginScreen.dart';
import 'Job.dart';
import 'DetailJobPage.dart';
import 'User.dart';

class InfoTile extends StatefulWidget {
  final String title;
  final Image image;
  final int jobId;
  final int userId;
  final User user;

  const InfoTile({
    Key? key,
    required this.title,
    required this.image,
    required this.jobId,
    required this.userId,
    required this.user,
  }) : super(key: key);

  @override
  State<InfoTile> createState() => _InfoTileState();
}

class _InfoTileState extends State<InfoTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
          border: Border.all(color: Color.fromARGB(255, 0, 0, 0), width: 3)),
      child: SizedBox(
        height: 300,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: widget.image,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 40),
                    child: Text(
                      overflow: TextOverflow.clip,
                      widget.title,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Color(0xFF42273b),
                        elevation: 20, //<-- SEE HERE
                        shadowColor:
                            Color.fromARGB(255, 238, 13, 182) //<-- SEE HERE
                        ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailJobPage(
                            jobId: widget.jobId,
                            userId: widget.userId.toString(),
                            user: widget.user,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.work),
                    label: const Text("View Job"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
