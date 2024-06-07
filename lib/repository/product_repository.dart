import 'package:shopelec/data/network/BaseApiServices.dart';
import 'package:shopelec/data/network/NetworkApiService.dart';
import 'package:shopelec/res/app_url.dart';

class ProductRespository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> getAllProduct(
      {int? categoryId,
      int? brandId,
      int? page,
      int? size,
      List<String>? sort}) async {
    try {
      String url = "${AppUrl.getAllProductEndPoint}?";
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
