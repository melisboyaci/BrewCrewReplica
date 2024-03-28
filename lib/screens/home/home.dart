// ignore: unused_import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/screens/home/settings_form.dart';
import 'package:flutter_application/services/auth.dart';
import 'package:flutter_application/services/database.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application/screens/home/brew_list.dart';
import 'package:flutter_application/models/brew.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet<void>(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Brew>?>.value(
      value: DatabaseService(uid: '').brews,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Brew Crew'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
                icon: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                onPressed: () async {
                  await _auth.signOut();
                },
                label: Text(
                  'Log out',
                  style: TextStyle(color: Colors.black),
                )),
            TextButton.icon(
                onPressed: _showSettingsPanel,
                icon: Icon(
                  Icons.settings,
                  color: Colors.black,
                ),
                label: Text(
                  'Settings',
                  style: TextStyle(color: Colors.black),
                ))
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/coffee_bg.png'),
                    fit: BoxFit.cover)),
            child: BrewList()),
      ),
    );
  }
}
