import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shopelec/model/product.dart';
import 'package:shopelec/repository/product_repository.dart';

class ProductViewModel with ChangeNotifier {
  final _myRepo = ProductRespository();
  final logger = Logger();
  List<Product> _products = List.empty();
  List<Product> get products => _products;
  setproducts(List<Product> value) {
    _products = value;
    notifyListeners();
  }

  Future<List<Product>> getAllProducts() async {
    try {
      final jsonList = await _myRepo.getAllProduct();
      List<Product> products = parseProducts(jsonList);
      if (products.isNotEmpty) {
        setproducts(products);
      }
      return products;
    } catch (e) {
      logger.e(e);
      throw Exception("Failed to fetch products: $e");
    }
  }

  List<Product> parseProducts(dynamic jsonList) {
    final List<dynamic> productList = jsonList as List<dynamic>;
    return productList
        .map((json) => Product.fromMap(json as Map<String, dynamic>))
        .toList();
  }
}
