import 'package:shopelec/data/network/BaseApiServices.dart';
import 'package:shopelec/data/network/NetworkApiService.dart';
import 'package:shopelec/res/app_url.dart';

class RateRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> saveRate(dynamic data) async {
    try {
      await _apiServices.getPostApiResponse(AppUrl.saveRateEndpoint, data);
    } catch (e) {
      rethrow;
    }
  }
}
