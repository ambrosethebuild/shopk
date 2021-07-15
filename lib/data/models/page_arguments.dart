import 'package:kushmarkets/data/models/product.dart';
import 'package:kushmarkets/data/models/vendor.dart';

class PageArguments {
  final Product product;
  final Vendor vendor;

  PageArguments({
    this.product,
    this.vendor,
  });
}
