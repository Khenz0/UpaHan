import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:smartrent_upahan/src/classes/property.dart';
import 'package:smartrent_upahan/src/classes/tenant_payment.dart';
import '../database/firebase_db.dart';

abstract class PersonalUser{
  String? id;

  String name;
  String contactInfo;
  String email;
  String password;

  // tenant
  /*String? boardingHouse;
  int? status;
  DateTime? startDate;
  DateTime? currentDate;
  List<TenantPayment>? tenantPayment;*/

  // landlord
  //Property? property;

  final FirebaseDB firebaseDB = FirebaseDB();
  //final userCollection = FirebaseFirestore.instance.collection('users');

  PersonalUser({this.id, required this.name, required this.contactInfo, required this.email, required this.password});

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

  /*PersonalUser.tenant({
    this.id,
    this.userIndicator = 0,
    required this.name,
    required this.contactInfo,
    required this.email,
    required this.password,
    required this.boardingHouse,
    required this.status,
    required this.startDate,
    required this.currentDate,
    this.tenantPayment
  }) : role = UserRole.tenant;*/

  /*PersonalUser.landlord({
    this.id,
    this.userIndicator = 1,
    required this.name,
    required this.contactInfo,
    required this.email,
    required this.password,
    required this.property
  }) : role = UserRole.landlord;*/

  /*void createTenantData(){
    id = userCollection.doc().id;

    final newTenant = PersonalUser.tenant(
        id: id,
        userIndicator: userIndicator,
        name: name,
        contactInfo: contactInfo,
        email: email,
        password: password,
        boardingHouse: boardingHouse,
        status: status,
        startDate: startDate,
        currentDate: currentDate,
        tenantPayment: tenantPayment
    ).tenantToJson();

    userCollection.doc(id).set(newTenant);
  }*/

  /*void createLandlordData(){
    property?.createPropertyData();

    id = userCollection.doc().id;

    final newLandlord = PersonalUser.landlord(
      id: id,
      userIndicator: userIndicator,
      name: name,
      contactInfo: contactInfo,
      email: email,
      password: password,
      property: property,
    ).landlordToJson();

    userCollection.doc(id).set(newLandlord);
  }

  Map<String, dynamic> tenantToJson() {
    return {
      "id": id,
      "userIndicator": userIndicator,
      "name": name,
      "contactInfo": contactInfo,
      "email": email,
      "password": password,
      "role": "tenant",
      "boardingHouse": boardingHouse,
      "status": status,
      "startDate": startDate?.toIso8601String(),
      "currentDate": currentDate?.toIso8601String(),
      "tenantPayment": tenantPayment?.map((payment) => payment.toJson()).toList(),
    };
  }

  Map<String, dynamic> landlordToJson() {
    return {
      "id": id,
      "userIndicator": userIndicator,
      "name": name,
      "contactInfo": contactInfo,
      "email": email,
      "password": password,
      "role": "landlord",
      "property": property?.toJson(),
    };
  }

  static PersonalUser? tenantFromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    if (snapshot.data() != null && snapshot.data()!.containsKey('boardingHouse')) {
      return PersonalUser.tenant(
        id: snapshot['id'],
        name: snapshot['name'],
        contactInfo: snapshot['contactInfo'],
        email: snapshot['email'],
        password: snapshot['password'],
        boardingHouse: snapshot['boardingHouse'],
        status: snapshot['status'],
        startDate: snapshot['startDate'] != null ? DateTime.parse(snapshot['startDate']) : null,
        currentDate: snapshot['currentDate'] != null ? DateTime.parse(snapshot['currentDate']) : null,
        tenantPayment: (snapshot['tenantPayment'] as List<dynamic>?)
            ?.map((paymentJson) => TenantPayment.fromSnapshot(paymentJson))
            .toList(),
      );
    } else {
      // Handle case where boardingHouse field is missing
      return null; // or you can return a default tenant object
    }
  }

  static PersonalUser? landlordFromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    if (snapshot.data() != null && snapshot.data()!.containsKey('property')) {
      return PersonalUser.landlord(
        id: snapshot['id'],
        name: snapshot['name'],
        contactInfo: snapshot['contactInfo'],
        email: snapshot['email'],
        password: snapshot['password'],
        property: Property.fromSnapshot(snapshot['property']),
      );
    } else {
      return PersonalUser.landlord(
        id: snapshot['id'],
        name: snapshot['name'],
        contactInfo: snapshot['contactInfo'],
        email: snapshot['email'],
        password: snapshot['password'],
        property: null, // or you can assign a default value here
      );
    }
  }*/
}