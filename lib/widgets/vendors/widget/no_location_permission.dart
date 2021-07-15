import 'package:flutter/material.dart';
import 'package:kushmarkets/constants/app_images.dart';
import 'package:kushmarkets/constants/app_text_styles.dart';
import 'package:kushmarkets/constants/strings/general.strings.dart';
import 'package:kushmarkets/data/models/state_data_model.dart';
import 'package:kushmarkets/viewmodels/main_home.viewmodel.dart';
import 'package:kushmarkets/widgets/state/state_loading_data.dart';
import 'package:kushmarkets/translations/general.i18n.dart';
import 'package:velocity_x/velocity_x.dart';

class NoLocationPermission extends StatelessWidget {
  const NoLocationPermission({this.model, Key key}) : super(key: key);

  final MainHomeViewModel model;
  @override
  Widget build(BuildContext context) {
    return LoadingStateDataView(
      stateDataModel: StateDataModel(
        title: GeneralStrings.noLocationPermissionTitle,
        titleStyle: context.textTheme.bodyText1,
        description: GeneralStrings.noLocationPermissionDescription,
        descriptionStyle: context.textTheme.bodyText2,
        showActionButton: true,
        imageAssetPath: AppImages.ic_location,
        actionButtonStyle: AppTextStyle.h4TitleTextStyle(
          color: Colors.red,
        ),
        actionButtonTitle: "Enable Location".i18n,
        actionFunction: model.requestLocationPermission,
      ),
    );
  }
}
