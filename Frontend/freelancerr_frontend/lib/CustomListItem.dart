// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';

class CustomListItem extends StatelessWidget {
  final String thumbnail;
  final String title;

  const CustomListItem({
    Key? key,
    required this.thumbnail,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 5.0),
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              verticalDirection: VerticalDirection.down,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  flex: 1,
                  child: Image.network(
                    thumbnail,
                    height: 200,
                    width: 200,
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Text(title),
                ),
                Icon(
                  Icons.more_vert,
                  size: 16.0,
                ),
              ],
            ),
          ),
        ));
  }
}
