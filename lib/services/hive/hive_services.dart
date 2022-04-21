import 'package:hive/hive.dart';
import 'package:zartek_machine_test/models/hive/order_model.dart';

class HiveService {
  static Box<OrderModel> getOrderBox() => Hive.box("carted_orders");
}
