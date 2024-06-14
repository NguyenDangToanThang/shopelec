import 'package:shopelec/data/network/BaseApiServices.dart';
import 'package:shopelec/data/network/NetworkApiService.dart';
import 'package:shopelec/res/app_url.dart';

class AddressRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> getAllAddressByUserId(String userId) async {
    try {
      dynamic response = await _apiServices
          .getGetApiResponse("${AppUrl.addressEndPoint}/$userId");
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getAddressActive(String userId) async {
    try {
      dynamic response = await _apiServices
          .getGetApiResponse("${AppUrl.addressEndPoint}/getActive/$userId");
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> createAddress(dynamic data) async {
    try {
      dynamic response = await _apiServices
         .getPostApiResponse(AppUrl.addressEndPoint, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> setActive(dynamic data) async {
    try {
      await _apiServices.getPostApiResponse(
          AppUrl.setActiveAddressEndpoint, data);
    } catch (e) {
      rethrow;
    }
  }
}
