import 'package:flutter/material.dart';
import 'package:shopelec/model/brand.dart';
import 'package:shopelec/model/category.dart';
import 'package:shopelec/model/product.dart';
import 'package:shopelec/repository/product_repository.dart';

class StoreViewModel with ChangeNotifier {
  final _myRepo = ProductRespository();

  List<Brand> brands = [];
  List<Category> categories = [];

  StoreViewModel() {
    initData().whenComplete((){
      bool checkAllCategories =
        categories.any((category) => category.id == 0);
    if (!checkAllCategories) {
      categories.insert(0, Category(id: 0, name: "Tất cả"));
    }
    bool checkAllBrands = brands.any((item) => item.id == 0);
    if (!checkAllBrands) {
      brands.insert(0, const Brand(id: 0, name: "Tất cả"));
    }
    });
  }

  Future<void> initData() async {
    brands = await getAllBrands();
    categories = await getAllCategories();
  }

  Future<List<Brand>> getAllBrands() async {
    try {
      final jsonList = await _myRepo.getAllBrand();
      List<Brand> brands = parseBrands(jsonList);
      return brands;
    } catch (e) {
      throw Exception("Failed to fetch brands: $e");
    }
  }

  Future<List<Category>> getAllCategories() async {
    try {
      final jsonList = await _myRepo.getAllCategory();
      List<Category> categories = parseCategories(jsonList);
      return categories;
    } catch (e) {
      throw Exception("Failed to fetch categories: $e");
    }
  }

  List<Product> parseProducts(dynamic jsonList) {
    final List<dynamic> productList = jsonList as List<dynamic>;
    return productList
        .map((json) => Product.fromMap(json as Map<String, dynamic>))
        .toList();
  }

  List<Brand> parseBrands(dynamic jsonList) {
    final List<dynamic> brandList = jsonList as List<dynamic>;
    return brandList
        .map((json) => Brand.fromMap(json as Map<String, dynamic>))
        .toList();
  }

  List<Category> parseCategories(dynamic jsonList) {
    final List<dynamic> categoryList = jsonList as List<dynamic>;
    return categoryList
        .map((json) => Category.fromMap(json as Map<String, dynamic>))
        .toList();
  }
}
