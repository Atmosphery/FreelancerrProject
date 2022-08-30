import 'package:flutter/material.dart';
import 'package:freelancerr_frontend/LoginScreen.dart';
import 'Job.dart';
import 'SellerPage.dart';

class InfoTile extends StatefulWidget {
  final String title;
  final Image image;
  final int jobId;
  final int userId;

  const InfoTile({
    Key? key,
    required this.title,
    required this.image,
    required this.jobId,
    required this.userId,
  }) : super(key: key);

  @override
  State<InfoTile> createState() => _InfoTileState();
}

class _InfoTileState extends State<InfoTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VendorPage(
                                  jobId: widget.jobId,
                                  userId: widget.userId.toString(),
                                )),
                      );
                    },
                    icon: Icon(Icons.person),
                    label: Text("Contact Seller")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
