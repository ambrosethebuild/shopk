import 'package:flutter/material.dart';
import 'package:kushmarkets/constants/app_images.dart';
import 'package:kushmarkets/constants/app_paddings.dart';
import 'package:kushmarkets/constants/app_text_styles.dart';
import 'package:kushmarkets/constants/strings/home/vendors.strings.dart';
import 'package:kushmarkets/data/models/state_data_model.dart';
import 'package:kushmarkets/utils/ui_spacer.dart';
import 'package:kushmarkets/viewmodels/main_home.viewmodel.dart';
import 'package:kushmarkets/widgets/listview/animated_vendor_list_view_item.dart';
import 'package:kushmarkets/widgets/shimmers/vendor_shimmer_list_view_item.dart';
import 'package:kushmarkets/widgets/state/state_loading_data.dart';
import 'package:kushmarkets/widgets/vendors/widget/no_location_permission.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:kushmarkets/translations/home/home.i18n.dart';

class NearByVendors extends StatelessWidget {
  final MainHomeViewModel model;
  const NearByVendors({
    this.model,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      //check if location is avalilable
      child: model.isLocationAvailable
          ? Container(
              width: double.infinity,
              height: model.busy(model.nearbyVendors)
                  ? 180
                  : model.hasErrorForKey(model.nearbyVendors)
                      ? 250
                      : 350,
              child: model.busy(model.nearbyVendors)
                  //the loadinng shimmer
                  ? Padding(
                      padding: AppPaddings.defaultPadding(),
                      child: VendorShimmerListViewItem(),
                    )
                  // the faild view
                  : model.hasErrorForKey(model.nearbyVendors)
                      ? LoadingStateDataView(
                          stateDataModel: StateDataModel(
                            showActionButton: true,
                            actionButtonStyle: AppTextStyle.h4TitleTextStyle(
                              color: Colors.red,
                            ),
                            actionFunction: () => model.getNearbyVendors(),
                          ),
                        )
                      // the vendors list
                      : model.nearbyVendors.length > 0
                          ? ListView.separated(
                              padding: AppPaddings.defaultPadding(),
                              separatorBuilder: (context, index) =>
                                  UiSpacer.horizontalSpace(),
                              scrollDirection: Axis.horizontal,
                              itemCount: model.nearbyVendors.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.80,
                                  // width: double.infinity,
                                  child: AnimatedVendorListViewItem(
                                    index: index,
                                    vendor: model.nearbyVendors[index],
                                  ),
                                );
                              },
                            )
                          : LoadingStateDataView(
                              stateDataModel: StateDataModel(
                                title: VendorsStrings.noNearbyVendorsTitle.i18n,
                                titleStyle: AppTextStyle.h3TitleTextStyle(
                                  color: context.textTheme.bodyText1.color
                                ),
                                description:
                                    VendorsStrings.noNearbyVendorsDescription.i18n,
                                descriptionStyle:
                                    AppTextStyle.h5TitleTextStyle(
                                      color: context.textTheme.bodyText1.color
                                    ),
                                showActionButton: false,
                                imageAssetPath: AppImages.ic_location,
                              ),
                            ),
            )
          : NoLocationPermission(model: model),
    );
  }
}
