import 'package:flutter/material.dart';
import 'package:freelancerr_frontend/LoginScreen.dart';

class InfoTile extends StatefulWidget {
  final String title;
  final Image image;

  const InfoTile({
    Key? key,
    required this.title,
    required this.image,
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
        height: 100,
        width: 100,
        child: Column(
          children: [
            Expanded(
              flex: 1,
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
                        MaterialPageRoute(builder: (context) => LoginScreen()),
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
