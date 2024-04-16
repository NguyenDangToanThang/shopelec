
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:shopelec/data/app_exeptions.dart';
import 'package:shopelec/data/network/BaseApiServices.dart';

class NetworkApiService extends BaseApiServices {
  @override
  Future getPostApiResponse(String url , dynamic data) async {
    dynamic responseJson;
    try{
      Response response = await post(
        Uri.parse(url),
        body: data
      ).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);

    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }
  @override
  Future getGetApiResponse(String url) async{
    dynamic responseJson;
    try{

      final response = await get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);

    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }

  dynamic returnResponse(Response response) {
    switch(response.statusCode) {
      case 200:
        if(response.body.isNotEmpty) {
          dynamic responseJson = jsonDecode(response.body);
          return responseJson;
        }
      case 400:
        throw BadRequestException(response.body.toString());
      case 404:
        throw UnauthorisedException(response.body.toString());
      default:
        throw FetchDataException("Error accured while communicating with server with status code: ${response.statusCode}");
    }
  }



}