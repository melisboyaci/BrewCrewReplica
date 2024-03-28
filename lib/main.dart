import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application/services/auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyDDwPXVYLf1kZKnkT3ndaco0syTHBVoxoo',
      projectId: 'brew-crew-3e984',
      // Add other necessary configuration options
      appId: '1:424619918098:android:05a5068210ac277efba9cb',
      messagingSenderId: '',
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
      value: AuthService().userStream,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
