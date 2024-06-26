import 'package:shopelec/data/network/BaseApiServices.dart';
import 'package:shopelec/data/network/NetworkApiService.dart';
import 'package:shopelec/res/app_url.dart';

class ProductRespository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> getAllFavoriteByUserId(String userId) async {
    try {
      String url = "${AppUrl.favoriteEndpoint}?user_id=$userId";
      dynamic response = await _apiServices.getGetApiResponse(url);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> deleteFavorite(String userId, int productId) async {
    try {
      String url =
          "${AppUrl.deleteFavoriteEndPoint}?user_id=$userId&product_id=$productId";
      dynamic response = await _apiServices.getGetApiResponse(url);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> saveFavorite(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.favoriteEndpoint, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getAllProduct(
      {String? userId,
      int? categoryId,
      int? brandId,
      int? page,
      int? size,
      List<String>? sort,
      String? query}) async {
    try {
      String url = "${AppUrl.getAllProductEndPoint}?";
      if (userId != null) {
        url += "&user_id=$userId";
      }
      if (query != null || query != "") {
        url += "&query=$query";
      }
      if (page != null) {
        url += "&page=$page";
      }
      if (size != null) {
        url += "&size=$size";
      }
      if (categoryId != null) {
        url += "&category_id=$categoryId";
      }
      if (brandId != null) {
        url += "&brand_id=$brandId";
      }
      if (sort != null && sort.isNotEmpty) {
        url += "&sort=${sort.join(',')}";
      }
      dynamic response = await _apiServices.getGetApiResponse(url);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getAllBrand() async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrl.getAllBrandEndPoint);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getAllCategory() async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrl.getAllCategoryEndPoint);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
