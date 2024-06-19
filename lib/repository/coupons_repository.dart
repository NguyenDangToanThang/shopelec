import 'package:shopelec/data/network/BaseApiServices.dart';
import 'package:shopelec/data/network/NetworkApiService.dart';
import 'package:shopelec/res/app_url.dart';

class CouponsRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> getAllCoupons(double totalPayment) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          "${AppUrl.couponsEndpoint}?totalPayment=$totalPayment");
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> checkCoupons(String code,double totalPayment) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          "${AppUrl.couponsEndpoint}/checkCoupons?totalPayment=$totalPayment&code=$code");
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
