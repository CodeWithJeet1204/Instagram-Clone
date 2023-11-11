import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:insta/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign up
  Future<String> signUpUser({
    required String username,
    required String email,
    required String password,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty ||
          username.isNotEmpty ||
          password.isNotEmpty ||
          bio.isNotEmpty) {
        // Register
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);

        // Add user to DB (Bio & File & Username)
        // With uid
        await _firestore.collection('users').doc(cred.user!.uid).set({
          'uid': cred.user!.uid,
          'username': username,
          'email': email,
          'bio': bio,
          'followers': [],
          'following': [],
          'photoUrl': photoUrl,
        });

        // Without uid
        // await _firestore.collection('users').add({
        //   'uid': cred.user!.uid,
        //   'username': username,
        //   'email': email,
        //   'bio': bio,
        //   'followers': [],
        //   'following': [],
        // });

        res = 'success';
        print(cred.user!.email);
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = "Email is Badly Formatted";
      } else if (err.code == 'weak-password') {
        res = "Choose a Strong Password";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Logging in User
  Future<String> logInUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "Please fill in all the fields";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
