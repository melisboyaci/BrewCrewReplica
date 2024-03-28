import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application/models/brew.dart';
import 'package:flutter_application/screens/home/brew_tile.dart';

class BrewList extends StatefulWidget {
  const BrewList({Key? key}) : super(key: key);

  @override
  State<BrewList> createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>?>(context);

    return brews != null
        ? ListView.builder(
            itemCount: brews.length,
            itemBuilder: (context, index) {
              return BrewTile(brew: brews[index]);
            },
          )
        : CircularProgressIndicator(); // or any other loading indicator
  }
}
