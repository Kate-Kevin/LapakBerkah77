// ignore_for_file: avoid_print


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Authservice {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? get currentUser => _auth.currentUser;

  // create user obj based on firebaseuser
  /* User _userFromFirebaseUser(User user){
    return UserModel?(uid: user.uid);
  } */

  // auth change user stream
  Stream<User?> get authStateChanges{
    return _auth.authStateChanges();
    //.map((FirebaseUser user) => _userFromFirebaseUser(user));
  }

  

  // sign in email & pass
  Future signInrWithEmailandPassword(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  /* createUserData(String username){
    FirebaseFirestore.instance.collection('Users').doc(currentUser?.email).set({
      'username' : username,
      'phone' : '',
      'address': ''
    });
  } */

  // register email & pass
  Future registerWithEmailandPassword(String email, String password, String username) async {
    try {
      UserCredential userCredential= await _auth.createUserWithEmailAndPassword(email: email, password: password,);
      FirebaseFirestore.instance.collection('Users').doc(userCredential.user!.email).set({
      'username' : username,
      'phone' : '',
      'address': ''
    });
      return userCredential;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future resetPassword(String email)async{
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  // sign out

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

}