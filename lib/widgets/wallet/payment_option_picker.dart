import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:kushmarkets/constants/app_text_styles.dart';
import 'package:kushmarkets/constants/strings/checkout.strings.dart';
import 'package:kushmarkets/data/models/payment_option.dart';
import 'package:kushmarkets/data/models/state_data_model.dart';
import 'package:kushmarkets/utils/ui_spacer.dart';
import 'package:kushmarkets/viewmodels/payment_option_picker.viewmodel.dart';
import 'package:kushmarkets/widgets/checkout/payment_option_list_view_item.dart';
import 'package:kushmarkets/widgets/list_view_header.dart';
import 'package:kushmarkets/widgets/shimmers/general_shimmer_list_view_item.dart';
import 'package:kushmarkets/widgets/state/state_loading_data.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class PaymentOptionPicker extends StatelessWidget {
  const PaymentOptionPicker({this.paymentOptionSelected, Key key})
      : super(key: key);

  //
  final Function(PaymentOption) paymentOptionSelected;

  //
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PaymentOptionPickerViewModel>.reactive(
      viewModelBuilder: () => PaymentOptionPickerViewModel(context),
      onModelReady: (vm) => vm.initialise(),
      builder: (context, vm, child) {
        return VStack(
          [
            //
            ListViewHeader(
              title: CheckoutStrings.paymentOptions,
              subTitle: CheckoutStrings.paymentOptionsInstruction,
              iconData: FlutterIcons.creditcard_ant,
            ).pOnly(bottom: Vx.dp24),

            //
            vm.isBusy
                ? GeneralShimmerListViewItem()
                : vm.hasErrorForKey(vm.paymentOptions)
                    //show error state
                    ? LoadingStateDataView(
                        stateDataModel: StateDataModel(
                          showActionButton: true,
                          actionButtonStyle: AppTextStyle.h4TitleTextStyle(
                            color: Colors.red,
                          ),
                          actionFunction: () => vm.getPaymentOptions(),
                        ),
                      )
                    : ListView.separated(
                        separatorBuilder: (context, index) =>
                            UiSpacer.verticalSpace(space: 20),
                        itemBuilder: (context, index) {
                          return PaymentOptionListViewItem(
                            paymentOption: vm.paymentOptions[index],
                            onPressed: (PaymentOption paymentOption) {
                              //
                              paymentOptionSelected(paymentOption);
                              context.pop();
                            },
                          );
                        },
                        itemCount: vm.paymentOptions.length,
                      ).expand(),
          ],
        ).hTwoThird(context).p20();
      },
    );
  }
}
