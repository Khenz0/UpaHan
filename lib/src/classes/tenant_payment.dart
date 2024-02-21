import 'package:smartrent_upahan/src/classes/payment.dart';


class TenantPayment extends Payment{
  int isPayed; // 0 - not payed and 1 - payed

  TenantPayment({required id, required paymentName, required amount, required this.isPayed}) : super (id: id, paymentName: paymentName, amount: amount);
}