import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartrent_upahan/src/classes/property.dart';
import 'package:smartrent_upahan/src/classes/user.dart';

import 'emailNum_indicator.dart';

class Landlord extends PersonalUser{

  Property property;

  final landlordCollection = FirebaseFirestore.instance.collection('landlord');

  Landlord({id, required name, required contactInfo,required email, required password, required this.property}) : super(id: id, name: name, contactInfo: contactInfo, email: email, password: password);

  void createLandlordData(EmailNumberIndicator emailIndicator){
    id = landlordCollection.doc().id;
    emailIndicator = EmailNumberIndicator(id: id,email: email, userIndicator: 1);

    property.createPropertyData();

    final newLandlord = Landlord(
      id: id,
      name: name,
      contactInfo: contactInfo,
      email: email,
      password: password,
      property: property,
    ).toJson();

    emailIndicator.createEmailIndicator();
    landlordCollection.doc(id).set(newLandlord);
  }

  static Landlord? fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot){
    return Landlord(
      id: snapshot['id'],
      name: snapshot['name'],
      contactInfo: snapshot['contactInfo'],
      email: snapshot['email'],
      password: snapshot['password'],
      property: Property.fromSnapshot(snapshot['property']),
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "id": id,
      "name": name,
      "contactInfo": contactInfo,
      "email": email,
      "password": password,
      "property": property.toJson(),
    };
  }
}