import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartrent_upahan/src/classes/payment.dart';


class TenantPayment extends Payment{
  int isPayed; // 0 - not payed and 1 - payed

  TenantPayment({paymentId, required paymentName, required amount, required this.isPayed}) : super (paymentId: paymentId, paymentName: paymentName, amount: amount);

  static TenantPayment fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot){
    return TenantPayment(
      paymentId: snapshot['paymentId'],
      paymentName: snapshot['paymentName'],
      amount: snapshot['amount'],
      isPayed: snapshot['isPayed'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "paymentId": paymentId,
      "paymentName": paymentName,
      "amount": amount,
      "isPayed": isPayed,
    };
  }
}