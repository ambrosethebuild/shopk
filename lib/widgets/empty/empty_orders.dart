import 'package:flutter/material.dart';
import 'package:kushmarkets/constants/app_color.dart';
import 'package:kushmarkets/constants/app_images.dart';
import 'package:kushmarkets/constants/app_paddings.dart';
import 'package:kushmarkets/constants/app_text_styles.dart';
import 'package:kushmarkets/constants/strings/order.strings.dart';

class EmptyOrders extends StatelessWidget {
  const EmptyOrders({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPaddings.defaultPadding(),
      child: ListView(
        children: <Widget>[
          Image.asset(
            AppImages.emptyOrder,
            height: MediaQuery.of(context).size.height * 0.3,
          ),
          Center(
            child: Text(
              OrderStrings.emptyOrderTitle,
              style: AppTextStyle.h4TitleTextStyle(
                color: AppColor.textColor(context),
              ),
              
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              OrderStrings.emptyOrderBody,
              style: AppTextStyle.h5TitleTextStyle(
                color: AppColor.textColor(context),
              ),
              textAlign: TextAlign.center,
              
            ),
          ),
        ],
      ),
    );
  }
}
