import 'package:shopelec/data/network/BaseApiServices.dart';
import 'package:shopelec/data/network/NetworkApiService.dart';
import 'package:shopelec/res/app_url.dart';

class ProductRespository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> getAllProduct() async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(AppUrl.getAllProductEndPoint);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
