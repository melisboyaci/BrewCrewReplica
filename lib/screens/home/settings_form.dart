import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/models/user.dart';
import 'package:flutter_application/services/database.dart';

import 'package:flutter_application/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String _currentName = '';
  String _currentSugars = '';
  int _currentStrength = 100;
  final List<int> strengths = [100, 200, 300, 400, 500, 600, 700, 800, 900];

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user!.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data!;
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Update your brew settings',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: textInputDecoration,
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter a name' : null,
                    onChanged: (value) => setState(() => _currentName = value),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  DropdownButtonFormField(
                      decoration: textInputDecoration,
                      value: _currentSugars == '' ? sugars[0] : sugars[0],
                      items: sugars.map((sugar) {
                        return DropdownMenuItem(
                            value: sugar, child: Text('$sugar sugars'));
                      }).toList(),
                      onChanged: (val) =>
                          setState(() => _currentSugars = val!)),
                  Slider(
                      min: 100,
                      max: 900,
                      divisions: 8,
                      activeColor: Colors.brown,
                      value: (_currentStrength == 100 ? 100 : _currentStrength)
                          .toDouble(),
                      onChanged: (val) =>
                          setState(() => _currentStrength = val.round())),
                  SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.pink[400]!),
                      ),
                      onPressed: () async {
                        print(_currentName);
                        print(_currentSugars);
                        print(_currentStrength);
                        if (_formKey.currentState!.validate()) {
                          await DatabaseService(uid: user.uid).updateUserData(
                              _currentSugars ?? userData.sugars,
                              _currentName ?? userData.name,
                              _currentStrength ?? userData.strength);
                          if (mounted) Navigator.pop(context);
                        }
                      },
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
