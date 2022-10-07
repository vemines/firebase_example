import 'package:firebase_tutorial/models/brews.dart';
import 'package:flutter/material.dart';

class BrewTile extends StatelessWidget {
  final Brews brew;
  const BrewTile({Key? key, required this.brew}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
              radius: 25, backgroundColor: Colors.pink[brew.strength]),
          title: Text(brew.name),
          subtitle: Text('Take ${brew.sugars} sugar(s)'),
        ),
      ),
    );
  }
}
