import 'package:firebase_tutorial/models/user.dart';
import 'package:firebase_tutorial/service/database.dart';
import 'package:firebase_tutorial/shared/loading.dart';
import 'package:firebase_tutorial/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingPanel extends StatefulWidget {
  const SettingPanel({Key? key}) : super(key: key);

  @override
  State<SettingPanel> createState() => _SettingPanelState();
}

class _SettingPanelState extends State<SettingPanel> {
  static List<String> sugars = ['0', '1', '2', '3', '4'];
  final _formKey = GlobalKey<FormState>();
  // form value

  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    Users users = Provider.of<Users>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: users.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData userData = snapshot.data!;

          return Container(
            padding: const EdgeInsets.all(20),
            height: 340,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    'Update your brew settings.',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    onChanged: (value) => setState(() {
                      _currentName = value;
                    }),
                    decoration: myInputDecoration2('Enter Name'),
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter name' : null,
                    initialValue: _currentName ?? userData.name,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField(
                    items: sugars.map(
                      (sugar) {
                        return DropdownMenuItem(
                          value: sugar,
                          child: Text('$sugar sugars'),
                        );
                      },
                    ).toList(),
                    onChanged: (value) {
                      setState(
                        () {
                          _currentSugars = value.toString();
                        },
                      );
                    },
                    value: _currentSugars ?? userData.sugars,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Slider(
                    value: (_currentStrength ?? userData.strength).toDouble(),
                    onChanged: (value) {
                      setState(() {
                        _currentStrength = value.round();
                      });
                    },
                    divisions: 8,
                    activeColor:
                        Colors.pink[_currentStrength ?? userData.strength],
                    inactiveColor:
                        Colors.pink[_currentStrength ?? userData.strength],
                    max: 900,
                    min: 100,
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.logout),
                    onPressed: () async {
                      await DatabaseService(uid: users.uid).updateUserData(
                        _currentSugars ?? userData.sugars,
                        _currentName ?? userData.name,
                        _currentStrength ?? userData.strength,
                      );
                      if (!mounted) return;
                      Navigator.pop(context);
                    },
                    label: const Text('Update'),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.pink[400]),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Loading();
        }
      },
    );
  }
}
