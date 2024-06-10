import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shopelec/model/category.dart';
import 'package:shopelec/model/product.dart';
import 'package:shopelec/repository/product_repository.dart';
import 'package:shopelec/model/brand.dart';

class ProductViewModel with ChangeNotifier {
  final _myRepo = ProductRespository();
  final logger = Logger();

  List<Brand> _brands = List.empty();
  List<Brand> get brands => _brands;

  List<Category> _categories = List.empty();
  List<Category> get categories => _categories;

  setBrands(List<Brand> value) {
    _brands = value;
    notifyListeners();
  }

  setCategories(List<Category> value) {
    _categories = value;
    notifyListeners();
  }

  Future<void> deleteFavorite(int userId, int productId) async {
    try {
      await _myRepo.deleteFavorite(userId, productId);
    } catch (e) {
      logger.e(e);
    }
  }

  Future<void> saveFavorite(int userId, int productId) async {
    try {
      Map<String, dynamic> data = {
        "user_id": userId.toString(),
        "product_id": productId.toString()
      };
      await _myRepo.saveFavorite(data);
    } catch (e) {
      logger.e(e);
    }
  }

  Future<List<Product>> getAllProducts(
      {int? categoryId,
      int? userId,
      int? brandId,
      int page = 0,
      int size = 4,
      List<String>? sort}) async {
    try {
      // ignore: prefer_typing_uninitialized_variables
      final jsonList;
      if (categoryId != null && brandId != null) {
        jsonList = await _myRepo.getAllProduct(
            userId: userId,
            page: page,
            size: size,
            sort: ["id", "desc"],
            categoryId: categoryId,
            brandId: brandId);
      } else if (categoryId != null) {
        jsonList = await _myRepo.getAllProduct(
            userId: userId,
            page: page,
            size: size,
            sort: ["id", "desc"],
            categoryId: categoryId);
        logger.i("Json: $jsonList");
      } else if (brandId != null) {
        jsonList = await _myRepo.getAllProduct(
            userId: userId,
            page: page,
            size: size,
            sort: ["id", "desc"],
            brandId: brandId);
      } else {
        jsonList = await _myRepo.getAllProduct(
            userId: userId, page: page, size: size, sort: ["id", "desc"]);
      }
      List<Product> products = parseProducts(jsonList['products']);

      // logger.i("Total products: ${jsonList['totalItems']}");
      // logger.i("Total pages: ${jsonList['totalPages']}");
      // logger.i("Current page: ${jsonList['currentPage']}");

      return products;
    } catch (e) {
      logger.e(e);
      throw Exception("Failed to fetch products: $e");
    }
  }

  Future<List<Product>> getAllFavoriteProductByUserId(int userId) async {
    try {
      final jsonList = await _myRepo.getAllFavoriteByUserId(userId);
      logger.i(jsonList[0]);
      List<Product> productList = [];
      for (var json in jsonList) {
        productList.add(Product.fromMap(json['productResponse']));
      }
      // logger.i(productList);
      return productList;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Brand>> getAllBrands() async {
    try {
      final jsonList = await _myRepo.getAllBrand();
      List<Brand> brands = parseBrands(jsonList);
      if (brands.isNotEmpty) {
        setBrands(brands);
      }
      return brands;
    } catch (e) {
      logger.e(e);
      throw Exception("Failed to fetch brands: $e");
    }
  }

  Future<List<Category>> getAllCategories() async {
    try {
      final jsonList = await _myRepo.getAllCategory();
      List<Category> categories = parseCategories(jsonList);
      if (categories.isNotEmpty) {
        setCategories(categories);
      }
      return categories;
    } catch (e) {
      logger.e(e);
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
