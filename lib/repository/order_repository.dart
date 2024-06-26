import 'package:shopelec/data/network/BaseApiServices.dart';
import 'package:shopelec/data/network/NetworkApiService.dart';
import 'package:shopelec/res/app_url.dart';

class OrderRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> saveOrder(dynamic data) async {
    try {
      bool response =
          await _apiServices.getPostApiResponse(AppUrl.orderEndpoint, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> updateStatus(int orderId, String status) async {
    try {
      String url =
          "${AppUrl.orderUpdateStatusEndpoint}?status=$status&orderId=$orderId";
      await _apiServices.getGetApiResponse(url);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getOrderByStatusAndUserId(
      String userId, String status) async {
    try {
      String url = "${AppUrl.orderEndpoint}?status=$status&user_id=$userId";
      dynamic response = await _apiServices.getGetApiResponse(url);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getAllOrderDetailByOrderId(int orderId) async {
    try {
      String url = "${AppUrl.orderEndpoint}/getOrderDetails?orderId=$orderId";
      dynamic response = await _apiServices.getGetApiResponse(url);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
