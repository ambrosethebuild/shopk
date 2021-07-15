import 'package:flutter/material.dart';
import 'package:kushmarkets/constants/app_color.dart';
import 'package:kushmarkets/constants/app_images.dart';
import 'package:kushmarkets/constants/app_paddings.dart';
import 'package:kushmarkets/constants/app_text_styles.dart';
import 'package:kushmarkets/constants/strings/checkout.strings.dart';

class NoSelectedDeliveryAddresses extends StatefulWidget {
  const NoSelectedDeliveryAddresses({Key key}) : super(key: key);

  @override
  _NoSelectedDeliveryAddressesState createState() =>
      _NoSelectedDeliveryAddressesState();
}

class _NoSelectedDeliveryAddressesState
    extends State<NoSelectedDeliveryAddresses> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPaddings.defaultPadding(),
      decoration: BoxDecoration(
        color: AppColor.primaryColor.withOpacity(0.10),
        // color: AppColor.primaryColor,
      ),
      child: Column(
        
        children: <Widget>[
          Image.asset(
            AppImages.emptyDeliveryAddress,
            width: 100,
            height: 100,
          ),
          Text(
            CheckoutStrings.emptyDeliveryAddressTitle,
            style: AppTextStyle.h4TitleTextStyle(
              color: AppColor.textColor(context),
            ),
            
          ),
          Text(
            CheckoutStrings.emptyDeliveryAddressBody,
            style: AppTextStyle.h5TitleTextStyle(
              color: AppColor.textColor(context),
            ),
            
          ),
        ],
      ),
    );
  }
}
