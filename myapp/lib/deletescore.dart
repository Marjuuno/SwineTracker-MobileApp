// firestore_utils.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> removeScoreFromAllUsers() async {
  await Firebase.initializeApp(); // Initialize Firebase

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  QuerySnapshot querySnapshot = await _firestore.collection('userData').get();

  for (var doc in querySnapshot.docs) {
    await doc.reference.update({'score': FieldValue.delete()});
    print('Removed score from document: ${doc.id}');
  }

  print('Score field removed from all user documents.');
}

void main() async {
  await removeScoreFromAllUsers();
}