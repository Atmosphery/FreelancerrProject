// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';

class CustomListItem extends StatelessWidget {
  final String thumbnail;
  final String title;

  // crossAxisAlignment: CrossAxisAlignment.center,
  //             verticalDirection: VerticalDirection.down,
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             mainAxisSize: MainAxisSize.max,

  const CustomListItem({
    Key? key,
    required this.thumbnail,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 5,
      height: 200,
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.center,
        //verticalDirection: VerticalDirection.down,
        //mainAxisAlignment: MainAxisAlignment.center,
        //mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            child: Image.network(
              thumbnail,
              width: 300,
              height: 300,
            ),
          ),
          Container(
            height: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Yessir"),
                Icon(Icons.access_alarm),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
