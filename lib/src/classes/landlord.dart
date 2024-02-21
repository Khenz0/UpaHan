import 'package:smartrent_upahan/src/classes/property.dart';
import 'package:smartrent_upahan/src/classes/user.dart';

class Landlord extends PersonalUser{

  Property property;

  Landlord({required id, required name, required contactInfo,required email, required password, required this.property}) : super(id: id, name: name, contactInfo: contactInfo, email: email, password: password);

}