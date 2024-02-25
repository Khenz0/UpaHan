import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FirebaseDB{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(String email, String password, BuildContext context) async{
    try{
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch(e){
      if(e.code == 'email-already-in-use'){
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text(
                  "Account already in use",
                  style: TextStyle(
                      fontSize: 10.0
                  ),
                )
            )
        );
      }

      if(e.code == 'weak-password'){
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text(
                  "Password provided is weak",
                  style: TextStyle(
                      fontSize: 10.0
                  ),
                )
            )
        );
      }
    }

    return null;
  }

  Future<User?> signInWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    }
    catch(e){
      print("Error");
    }
    return null;
  }

}