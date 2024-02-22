import 'package:smartrent_upahan/src/classes/tenant_payment.dart';
import 'package:smartrent_upahan/src/classes/user.dart';

class Tenant extends PersonalUser{

  int status;
  DateTime startDate;
  DateTime currentDate;
  List<TenantPayment>? tenantPayment;

  Tenant({id, required name, required contactInfo,required email, required password, required this.status, required this.startDate, required this.currentDate, this.tenantPayment}) : super (id: id, name: name, contactInfo: contactInfo, email: email, password: password);


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

  // void changeStatusWhenPaidAndNotPaid(){
  //   if(isPaymentDue() && (status == 1 || status == 2)){
  //     for (var payment in tenantPayment) {
  //       payment.isPayed = 0;
  //     }
  //     status = 3;
  //   }
  // }


}