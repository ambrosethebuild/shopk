import 'package:flutter/material.dart';
import 'package:kushmarkets/constants/app_sizes.dart';
import 'package:kushmarkets/data/models/menu.dart';
import 'package:kushmarkets/data/models/vendor.dart';
import 'package:kushmarkets/data/repositories/vendor.repository.dart';
import 'package:kushmarkets/viewmodels/base.viewmodel.dart';

class VendorPageViewModel extends MyBaseViewModel {
  //scroll page details
  ScrollController vendorPageStrollController = new ScrollController();
  //show the empty space between the appbar and the tab with its reach top
  bool makeAppBarTransparent = true;

  //Vendor repository
  VendorRepository _vendorRepository = VendorRepository();

  //menus of the vendor
  List<Menu> menus = [];

  //Vendor model
  Vendor vendor;

  VendorPageViewModel(this.vendor);

  initialise() {
    vendorPageStrollController.addListener(updateAppBarBackgroundColor);
    getDetails();
  }

  //
  getDetails() async {
    setBusy(true);
    try {
      vendor = await _vendorRepository.getVendorDetails(vendorId: vendor.id);
      menus = vendor.menus;
      vendorPageStrollController.notifyListeners();
    } catch (error) {
      setError(error);
    }
    setBusy(false);
  }

  //listen to when user scroll to the level when the vendor feature image isn't visible
  //then add background to the appbar else make it transparent
  void updateAppBarBackgroundColor() {
    if (vendorPageStrollController.offset >=
        AppSizes.vendorPageHeaderCollapseHeight) {
      if (makeAppBarTransparent) {
        makeAppBarTransparent = !makeAppBarTransparent;
      }
    } else {
      if (!makeAppBarTransparent) {
        makeAppBarTransparent = !makeAppBarTransparent;
      }
    }

    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    vendorPageStrollController.dispose();
  }
}
