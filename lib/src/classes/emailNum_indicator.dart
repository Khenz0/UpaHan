import 'package:cloud_firestore/cloud_firestore.dart';

class EmailNumberIndicator{
  String? id;
  int? phoneNum;
  String email;
  int userIndicator;

  final emailCollection = FirebaseFirestore.instance.collection('emailNumInd');

  EmailNumberIndicator({this.id, this.phoneNum, required this.email, required this.userIndicator});

  void createEmailIndicator(){
    final newEmail = EmailNumberIndicator(
        id: id,
        email: email,
        userIndicator: userIndicator
    ).toJson();

    emailCollection .doc(id).set(newEmail);
  }

  static EmailNumberIndicator? fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot){
    return EmailNumberIndicator(
        id: snapshot['id'],
        email: snapshot['email'],
        userIndicator: snapshot['userIndicator'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "id": id,
      "email": email,
      "userIndicator": userIndicator,
    };
  }
}