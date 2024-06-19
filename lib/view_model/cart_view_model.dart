import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shopelec/model/cart.dart';
import 'package:shopelec/repository/cart_repository.dart';
import 'package:shopelec/utils/utils.dart';

class CartViewModel with ChangeNotifier {
  final _myRepo = CartRepository();
  final logger = Logger();


  List<Cart> _carts = List.empty();
  List<Cart> get carts => _carts;

  setCart(List<Cart> list) {
    _carts = list;
    notifyListeners();
  }

  setCartIndex(int index, Cart cart) {
    _carts[index] = cart;
    notifyListeners();
  }

  

  Future<dynamic> setQuantityInCart(int quantity, int id) async {
    try {
      await _myRepo.setQuantityInCarts(quantity, id);
    } catch (e) {
      // Utils.flushBarErrorMessage(e.toString(), context);
      logger.e(e.toString());
    }
  }

  Future<dynamic> removeFromCart(Cart cart) async {
    try {
      await _myRepo.deleteCartById(cart.id);
      carts.remove(cart);
      notifyListeners();
    } catch (e) {
      logger.e(e.toString());
    }
  }

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
      // logger.i(json);
      List<Cart> carts = parseCarts(json);
      // logger.i(carts);
      setCart(carts);
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
