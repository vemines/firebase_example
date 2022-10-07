import 'package:firebase_tutorial/shared/loading.dart';
import 'package:firebase_tutorial/shared/shared.dart';
import 'package:firebase_tutorial/service/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // auth service
  final AuthService _auth = AuthService();
  // form value
  String email = '';
  String password = '';
  String signInError = '';
  String signUpError = '';
  // loading screen
  bool loading = false;
  int delayToAction = 500;

  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            backgroundColor: Colors.blue.shade100,
            appBar: AppBar(
              backgroundColor: Colors.blue.shade400,
              elevation: 0.0,
              title: const Text('Sign In to App'),
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        dynamic signInResult = await _auth.signInAnonymous();
                        if (signInResult == null) {
                          debugPrint('Sign in Error');
                        } else {
                          debugPrint(
                              'Sign in as Guest Success (uid:${signInResult.uid})');
                        }
                      },
                      child: const Text('Sign in as Guest'),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 20,
                      ),
                      height: 8,
                      width: double.infinity,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: Form(
                        key: _signUpFormKey,
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              onChanged: (value) => setState(() {
                                email = value;
                              }),
                              decoration: myInputDecoration(
                                  Icons.email, 'Enter User Email'),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              obscureText: true,
                              validator: (value) {
                                if (value!.length < 6) {
                                  return 'Password at least 6 character';
                                }
                                return null;
                              },
                              decoration: myInputDecoration(
                                  Icons.lock, 'Enter Password'),
                              onChanged: (value) => setState(() {
                                password = value;
                              }),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                _auth
                                    .signUpWithEmailAndPassword(email, password)
                                    .then((value) {
                                  Future.delayed(
                                      Duration(milliseconds: delayToAction),
                                      () {
                                    if (value.uid == '' && mounted) {
                                      setState(() {
                                        loading = false;
                                        signUpError =
                                            'Invalid email or password';
                                      });
                                    }
                                  });
                                });
                              },
                              child: const Text(
                                  'Register with email and password'),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              signUpError,
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 14.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 8,
                      width: double.infinity,
                      color: Colors.white,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 50, right: 50, top: 20),
                      child: Form(
                        key: _signInFormKey,
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              onChanged: (value) => setState(() {
                                email = value;
                              }),
                              decoration: myInputDecoration(
                                  Icons.email, 'Enter User Email'),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              obscureText: true,
                              validator: (value) {
                                if (value!.length < 6) {
                                  return 'Password at least 6 character';
                                }
                                return null;
                              },
                              decoration: myInputDecoration(
                                  Icons.lock, 'Enter Password'),
                              onChanged: (value) => setState(() {
                                password = value;
                              }),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (_signInFormKey.currentState!.validate()) {
                                  setState(() {
                                    loading = true;
                                  });
                                  _auth
                                      .signInWithEmailAndPassword(
                                          email, password)
                                      .then((value) {
                                    Future.delayed(
                                        Duration(milliseconds: delayToAction),
                                        () {
                                      if (value.uid == '' && mounted) {
                                        setState(() {
                                          loading = false;
                                          signInError =
                                              'Invalid email or password';
                                        });
                                      }
                                    });
                                  });
                                }
                              },
                              child:
                                  const Text('Sign in with email and password'),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              signInError,
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 14.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
