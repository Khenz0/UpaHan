import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartrent_upahan/src/classes/emailNum_indicator.dart';
import 'package:smartrent_upahan/src/classes/tenant_payment.dart';
import 'package:smartrent_upahan/src/classes/user.dart';

class Tenant extends PersonalUser{

  String boardingHouse;
  int status;
  DateTime startDate;
  DateTime currentDate;
  List<TenantPayment>? tenantPayment;

  final tenantCollection = FirebaseFirestore.instance.collection('tenant');

  Tenant({id, required name, required contactInfo,required email, required password, required this.boardingHouse, required this.status, required this.startDate, required this.currentDate, this.tenantPayment}) : super (id: id, name: name, contactInfo: contactInfo, email: email, password: password);

  void updateStatusAndDate() {
    if (status == 1) {
      currentDate = getNextMonth(currentDate);
      status = 1;
    }
  }

  DateTime getNextMonth(DateTime date) {
    final nextMonth = date.month < 12 ? date.month + 1 : 1;
    final nextYear = date.month < 12 ? date.year : date.year + 1;
    return DateTime(nextYear, nextMonth, date.day, date.hour, date.minute, date.second, date.millisecond,
        date.microsecond);
  }

  bool isPaymentDueThreeDays() {
    final daysRemaining = currentDate.difference(DateTime.now()).inDays;
    return daysRemaining <= 3 && daysRemaining >= 1;
  }

  bool isPaymentDue() {
    final daysRemaining = currentDate.difference(DateTime.now()).inDays;
    return daysRemaining <= 0;
  }

  /*void changeStatusWhenPaidAndNotPaid(){
    if(isPaymentDue() && (status == 1 || status == 2)){
      for (var payment in tenantPayment) {
        payment.isPayed = 0;
      }
      status = 3;
    }
  }*/

  void createTenantData(EmailNumberIndicator emailIndicator){
    id = tenantCollection.doc().id;
    emailIndicator = EmailNumberIndicator(id: id,email: email, userIndicator: 0);

    final newTenant = Tenant(
        id: id,
        name: name,
        contactInfo: contactInfo,
        email: email,
        password: password,
        boardingHouse: boardingHouse,
        status: status,
        startDate: startDate,
        currentDate: currentDate
    ).toJson();

    emailIndicator.createEmailIndicator();
    tenantCollection.doc(id).set(newTenant);
  }

  Stream<List<Tenant?>> readTenantData(){
    return tenantCollection.snapshots().map((querySnapshot) => querySnapshot.docs.map((e) => Tenant.fromSnapshot(e),
    ).toList());
  }

  static Tenant? fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot){
    return Tenant(
        id: snapshot['id'],
        name: snapshot['name'],
        contactInfo: snapshot['contactInfo'],
        email: snapshot['email'],
        password: snapshot['password'],
        boardingHouse: snapshot['boardingHouse'],
        status: snapshot['status'],
        startDate: snapshot['startDate'],
        currentDate: snapshot['currentDate']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "id": id,
      "name": name,
      "contactInfo": contactInfo,
      "email": email,
      "password": password,
      "boardingHouse": boardingHouse,
      "status": status,
      "startDate": startDate,
      "currentDate": currentDate
    };
  }

}