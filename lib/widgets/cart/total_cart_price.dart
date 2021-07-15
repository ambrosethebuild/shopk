import 'package:flutter/material.dart';
import 'package:kushmarkets/constants/app_color.dart';
import 'package:kushmarkets/constants/app_text_styles.dart';
import 'package:kushmarkets/constants/strings/cart.strings.dart';
import 'package:kushmarkets/utils/price.utils.dart';
import 'package:kushmarkets/utils/ui_spacer.dart';
import 'package:kushmarkets/viewmodels/cart_page.vewmodel.dart';
import 'package:kushmarkets/widgets/cart/amount_tile.dart';

class TotalCartPrice extends StatelessWidget {
  TotalCartPrice({
    Key key,
    this.viewModel,
  }) : super(key: key);

  final CartPageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        
        children: <Widget>[
          //showing the sub total amount
          AmountTile(
            label: CartStrings.subTotal,
            labelTextStyle: AppTextStyle.h5TitleTextStyle(
              color: AppColor.textColor(context),
            ),
            amount:
                "${viewModel.currency.symbol} ${PriceUtils.intoDecimalPlaces(viewModel.subTotalAmount)}",
            amountTextStyle: AppTextStyle.h3TitleTextStyle(
              color: AppColor.textColor(context),
            ),
          ),
          //Start of discount
          this.hasDiscount()
              ? AmountTile(
                  label: CartStrings.discountedAmount,
                  labelTextStyle: AppTextStyle.h5TitleTextStyle(
                    color: AppColor.textColor(context),
                  ),
                  amount:
                      "- ${viewModel.currency.symbol} ${PriceUtils.intoDecimalPlaces(viewModel.discountAmount)}",
                  amountTextStyle: AppTextStyle.h3TitleTextStyle(
                    color: AppColor.textColor(context),
                  ),
                )
              : UiSpacer.empty(),
          this.hasDiscount()
              ? UiSpacer.divider(thickness: 1)
              : UiSpacer.empty(),
          //End of discount
          //showing the delivery fee
          AmountTile(
            label: CartStrings.deliveryFee,
            labelTextStyle: AppTextStyle.h5TitleTextStyle(
              color: AppColor.textColor(context),
            ),
            amount:
                "+ ${viewModel.currency.symbol} ${PriceUtils.intoDecimalPlaces(viewModel.deliveryFee)}",
            amountTextStyle: AppTextStyle.h3TitleTextStyle(
              color: AppColor.textColor(context),
            ),
          ),

          UiSpacer.divider(),

          AmountTile(
            label: CartStrings.totalAmount,
            labelTextStyle: AppTextStyle.h5TitleTextStyle(
              color: AppColor.textColor(context),
            ),
            amount:
                "${viewModel.currency.symbol} ${PriceUtils.intoDecimalPlaces(viewModel.totalAmount)}",
            amountTextStyle: AppTextStyle.h3TitleTextStyle(
              color: AppColor.textColor(context),
            ),
          ),
        ],
      ),
    );
  }

  bool hasDiscount() => viewModel.discountAmount > 0;
}
