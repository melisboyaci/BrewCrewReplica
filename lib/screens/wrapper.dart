import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/screens/authenticate/authenticate.dart';
import 'package:flutter_application/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    // ignore: avoid_print
    print(user?.uid.toString());

    // return either Home or Authenticate
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
