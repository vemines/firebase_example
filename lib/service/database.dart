import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_tutorial/models/brews.dart';
import 'package:firebase_tutorial/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  // collection column in firestore
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  // update collection in firestore with uid and 3 value
  Future updateUserData(String sugars, String name, int strength) async {
    return brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  // list brews froms snapshot
  List<Brews> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Brews(
          name: doc['name'] ?? '',
          strength: doc['strength'] ?? 0,
          sugars: doc['sugars'] ?? '0');
    }).toList();
  }

  // get brews stream
  Stream<List<Brews>>? get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  // user data brews froms snapshot
  UserData _userDataFromSnapshot(QuerySnapshot snapshot) {
    List<UserData?> listData = snapshot.docs
        .map((doc) {
          if (doc.id == uid) {
            return UserData(
                uid: uid,
                name: doc['name'] ?? '',
                strength: doc['strength'] ?? 0,
                sugars: doc['sugars'] ?? '0');
          }
        })
        .toList()
        // filter null in list and return single
        .whereType<UserData>()
        .toList();
    return listData.single!;
  }

  // get brews stream
  Stream<UserData>? get userData {
    return brewCollection.snapshots().map(_userDataFromSnapshot);
  }
}
