import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //for store the user data in firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> signUpUser({
    required String email,
    required String password,
    required String name,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty && password.isNotEmpty && name.isNotEmpty) {
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        // to store data in firestore
        await _firestore.collection("userData").doc(credential.user!.uid).set({
          'name': name,
          'uid': credential.user!.uid,
          'email': email,
        });
        res = 'success';
      } else {
        res = "Please fill all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  // for login user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = 'success';
      } else {
        res = "Please fill all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }
}
