import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopelec/data/network/BaseApiServices.dart';
import 'package:shopelec/data/network/NetworkApiService.dart';
import 'package:shopelec/res/app_url.dart';

class TokenFCMRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  User? user = FirebaseAuth.instance.currentUser;

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('device_token', token);
  }

  Future<void> sendTokenToServer(String token) async {
    if (user != null) {
      Map data = {'token': token, 'userId': user!.uid};
      try {
        await _apiServices.getPostApiResponse(
            AppUrl.saveOrUpdateTokenFCMEndpoint, data);
      } catch (e) {
        rethrow;
      }
    }
  }
}
