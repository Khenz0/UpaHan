import 'package:cloud_firestore/cloud_firestore.dart';

class Property{
  String? propertyId;
  String propertyName;
  String address;

  Property({this.propertyId, required this.propertyName, required this.address});

  void createPropertyData(){
    final propertyCollection = FirebaseFirestore.instance.collection('property');

    propertyId = propertyCollection.doc().id;

    final newProperty = Property(
      propertyId: propertyId,
      propertyName: propertyName,
      address: address,
    ).toJson();

    propertyCollection.doc(propertyId).set(newProperty);
  }

  static Property fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot){
    return Property(
      propertyId: snapshot['propertyId'],
      propertyName: snapshot['propertyName'],
      address: snapshot['address'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "propertyId": propertyId,
      "propertyName": propertyName,
      "address": address,
    };
  }
}