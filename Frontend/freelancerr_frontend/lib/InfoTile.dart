import 'package:flutter/material.dart';

class InfoTile extends StatelessWidget {
  final String? title;
  final Image image;

  const InfoTile({
    Key? key,
    required this.title,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                  child: image,
                  ),
              Flexible(
                child: Row(
                  children:  [
                    Text("Ur Mom"),
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

