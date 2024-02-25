import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../database/firebase_db.dart';

class PersonalUser{
  int? id;
  String name;
  String contactInfo;
  String email;
  String password;

  final FirebaseDB firebaseDB = FirebaseDB();

  PersonalUser({this.id, required this.name, required this.contactInfo, required this.email, required this.password});

  Future<bool> login() async{
    User? user = await firebaseDB.signInWithEmailAndPassword(email, password);

    if(user != null){
      print("Log in.");
      return true;
    }
    else{
      return false;
    }
  }

  Future<bool> signUp(BuildContext context) async{
    User? user = await firebaseDB.signUpWithEmailAndPassword(email, password, context);

    if(user != null){
      print("Account Created.");
      return true;
    }
    else{
      print("Some error occured");
      return false;
    }
  }

}