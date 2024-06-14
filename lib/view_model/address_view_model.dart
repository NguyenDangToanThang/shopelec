import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shopelec/model/address.dart';
import 'package:shopelec/repository/address_repository.dart';
import 'package:shopelec/utils/routes/routes_name.dart';

class AddressViewModel with ChangeNotifier {
  final _myRepo = AddressRepository();
  final logger = Logger();

  Future<List<Address>> getAddressByUserId(String userId) async {
    final jsonList;
    try {
      jsonList = await _myRepo.getAllAddressByUserId(userId);
      logger.i(jsonList);
      List<Address> response = parseAddresses(jsonList);
      logger.i(response);
      return response;
    } catch (e) {
      logger.e(e.toString());
      throw Exception("Failed to fetch addresses: $e");
    }
  }

  Future<Address> getAddressActive(String userId) async {
    try {
      final json = await _myRepo.getAllAddressByUserId(userId);
      // logger.i(json);
      dynamic response;
      for (var item in json) {
        if (item['selected']) {
          response = Address(
              id: item['id'],
              user_id: item['user_id'],
              address: item['address'],
              isSelected: item['selected'],
              name: item['name'],
              phone: item['phoneNumber']);
        }
      }
      return response;
    } catch (e) {
      logger.e(e.toString());
      throw Exception("Failed to fetch addresses: $e");
    }
  }

  Future<dynamic> saveAddress(dynamic data, BuildContext context) async {
    try {
      // logger.i(data);
      await _myRepo.createAddress(data).then((value) {
        // logger.i(value);
        // Utils.flushBarSuccessMessage("Thêm mới địa chỉ thành công", context);
        Navigator.pushReplacementNamed(context, RoutesName.address);
      });
    } catch (e) {
      logger.e(e.toString());
      throw Exception("Failed saving address");
    }
  }

  Future<void> setActiveAddress(dynamic data) async {
    try {
      await _myRepo.setActive(data);
    } catch (e) {
      logger.e(e.toString());
      throw Exception("Failed to set active address: $e");
    }
  }

  List<Address> parseAddresses(dynamic jsonList) {
    final List<dynamic> addressList = jsonList as List<dynamic>;
    return addressList.map((json) => Address.fromMap(json)).toList();
  }
}
