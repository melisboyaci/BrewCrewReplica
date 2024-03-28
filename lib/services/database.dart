import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application/models/brew.dart';
import 'package:flutter_application/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String sugar, String name, int strength) async {
    return await brewCollection
        .doc(uid)
        .set({'sugar': sugar, 'name': name, 'strength': strength});
  }

  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((data) {
      //print(doc.data);
      return Brew(
        name: data['name'] ?? '',
        strength: data['strength'] ?? 0,
        sugar: data['sugar'] ?? '0',
      );
    }).toList();
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.get('name'),
        sugars: snapshot.get('sugar'),
        strength: snapshot.get('strength'));
  }

  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots().map((snapshot) {
      return _userDataFromSnapshot(snapshot);
    });
  }
}
