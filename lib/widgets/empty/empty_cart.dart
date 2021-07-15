import 'package:flutter/material.dart';
import 'package:kushmarkets/constants/app_color.dart';
import 'package:kushmarkets/constants/app_images.dart';
import 'package:kushmarkets/constants/app_paddings.dart';
import 'package:kushmarkets/constants/app_text_styles.dart';
import 'package:kushmarkets/constants/strings/cart.strings.dart';
import 'package:kushmarkets/utils/ui_spacer.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPaddings.defaultPadding(),
      child: ListView(
        children: <Widget>[
          Image.asset(
            AppImages.emptyCart,
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          UiSpacer.verticalSpace(),
          Center(
            child: Text(
              CartStrings.emptyTitle,
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
              CartStrings.emptyBody,
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
