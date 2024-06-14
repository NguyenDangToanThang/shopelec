import 'package:shopelec/data/network/BaseApiServices.dart';
import 'package:shopelec/data/network/NetworkApiService.dart';
import 'package:shopelec/res/app_url.dart';

class AuthRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> registerApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          AppUrl.registerApiEndPoint, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getMyInfoApi(String id) async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse("${AppUrl.getMyInfoEndPoint}?id=$id");
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> updateUserApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          AppUrl.updateUserEndPoint, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
