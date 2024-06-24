import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:shopelec/model/order.dart';
import 'package:shopelec/repository/order_repository.dart';

class OrderViewModel with ChangeNotifier {
  final _myRepo = OrderRepository();
  final logger = Logger();

  Future<dynamic> saveOrder(dynamic data) async {
    try {
      bool save = await _myRepo.saveOrder(data);
      return save;
    } catch (e) {
      logger.e(e);
    }
  }


  Future<dynamic> updateStatusOrder(int orderId, String status) async {
    try {
      await _myRepo.updateStatus(orderId, status);
    } catch (e) {
      logger.e(e);
    }
  }

  Future<dynamic> getOrdersByUserIdAndStatus(String status) async {
    try {
      dynamic json = await _myRepo.getOrderByStatusAndUserId(
          FirebaseAuth.instance.currentUser!.uid, status);
      List<Order> orders = parseOrders(json);
      return orders;
    } catch (e) {
      logger.e(e);
    }
  }

  List<Order> parseOrders(dynamic jsonList) {
    final List<dynamic> orders = jsonList as List<dynamic>;
    return orders
        .map((json) => Order.fromMap(json as Map<String, dynamic>))
        .toList();
  }
}
