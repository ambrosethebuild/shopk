import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:kushmarkets/bloc/delivery_addresses.bloc.dart';
import 'package:kushmarkets/constants/app_color.dart';
import 'package:kushmarkets/constants/app_routes.dart';
import 'package:kushmarkets/constants/app_text_styles.dart';
import 'package:kushmarkets/constants/strings/checkout.strings.dart';
import 'package:kushmarkets/constants/strings/general.strings.dart';
import 'package:kushmarkets/data/models/deliver_address.dart';
import 'package:kushmarkets/utils/custom_dialog.dart';
import 'package:kushmarkets/widgets/buttons/custom_button.dart';
import 'package:kushmarkets/widgets/delivery_address/delivery_address_item.dart';
import 'package:kushmarkets/widgets/empty/empty_delivery_address.dart';
import 'package:kushmarkets/widgets/shimmers/general_shimmer_list_view_item.dart';

class DeliverTo extends StatefulWidget {
  DeliverTo({
    Key key,
    this.onSubmit,
    this.vendorId,
  }) : super(key: key);

  final Function(DeliveryAddress) onSubmit;
  final int vendorId;

  @override
  _DeliverToState createState() => _DeliverToState();
}

class _DeliverToState extends State<DeliverTo> {
  //delivery address bloc
  DeliveryAddressBloc _deliveryAddressBloc = DeliveryAddressBloc();

  @override
  void initState() {
    super.initState();

    _deliveryAddressBloc.vendorId = widget.vendorId;
    _deliveryAddressBloc.initBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //make if fill 60% of the screen
      height: MediaQuery.of(context).size.height * 0.50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        
        children: <Widget>[
          //manage delivery address
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            
            children: <Widget>[
              //sort by section
              Expanded(
                child: Text(
                  CheckoutStrings.deliverTo,
                  style: AppTextStyle.h3TitleTextStyle(
                    color: AppColor.textColor(context),
                  ),
                  
                ),
              ),
              SizedBox(
                width: 20,
              ),
              //add delivery address
              CustomButton(
                padding: EdgeInsets.all(5),
                child: Row(
                  children: <Widget>[
                    Icon(
                      AntDesign.plus,
                      size: 18,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      GeneralStrings.addNew,
                      style: AppTextStyle.h4TitleTextStyle(
                        color: Colors.white,
                      ),
                      
                    ),
                  ],
                ),
                color: AppColor.accentColor,
                onPressed: _addNewDeliveryAddress,
              ),
            ],
          ),
          Divider(),
          //body
          // UiSpacer.verticalSpace(space: 20),
          Expanded(
            child: StreamBuilder<List<DeliveryAddress>>(
              stream: _deliveryAddressBloc.deliveryAddresses,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return EmptyDeliveryAddresses();
                } else if (!snapshot.hasData) {
                  return GeneralShimmerListViewItem();
                } else if (snapshot.data.length == 0) {
                  return EmptyDeliveryAddresses();
                }

                return ListView.separated(
                  itemBuilder: (context, index) {
                    return DeliveryAddressItem(
                      deliveryAddress: snapshot.data[index],
                      onPressed: _onDeliveryAddressSelected,
                    );
                  },
                  separatorBuilder: (context, index) => Divider(height: 1),
                  itemCount: snapshot.data.length,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _onDeliveryAddressSelected(DeliveryAddress selectedDeliveryAddres) {
    CustomDialog.dismissDialog(context);
    widget.onSubmit(selectedDeliveryAddres);
  }

  void _addNewDeliveryAddress() async {
    //add the newly selected delivery address to user account on the server
    CustomDialog.dismissDialog(context);
    Navigator.pushNamed(
      context,
      AppRoutes.newDeliveryAddressRoute,
    );
  }
}
