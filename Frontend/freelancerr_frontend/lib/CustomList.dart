// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:freelancerr_frontend/InfoTile.dart';

import 'CustomListItem.dart';
import 'main.dart';

class CustomList extends StatelessWidget {
  List<InfoTile> items;

  CustomList({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(padding: const EdgeInsets.all(10.0), children: items);
  }
}
