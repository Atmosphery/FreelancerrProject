import 'package:flutter/material.dart';

class InfoTile extends StatefulWidget {
  const InfoTile({Key? key}) : super(key: key);

  @override
  State<InfoTile> createState() => _InfoTileState();
}

class _InfoTileState extends State<InfoTile> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                  child: Image.network(
                      "https://s3-ap-northeast-1.amazonaws.com/psh-ex-ftnikkei-3937bb4/images/9/7/9/9/27799979-4-eng-GB/Cropped-1592590681photo.JPG")),
              Flexible(
                child: Row(
                  children: [
                    Text("Ur Mom"),
                    TextButton.icon(onPressed: () {}, icon: Icon(Icons.person), label: Text("Contact Seller")),
                    
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
