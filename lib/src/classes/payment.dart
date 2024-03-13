abstract class Payment{

  int? paymentId;
  String paymentName;
  int amount;

  Payment({this.paymentId, required this.paymentName, required this.amount});

}