import 'package:flutter/material.dart';
import 'package:kushmarkets/data/models/menu.dart';
import 'package:kushmarkets/data/models/vendor.dart';
import 'package:kushmarkets/widgets/listview/product_list_view_item.dart';

class VendorMenuTabBarView extends StatefulWidget {
  VendorMenuTabBarView({
    Key key,
    @required this.menu,
    @required this.vendor,
  }) : super(key: key);

  final Menu menu;
  final Vendor vendor;

  @override
  _VendorMenuTabBarViewState createState() => _VendorMenuTabBarViewState();
}

class _VendorMenuTabBarViewState extends State<VendorMenuTabBarView> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.all(0),
      itemBuilder: (context, index) {
        return ProductListViewItem(
          product: widget.menu.products[index],
          vendor: widget.vendor,
        );
      },
      separatorBuilder: (context, index) {
        return Divider(
          height: 5,
        );
      },
      itemCount: widget.menu.products.length,
    );
  }
}
