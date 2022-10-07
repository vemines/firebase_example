import 'package:firebase_tutorial/models/brews.dart';
import 'package:firebase_tutorial/screen/home/brews_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ColectionList extends StatelessWidget {
  const ColectionList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final brewsList = Provider.of<List<Brews>?>(context);

    if (brewsList != null) {
      return ListView.builder(
        itemCount: brewsList.length,
        itemBuilder: (context, index) {
          return BrewTile(brew: brewsList[index]);
        },
      );
    }
    return Container();
  }
}
