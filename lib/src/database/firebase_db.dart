import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartrent_upahan/src/classes/emailNum_indicator.dart';
import 'package:smartrent_upahan/src/components/main_components/landlord_maintabview.dart';

import '../components/main_components/homepage_tenant.dart';
import '../widgets/signup_widget/signup_form_widget_googleSignIn.dart';

class FirebaseDB {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(String email, String password,
      BuildContext context) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
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
      else if (e.code == 'weak-password') {
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
      else if (e.code == 'network-request-failed') {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Network Error'),
              content: Text(
                  'Please check your internet connection and try again.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }

    return null;
  }

  Future<User?> signInWithEmailAndPassword(String email, String password,
      BuildContext context) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;

    } on FirebaseAuthException catch (e) {
      if (e.code == 'network-request-failed') {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Network Error'),
              content: Text(
                  'Please check your internet connection and try again.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
    catch (e) {
      print("Error");
    }
    return null;
  }

  Future<bool> _checkIfUserExists(String? email) async {
    final emailNumIndCollection = FirebaseFirestore.instance.collection('emailNumInd');
    final snapshot = await emailNumIndCollection.where('email', isEqualTo: email).get();

    return snapshot.docs.isNotEmpty; // True if any documents are found, false otherwise
  }

  void signInWithGoogle(BuildContext context) async {
    try {
      GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
      UserCredential credential = await _auth.signInWithProvider(
          googleAuthProvider);

      // Check if the user already exists in your database
      bool userExists = await _checkIfUserExists(credential.user!.email);
      print(credential.user!.email);
      print(userExists);

      if (userExists) {
        final email = credential.user!.email;

        // User exists, navigate to homepage
        if(await FirebaseDB.loginAccount(email!) == 0){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const TenantHomePage();
              },
            ),
          );
        } else if(await FirebaseDB.loginAccount(email) == 1){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const LandlordMainTabView();
              },
            ),
          );
        }

      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return SignUpFormGoogle(userEmail: credential.user!.email,);
            },
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
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
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Network Error'),
            content: Text(
                'Please check your internet connection and try again.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  static Future<int?> loginAccount(String emailInputted) async {
    final emailCollection = FirebaseFirestore.instance.collection('emailNumInd');
    final snapshot = await emailCollection.where('email', isEqualTo: emailInputted).get();

    // Check if any documents were found
    if (snapshot.docs.isEmpty) {
      // Handle the case where no email is found
      print('No email found in Firestore');
      return -1; // Or perform any other necessary action
    }

    final emailData = snapshot.docs.map((e) => EmailNumberIndicator.fromSnapshot(e)).single;

    if (emailData?.userIndicator == 0) {
      print('tenant page');
      return 0;
    } else {
      print('landlord page');
      return 1;
    }
  }
}