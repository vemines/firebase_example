import 'package:firebase_tutorial/models/brews.dart';
import 'package:firebase_tutorial/models/user.dart';
import 'package:firebase_tutorial/screen/home/brews_list.dart';
import 'package:firebase_tutorial/screen/home/setting_panel.dart';
import 'package:firebase_tutorial/service/auth.dart';
import 'package:firebase_tutorial/service/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  void _showSetingPanel(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return const SettingPanel();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Users users = Provider.of<Users>(context);

    return StreamProvider<List<Brews>?>.value(
      value: DatabaseService(uid: users.uid).brews,
      initialData: null,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          actions: [
            ElevatedButton.icon(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                _auth.signOut();
              },
              label: const Text('Log out'),
              style: const ButtonStyle(),
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.settings),
              onPressed: () {
                _showSetingPanel(context);
              },
              label: const Text('Setting'),
              style: const ButtonStyle(),
            ),
          ],
        ),
        body: const ColectionList(),
      ),
    );
  }
}
