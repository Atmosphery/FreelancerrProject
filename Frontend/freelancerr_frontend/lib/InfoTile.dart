import 'package:flutter/material.dart';

class InfoTile extends StatelessWidget {
  final String title;
  final Image image;

  const InfoTile({
    Key? key,
    required this.title,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                //flex: 2,
                child: image,
              ),
              Flexible(
                //flex: 1,
                child: Row(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(0, 216, 10, 10)),
                    ),
                    TextButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.person),
                        label: Text("Contact Seller")),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
