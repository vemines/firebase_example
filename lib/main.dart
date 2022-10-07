import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_tutorial/screen/wrapper.dart';
import 'package:firebase_tutorial/service/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Users>.value(
      initialData: Users(uid: ''),
      value: AuthService().users,
      catchError: (context, error) => Users(uid: ''),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
