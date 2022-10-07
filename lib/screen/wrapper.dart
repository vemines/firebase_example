import 'package:firebase_tutorial/models/user.dart';
import 'package:firebase_tutorial/screen/authenticate/authenticate.dart';
import 'package:firebase_tutorial/screen/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<Users>(context);
    if (users.uid == '') {
      return const Authenticate();
    } else {
      return const Home();
    }
  }
}
