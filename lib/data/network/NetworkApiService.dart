import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:shopelec/data/app_exeptions.dart';
import 'package:shopelec/data/network/BaseApiServices.dart';

class NetworkApiService extends BaseApiServices {
  final headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept-Charset': 'UTF-8',
  };
  @override
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    try {
      Response response = await post(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: headers,
      ).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("Mất kết nối");
    }
    return responseJson;
  }

  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;
    try {
      final response = await get(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("Mất kết nối");
    }
    return responseJson;
  }

  @override
  Future getMultipartApiResponse(String url, File image) async {
    // dynamic responseJson;
    try {
      var request = MultipartRequest('POST', Uri.parse(url));
      request.fields['id'] = FirebaseAuth.instance.currentUser!.uid;
      request.files.add(await MultipartFile.fromPath(
        'avatar',
        image.path,
      ));
      final response = await request.send();
      if (response.statusCode == 200) {
        print('Image uploaded successfully.');
      } else {
        print('Image upload failed with status: ${response.statusCode}');
      }
    } on SocketException {
      throw FetchDataException("Mất kết nối");
    }
    // return responseJson;
  }

  dynamic returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        if (response.body.isNotEmpty) {
          dynamic responseJson = jsonDecode(utf8.decode(response.bodyBytes));
          return responseJson;
        }
      case 400:
        throw BadRequestException(response.body.toString());
      case 404:
        throw UnauthorisedException(response.body.toString());
      default:
        throw FetchDataException(
            "Lỗi khi liên lạc với máy chủ bằng mã trạng thái: ${response.statusCode}");
    }
  }
}
