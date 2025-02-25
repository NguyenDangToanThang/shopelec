import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shopelec/model/category.dart';
import 'package:shopelec/model/product.dart';
import 'package:shopelec/model/review.dart';
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

  Future<void> deleteFavorite(String userId, int productId) async {
    try {
      await _myRepo.deleteFavorite(userId, productId);
    } catch (e) {
      logger.e(e);
    }
  }

  Future<void> saveFavorite(String userId, int productId) async {
    try {
      Map<String, dynamic> data = {
        "user_id": userId.toString(),
        "product_id": productId.toString()
      };
      await _myRepo.saveFavorite(data);
    } catch (e) {
      logger.e(e);
    }
    notifyListeners();
  }

  Future<List<Product>> getTopProduct(String userId) async {
    try {
      final jsonList = await _myRepo.getTopProduct(userId);
      List<Product> products = parseProducts(jsonList['products']);

      return products;
    } catch (e) {
      throw Exception("Failed to fetch products: $e");
    }
  }

  Future<List<Product>> getAllProducts(
      {int? categoryId,
      String? userId,
      int? brandId,
      int page = 0,
      int size = 4,
      List<String>? sort,
      String? query = ""}) async {
    try {
      // ignore: prefer_typing_uninitialized_variables
      final jsonList;
      if (categoryId != null && brandId != null) {
        jsonList = await _myRepo.getAllProduct(
            userId: userId,
            page: page,
            size: size,
            query: query,
            sort: ["id", "desc"],
            categoryId: categoryId,
            brandId: brandId);
      } else if (categoryId != null) {
        jsonList = await _myRepo.getAllProduct(
            userId: userId,
            query: query,
            page: page,
            size: size,
            sort: ["id", "desc"],
            categoryId: categoryId);
      } else if (brandId != null) {
        jsonList = await _myRepo.getAllProduct(
            userId: userId,
            page: page,
            query: query,
            size: size,
            sort: ["id", "desc"],
            brandId: brandId);
      } else {
        jsonList = await _myRepo.getAllProduct(
            query: query,
            userId: userId,
            page: page,
            size: size,
            sort: ["id", "desc"]);
      }
      List<Product> products = parseProducts(jsonList['products']);

      return products;
    } catch (e) {
      throw Exception("Failed to fetch products: $e");
    }
  }

  Future<List<Product>> getAllFavoriteProductByUserId(String userId) async {
    try {
      final jsonList = await _myRepo.getAllFavoriteByUserId(userId);
      List<Product> productList = [];
      for (var json in jsonList) {
        productList.add(Product.fromMap(json['productResponse']));
      }
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
      throw Exception("Failed to fetch categories: $e");
    }
  }

  double averageRatingWithStar(Product product, double star) {
    List<Review> reviews =
        product.reviews.where((review) => review.rate == star).toList();
    double total = 0.0;
    for (Review review in reviews) {
      total += review.rate;
    }
    if (total > 0.0) {
      total = total / reviews.length;
    }
    return total;
  }

  double averageRating(Product product) {
    List<Review> reviews = product.reviews;
    double total = 0.0;
    for (Review review in reviews) {
      total += review.rate;
    }
    if (total > 0.0) {
      total = total / reviews.length;
    }
    return total;
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
