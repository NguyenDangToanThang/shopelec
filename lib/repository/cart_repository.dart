import 'package:shopelec/data/network/BaseApiServices.dart';
import 'package:shopelec/data/network/NetworkApiService.dart';
import 'package:shopelec/res/app_url.dart';

class CartRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> addToCart(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.addToCartEndPoint, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> deleteCartById(int id) async {
    try {
      String url = '${AppUrl.deleteCartByCartId}?id=$id';
      await _apiServices.getGetApiResponse(url);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> setQuantityInCarts(int quantity, int id) async {
    try {
      String url = '${AppUrl.setQuantityInCart}?id=$id&quantity=$quantity';
      await _apiServices.getGetApiResponse(url);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getAllCartByUserId(dynamic id) async {
    try {
      dynamic response = await _apiServices
          .getGetApiResponse('${AppUrl.getAllCartByUserId}/$id');
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
