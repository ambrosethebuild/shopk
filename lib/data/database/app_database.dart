import 'dart:async';
import 'package:floor/floor.dart';
import 'package:kushmarkets/data/database/dao/currency_dao.dart';
import 'package:kushmarkets/data/database/dao/product_dao.dart';
import 'package:kushmarkets/data/database/dao/product_extra_dao.dart';
import 'package:kushmarkets/data/database/dao/notification_dao.dart';
import 'package:kushmarkets/data/database/dao/user_dao.dart';
import 'package:kushmarkets/data/database/dao/vendor_dao.dart';
import 'package:kushmarkets/data/models/currency.dart';
import 'package:kushmarkets/data/models/notification_model.dart';
import 'package:kushmarkets/data/models/user.dart';
import 'package:kushmarkets/data/models/vendor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:kushmarkets/data/models/product.dart';
import 'package:kushmarkets/data/models/food_extra.dart';

part 'app_database.g.dart'; // the generated code will be there

@Database(
  version: 2,
  entities: [Product, ProductExtra, User, Currency, Vendor, NotificationModel],
)
abstract class AppDatabase extends FloorDatabase {
  // DAO getters
  ProductDao get productDao;
  ProductExtraDao get productExtraDao;
  UserDao get userDao;
  CurrencyDao get currencyDao;
  VendorDao get vendorDao;
  NotificationDao get notificationDao;
}
