import 'package:flutter/src/widgets/framework.dart';
import 'package:kushmarkets/data/models/payment_option.dart';
import 'package:kushmarkets/data/repositories/checkout.repository.dart';
import 'package:kushmarkets/viewmodels/base.viewmodel.dart';

class PaymentOptionPickerViewModel extends MyBaseViewModel {
  //
  PaymentOptionPickerViewModel(BuildContext context) {
    this.viewContext = context;
  }

  //
  List<PaymentOption> paymentOptions = [];
  CheckOutRepository checkOutRepository = CheckOutRepository();

  //
  initialise() {
    getPaymentOptions();
  }

  //getting the payment options
  void getPaymentOptions() async {
    //
    setBusy(true);
    try {
      paymentOptions = await checkOutRepository.paymentOptions();
      paymentOptions.removeWhere((paymentOption) => paymentOption.isCash );
      clearErrors();
    } catch (error) {
      setErrorForObject(paymentOptions, error);
    }
    setBusy(false);
  }
}
