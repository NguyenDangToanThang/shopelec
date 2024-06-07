import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shopelec/model/cart.dart';
import 'package:shopelec/repository/cart_repository.dart';
import 'package:shopelec/utils/utils.dart';

class CartViewModel with ChangeNotifier {
  final _myRepo = CartRepository();
  final logger = Logger();

  Future<dynamic> addToCart(dynamic cart, BuildContext context) async {
    try {
      await _myRepo.addToCart(cart);
      Utils.flushBarSuccessMessage("Thêm vào giỏ hàng thành công", context);
    } catch (e) {
      Utils.flushBarErrorMessage(e.toString(), context);
      logger.e(e.toString());
    }
  }

  Future<List<Cart>> getAllCartByUserId(
      dynamic id, BuildContext context) async {
    final json;
    try {
      json = await _myRepo.getAllCartByUserId(id);
      logger.i(json);
      List<Cart> carts = parseCarts(json);
      logger.i(carts);
      return carts;
    } catch (e) {
      Utils.flushBarErrorMessage(e.toString(), context);
      throw Exception("Failed to fetch carts: $e");
    }
  }

  List<Cart> parseCarts(dynamic jsonList) {
    final List<dynamic> carts = jsonList as List<dynamic>;
    return carts
        .map((json) => Cart.fromMap(json as Map<String, dynamic>))
        .toList();
  }
}
