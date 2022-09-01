// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'Job.dart';

class CustomSearchDelegate extends SearchDelegate {
  List<Job> jobSearchTerms;

  CustomSearchDelegate(this.jobSearchTerms);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear)),
    ];
    // ignore: todo
    // TODO: implement buildActions
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // ignore: todo
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Job> matches = [];
    for (Job item in jobSearchTerms) {
      if (item.title!.toLowerCase().contains(query.toLowerCase())) {
        matches.add(item);
      }
    }
    return ListView.builder(
      itemCount: matches.length,
      itemBuilder: (context, index) {
        var result = matches[index];
        return ListTile(
          title: Text(result.title!),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Job> matches = [];

    for (var item in matches) {
      if (item.title!.toLowerCase().contains(query.toLowerCase())) {
        matches.add(item);
      }
    }
    return ListView.builder(
      itemCount: matches.length,
      itemBuilder: (context, index) {
        var result = matches[index];
        return ListTile(
          title: Text(result.title!),
        );
      },
    );
  }
}
